import BankCardView from "../component/BankCardView/BankCardView"
import React from "react"
import $ from "jquery";
import "jquery-ui-dist/jquery-ui"

export default function BankCardSelector(props) {
    const [showPasswordInput, setShowPasswordInput] = React.useState(false);

    const [currentBID, setCurrentBID] = React.useState(-1);
    const drop = () => {
        var data = nowBID; //get BID 对象
        setCurrentBID(parseInt(data));
        setShowPasswordInput(true);
    }
    var nowBID = 0
    React.useEffect(() => {
        $(".bank-card-view").draggable({
            revert: "invalid",
            helper: "clone",
            cursor: "move",
            cursorAt: {
                top: 50,
                left: 50,
            },
            start: function (event) {
                nowBID = parseInt(event.target.id);
            },
        });
        $(".cardPlug").droppable({
            drop: drop
        });
    }, []);


    const closePasswordInput = (event) => {
        setShowPasswordInput(false);
    }

    const [password,setPassword] = React.useState("")
    const [passwordError, setPasswordError] = React.useState(false);


    var comfirmPassword = (event) => {
        props.cardList.forEach((card,index) => {
            if (card.BID === currentBID) {
                if (card.CardPassword === password) {
                    props.successPlugcard(card);
                } else {
                    setPasswordError(true);
                    setTimeout(() => {
                        setPasswordError(false);
                    },1000)
                }
            }
        })
    }

    return (
        <div>
            <div
                style={{
                    display: passwordError ? "block" : "none",
                    position: "absolute",
                    top: "50%",
                    left: "50%",
                    transform: "translate(-50%,-50%)",
                    backgroundColor: "red",
                    zIndex: 100000000000,
                    padding: 1000,
                }}
            >
                <h1>密码错误</h1>
            </div>
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
                <input
                    type="password"
                    value={password}
                    onChange={(event) => {
                        setPassword(event.target.value);
                    }}
                    placeholder="密码"
                ></input>
                <br />
                <button onClick={comfirmPassword}>确认</button>
            </div>
            <div className="cardSelector menu">
                <h1 className="cardSelector plz-plug-card">请插卡</h1>
                <div className="cardSelector cardSelectorList">
                    {props.cardList.map((card, index) => (
                        <div
                            className="cardSelector cardSelectorList-cardView bank-card-view"
                            // onDragStart={drag}
                            // draggable="true"
                            id={card.BID}
                            key={index}
                            style={{
                                cursor: "grab",
                            }}
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
                    className="cardSelector cardSlot cardPlug"
                    // onDragOver={allowDrop}
                    // onDrop={drop}
                >
                    (卡槽)
                </div>
            </div>
        </div>
    );
}