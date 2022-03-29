import BankCardView from "../component/BankCardView/BankCardView"
import React from "react"

export default function BankCardSelector(props) {
    const [showPasswordInput, setShowPasswordInput] = React.useState(false);

    const drag = (event) => {
        event.dataTransfer.setData("BID", event.target.id); //附加一个 BID 到拖动的对象
    };

    const drop = (event) => {
        event.preventDefault();
        var data = event.dataTransfer.getData("BID"); //get BID 对象
        console.log(data);
        setShowPasswordInput(true);
    }
    const allowDrop = (event) => {
        event.preventDefault();
    };

    const closePasswordInput = (event) => {
        setShowPasswordInput(false);
    }

    return (
        <div>
            <div
                className="passwordVerify backDropDark"
                style={{
                    display: showPasswordInput ? "block" : "none",
                }}
                onClick={closePasswordInput}
            ></div>
            <div
                className="passwordVerify container"
                style={{
                    display: showPasswordInput ? "block" : "none",
                }}
            >
                <h1>请输入密码</h1>
                <input type="password" placeholder="密码"></input>
                <br />
                <button>确认</button>
            </div>
            <div className="cardSelector menu">
                <h1 className="cardSelector plz-plug-card">请插卡</h1>
                <div className="cardSelector cardSelectorList">
                    {props.cardList.map((card, index) => (
                        <div
                            className="cardSelector cardSelectorList-cardView"
                            onDragStart={drag}
                            draggable={true}
                            id={card.BID}
                            key={index}
                        >
                            <BankCardView
                                bankName={card.CardBankName}
                                cardType={card.CardType}
                                cardNumber={card.CardID}
                                cardHolder={
                                    card.CardHolderFirstName +
                                    card.CardHolderSecondName
                                }
                                expiryDate={card.CardExpiryDate}
                            />
                        </div>
                    ))}
                </div>
                <div
                    className="cardSelector cardSlot"
                    onDragOver={allowDrop}
                    onDrop={drop}
                ></div>
            </div>
        </div>
    );
}