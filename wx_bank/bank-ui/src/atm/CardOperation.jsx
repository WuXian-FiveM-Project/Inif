import "./CardOperation.css";
import React from "react"

export default function CardOperation(props) {
    const [currentPage, setCurrentPage] = React.useState("mainPage")
    const [takeMoneyValue, setTakeMoneyValue] = React.useState(0.0)
    
    const [targetCardID, setTargetCardID] = React.useState("");
    const [tradeAmount, setTradeAmount] = React.useState(0.0);

    const [alertData, setAlertData] = React.useState({show:false, text:"12dd大王"})

    const [storeMoneyValue, setStoreMoneyValue] = React.useState(0.0);

    const CenterProp = function () {
        if (alertData.show) {
            return (
                <div
                    style={{
                        textAlign: "center",
                        zIndex: "1000000000000000000000000000000000",
                        backgroundColor: "red",
                        height: "100%",
                        fontSize: "40px",
                        transform: "translate(-50%, -50%)",
                        position: "absolute",
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "center",
                        top: "50%",
                        left: "50%",
                        fontWeight: "bold",
                        color: "white",
                        width: "100%",
                    }}
                >
                    {alertData.text}
                </div>
            );
        } else {
            switch (currentPage) {
                case "mainPage":
                    return <h1>您好！请选择您要进行的操作：</h1>;
                case "checkBalance":
                    return <h1>余额：{props.card.CardBalance}</h1>;
                case "takeMoney":
                    return (
                        <div>
                            <h1>请输入您要取款的金额：</h1>
                            <input
                                type="text"
                                id="takeMoneyInput"
                                style={{
                                    resize: "none",
                                    fontSize: "40px",
                                }}
                                onChange={(e) => {
                                    setTakeMoneyValue(
                                        parseFloat(e.target.value)
                                    );
                                    document
                                        .getElementById(
                                            e.target.getAttribute(
                                                "id"
                                            )
                                        )
                                        .focus();
                                    setTimeout(() => {
                                        document
                                            .getElementById(
                                                e.target.getAttribute(
                                                    "id"
                                                )
                                            )
                                            .focus();
                                    }, 1);
                                }}
                                value={takeMoneyValue}
                            ></input>
                            <br></br>
                            <button
                                style={{
                                    fontSize: "40px",
                                    transitionDuration: "0.2s",
                                }}
                                onClick={() => {
                                    if (takeMoneyValue <= 0) {
                                        setAlertData({
                                            show: true,
                                            text: "请输入正确的金额",
                                        });
                                        setTimeout(() => {
                                            setAlertData({
                                                show: false,
                                                text: "",
                                            });
                                        }, 2000);
                                    } else {
                                        if (props.card.CardBalance >= takeMoneyValue) {                                            
                                            props.takeMoney(
                                                props.card.BID,
                                                takeMoneyValue
                                            );
                                        } else {
                                            setAlertData({
                                                show: true,
                                                text: "余额不足",
                                            });
                                            setTimeout(() => {
                                                setAlertData({
                                                    show: false,
                                                    text: "",
                                                });
                                            }, 2000);
                                        }
                                        setCurrentPage("mainPage");
                                    }
                                }}
                            >
                                确认
                            </button>
                        </div>
                    );
                case "tradeMoney":
                    return (
                        <div>
                            <h1>请输入对方的卡号：</h1>
                            <input
                                type="text"
                                id="targetCardID"
                                style={{
                                    resize: "none",
                                    fontSize: "40px",
                                }}
                                required
                                pattern="[0-9]{16}"
                                onChange={(e) => {
                                    setTargetCardID(e.target.value);
                                    setTimeout(() => {
                                        document
                                            .getElementById(
                                                e.target.getAttribute(
                                                    "id"
                                                )
                                            )
                                            .focus();
                                    }, 10);
                                }}
                                value={targetCardID}
                            ></input>
                            <h1>请输入转账金额：</h1>
                            <input
                                type="text"
                                id="tradeAmount"
                                style={{
                                    resize: "none",
                                    fontSize: "40px",
                                }}
                                onChange={(e) => {
                                    setTradeAmount(
                                        parseFloat(e.target.value)
                                    );
                                    setTimeout(() => {
                                        document
                                            .getElementById(
                                                e.target.getAttribute(
                                                    "id"
                                                )
                                            )
                                            .focus();
                                    }, 10);
                                }}
                                value={tradeAmount}
                            ></input>
                            <br />
                            <button
                                onClick={() => {
                                    if (
                                        targetCardID.length ===
                                            16 &&
                                        tradeAmount > 0
                                    ) {
                                        if (
                                            props.card.CardBalance >= tradeAmount
                                        ) {
                                            props.tradeMoney(
                                                props.card.BID,
                                                targetCardID,
                                                tradeAmount
                                            );
                                            setCurrentPage("mainPage");
                                        } else {
                                            setAlertData({
                                                show: true,
                                                text: "余额不足",
                                            });
                                            setTimeout(() => {
                                                setAlertData({
                                                    show: false,
                                                    text: "",
                                                });
                                            }, 2000);
                                        }
                                    } else if (
                                        targetCardID.length !== 16
                                    ) {
                                        setAlertData({
                                            show: true,
                                            text: "请输入正确的卡号",
                                        });
                                        setTimeout(() => {
                                            setAlertData({
                                                show: false,
                                                text: "",
                                            });
                                        },1000)
                                    } else if (tradeAmount <= 0) {
                                        setAlertData({
                                            show: true,
                                            text: "请输入正确的金额",
                                        });
                                        setTimeout(() => {
                                            setAlertData({
                                                show: false,
                                                text: "",
                                            });
                                        },1000)
                                    }
                                }}
                                style={{
                                    fontSize: "40px",
                                    borderRadius: "10px",
                                    transitionDuration: "0.2s",
                                }}
                            >
                                确认
                            </button>
                        </div>
                    );
                case "storeMoney":
                    return (
                        <div>
                            <h1>请输入您要存款的金额：</h1>
                            <input
                                type="text"
                                id="storeMoneyInput"
                                style={{
                                    resize: "none",
                                    fontSize: "40px",
                                }}
                                onChange={(e) => {
                                    setStoreMoneyValue(
                                        parseFloat(e.target.value)
                                    );
                                    setTimeout(() => {
                                        document
                                            .getElementById(
                                                e.target.getAttribute(
                                                    "id"
                                                )
                                            )
                                            .focus();
                                    }, 1)
                                }}
                                value={storeMoneyValue}
                            ></input>
                            <br></br>
                            <button
                                style={{
                                    fontSize: "40px",
                                    transitionDuration: "0.2s",
                                }}
                                onClick={() => {
                                    if (storeMoneyValue <= 0) {
                                        setAlertData({
                                            show: true,
                                            text: "请输入正确的金额",
                                        });
                                        setTimeout(() => {
                                            setAlertData({
                                                show: false,
                                                text: "",
                                            });
                                        }, 2000);
                                    } else {
                                        if (props.currentMoney >= storeMoneyValue) {
                                            props.storeMoney(
                                                props.card.BID,
                                                storeMoneyValue
                                            );
                                            setCurrentPage("mainPage");
                                        } else {
                                            setAlertData({
                                                show: true,
                                                text: "现金不足",
                                            });
                                            setTimeout(() => {
                                                setAlertData({
                                                    show: false,
                                                    text: "",
                                                });
                                            }, 2000);
                                        }
                                    }
                                }}
                            >确认</button>
                        </div>
                    )
                default:
                    return <div></div>;
            }
        }
    }
    const LeftProp = function () {
        switch (currentPage) {
            case "mainPage":
                return (
                    <button
                        className="card-operation-container-button"
                        onClick={() => {
                            setCurrentPage("checkBalance");
                        }}
                    >
                        查询
                    </button>
                );
            default:
                return <div></div>;
        }
    };
    const RightProp = function () {
        switch (currentPage) {
            case "mainPage":
                return (
                    <div
                        style={{
                            display: "flex",
                            flexDirection: "column",
                            alignContent: "space-between",
                            alignSelf: "center",
                            width: "100%",
                        }}
                    >
                        <button
                            className="card-operation-container-button"
                            onClick={() => {
                                setCurrentPage("takeMoney");
                            }}
                        >
                            取款
                        </button>
                        <button
                            className="card-operation-container-button"
                            onClick={() => {
                                setCurrentPage("storeMoney");
                            }}
                        >
                            存款
                        </button>
                        <button
                            className="card-operation-container-button"
                            onClick={() => {
                                setCurrentPage("tradeMoney");
                            }}
                        >
                            转账
                        </button>
                        <button
                            className="card-operation-container-button"
                            onClick={() => {
                                props.logout();
                            }}
                        >
                            退卡
                        </button>
                    </div>
                );
            case "checkBalance":
                return (
                    <button className="card-operation-container-button" onClick={() => {
                        setCurrentPage("mainPage");
                    }}>
                        返回
                    </button>
                );
            case "takeMoney":
                return (
                    <button className="card-operation-container-button" onClick={() => {
                        setCurrentPage("mainPage");
                    }}>
                        返回
                    </button>
                );
            case "tradeMoney":
                return (
                    <button className="card-operation-container-button" onClick={() => {
                        setCurrentPage("mainPage");
                    }}>
                        返回
                    </button>
                );
            case "storeMoney":
                return (
                    <button
                        className="card-operation-container-button"
                        onClick={() => {
                            setCurrentPage("mainPage");
                        }}
                    >
                        返回
                    </button>
                );
            default:
                return (
                   <button
                       className="card-operation-container-button"
                       onClick={() => {
                           setCurrentPage("mainPage");
                       }}
                   >
                       返回
                   </button>
               );
        }
    }

    return (
        <div>
            <div className="card-operation-container">
                <div className="card-operation-container-left">
                    <LeftProp />
                </div>
                <div className="card-operation-container-center">
                    <CenterProp />
                </div>
                <div className="card-operation-container-right">
                    <RightProp />
                </div>
            </div>
        </div>
    );
}