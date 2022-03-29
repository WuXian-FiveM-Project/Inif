import React from 'react';
import "./ATM.css";
import BankCardSelector from "./BankCardSelector";

export default function ATMHandler() {
    const [atmDisplayState, setAtmDisplayState] = React.useState(true);
    const [currentCardList, setCurrentCardList] = React.useState([
        {
            BID: 1,
            CardBankName: "无限银行⫗",
            CardType: "储蓄卡",
            CardID: "1000 0000 0000 0000",
            CardHolderFirstName: "张",
            CardHolderSecondName: "三",
            CardExpiryDate: "08/25",
        }
    ]);

    window.addEventListener('message', function (event) {
        if (event.data.type === "showAtm") {
            setAtmDisplayState(true);
        } else if (event.data.type === "hideAtm") {
            setAtmDisplayState(false);
        }
    })
    return (
        <div style={{ display: atmDisplayState ?"block" : "none"}}>
            <div className="atm top-logo-bar">
                <h1 className="atm top-logo-bar-logo">⫗</h1>
                <div className="atm top-logo-bar-title">
                    <h1 className="atm top-logo-bar-title">无限银行</h1>
                    <br></br>
                    <h1 className="atm top-logo-bar-atm">自助柜员机</h1>
                </div>
            </div>
            <div className="atm operation-menu">
                <BankCardSelector cardList={currentCardList} />
            </div>
        </div>
    );
}