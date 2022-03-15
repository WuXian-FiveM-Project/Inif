import "./buttonStyle.css";

export default function PhMenu(props) {
    return (
        <div
            style={{
                display: props.open? "block" : "none",
                position: "absolute",
                transform: "translate(-50%, -50%)",
                left: "50%",
                bottom: "0%",
                padding: "10px",
                backgroundColor: "rgba(0,0,0,0.5)",
                borderRadius: "10px",
            }}
        >
            <button className = "btn_phMenu" onClick={props.pee}>撒尿</button>
            <button className = "btn_phMenu" onClick={props.goShit}>拉屎</button>
        </div>
    );
}