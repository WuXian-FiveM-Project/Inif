import "./BankCardView.css";

export default function BankCardView(props) {
    return (
        <div>
            <div className="BankCardView card" style={props.style}>
                <h1 className="BankCardView grid-item title">{props.bankName}</h1>
                <h1 className="BankCardView grid-item cardType">{props.cardType}</h1>
                <h1 className="BankCardView grid-item cardNumber">{props.cardNumber}</h1>
                <h1 className="BankCardView grid-item cardHolder">
                    持卡人：{props.cardHolder}
                </h1>
                <h1 className="BankCardView grid-item expiryDate">{props.expiryDate}</h1>
            </div>
        </div>
    );
}