import BankCardView from "./component/BankCardView/BankCardView";
import React from "react"

export default function CardViewHandler() {
    const [showBankCardView, setShowBankCardView] = React.useState(false);
    const [bankCardViewData, setBankCardViewData] = React.useState({
        BID: 1,
        CardBankName: "无限银行⫗",
        CardType: "储蓄卡",
        CardID: "1000 0000 0000 0000",
        CardHolderFirstName: "张",
        CardHolderSecondName: "三",
        CardExpiryDate: "08/25",
    });
    window.addEventListener("message", (event) => {
        if (event.data.type === "showBankCardView") {
            setShowBankCardView(true);
            var tempExpDate = new Date(event.data.cardData.CardExpiryDate);
            event.data.cardData.CardExpiryDate = tempExpDate.getMonth() + "/" + tempExpDate.getFullYear().toString().substring(2,4)
            setBankCardViewData(event.data.cardData);
        }
    });
    window.onkeydown = (event) => {
        if (event.keyCode === 27) {
            setShowBankCardView(false);
            fetch(`https://wx_bank/disableCursur`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json; charset=UTF-8",
                },
            });
        }
    };
    return (
        <div
            id="cardView"
            style={{
                display: showBankCardView ? "block" : "none",
                position: "absolute",
                transform: "translate(-50%, -50%)",
                top: "50%",
                left: "50%",
            }}
        >
            <BankCardView
                bankName={bankCardViewData.CardBankName}
                cardType={bankCardViewData.CardType}
                cardNumber={bankCardViewData.CardID}
                cardHolder={bankCardViewData.CardHolderFirstName+bankCardViewData.CardHolderSecondName}
                expiryDate={bankCardViewData.CardExpiryDate}
                style={{ width: "600px", height: "250px" }}
            />
        </div>
    );
};