import React from 'react';
import "./ATM.css";
import BankCardSelector from "./BankCardSelector";
import CardOperation from "./CardOperation";

export default function ATMHandler() {
    const [atmDisplayState, setAtmDisplayState] = React.useState(false);
    const [currentCardList, setCurrentCardList] = React.useState([
        {
            BID: 1,
            CardBankName: "无限银行⫗",
            CardType: "储蓄卡",
            CardID: "1000 0000 0000 0000",
            CardHolderFirstName: "张",
            CardHolderSecondName: "三",
            CardExpiryDate: "08/25",
            CardPassword: "123456",
            CardBalance: 4142142,
        },
    ]);
    const [cardPluged, setCardPluged] = React.useState(false);
    const [currentCard, setCurrentCard] = React.useState([
        {
            BID: 1,
            CardBankName: "无限银行⫗",
            CardType: "储蓄卡",
            CardID: "1000 0000 0000 0000",
            CardHolderFirstName: "张",
            CardHolderSecondName: "三",
            CardExpiryDate: "08/25",
            CardPassword: "123456",
            CardBalance: 4142142,
        },
    ]);

    const [currentMoney, setCurrentMoney] = React.useState(0)

    window.addEventListener('message', function (event) {
        if (event.data.type === "showAtm") {
            setAtmDisplayState(true);
            setCurrentMoney(event.data.currentMoney);
            setCurrentCardList(event.data.currentCardList);
        } else if (event.data.type === "hideAtm") {
            setCurrentCardList(event.data.currentCardList);
        } else if (event.data.type === "hideAtm") {
            setAtmDisplayState(false);
        }
    })

    window.onkeydown = function (event) {
        if (event.keyCode === 27) {
            fetch(`https://wx_bank/disableCursur`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
            });
            setAtmDisplayState(false);
            logout();
        }
    }

    const successPlugcard = (cardData) => {
        setCardPluged(true)
        setCurrentCard(cardData);
    }

    const tradeMoney = (BID, targetCardID, amount) => {
        fetch(`https://wx_bank/tradeMoney`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({
                BID: BID,
                targetCardID: targetCardID,
                amount: amount,
            }),
        });
    }

    const takeMoney = (BID, amount) => {
        fetch(`https://wx_bank/takeMoney`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({
                BID: BID,
                amount: amount,
            }),
        });
    }

    const storeMoney = (BID, amount) => {
        fetch(`https://wx_bank/storeMoney`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({
                BID: BID,
                amount: amount,
            }),
        });
    }

    const logout = () => {
        setCardPluged(false);
        setCurrentCard([
            {
                BID: 1,
                CardBankName: "无限银行⫗",
                CardType: "储蓄卡",
                CardID: "1000 0000 0000 0000",
                CardHolderFirstName: "张",
                CardHolderSecondName: "三",
                CardExpiryDate: "08/25",
                CardPassword: "123456",
                CardBalance: 4142142,
            },
        ]);
    }

    const Render = () => {
        return (
            setAtmDisplayState ? 
            <div style={{ display: atmDisplayState ? "block" : "none" }}>
                <div className="atm top-logo-bar">
                    <h1 className="atm top-logo-bar-logo">⫗</h1>
                    <div className="atm top-logo-bar-title">
                        <h1 className="atm top-logo-bar-title">无限银行</h1>
                        <br></br>
                        <h1 className="atm top-logo-bar-atm">自助柜员机</h1>
                    </div>
                </div>
                {cardPluged ? (
                    <CardOperation
                        card={currentCard}
                        tradeMoney={tradeMoney}
                        takeMoney={takeMoney}
                        logout={logout}
                        storeMoney={storeMoney}
                        currentMoney={currentMoney}
                    />
                ) : (
                    <BankCardSelector
                        cardList={currentCardList}
                        successPlugcard={successPlugcard}
                    />
                )}
                </div>
                : null
        );
    }

    return <Render/>
}