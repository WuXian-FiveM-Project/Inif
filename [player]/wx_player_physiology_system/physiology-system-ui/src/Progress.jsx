export default function Progress(props) {
    return (
        <div
            style={{
                backgroundColor: "rgba(0,0,0,0.5)",
                borderRadius: "100px",
                width: "100%",
                border: "5px solid rgba(0,0,0,0.5)",
                margin: "0px",
                left: "0px",
                heigjt: "10px",
                boxShadow: "0px 0px 10px 0px #000",
            }}
        >
            <div
                style={{
                    backgroundColor: "rgba(255,255,255,.5)",
                    borderRadius: "100px",
                    width: props.progress + "%",
                    margin: "0",
                    backgroundImage:
                        "linear-gradient(to right, rgba(0,0,0,0) 1%, " +
                        props.endColor +
                        "30%)",
                }}
            >
                <p
                    style={{
                        filter: "drop-shadow(0px 0px 10px #fff)",
                        paddingRight: "20px",
                        margin: "0",
                        padding: "0",
                        textAlign: "center",
                        fontSize: "25px",
                        fontFamily: "Microsoft YaHei",
                        borderRadius: "100px",
                        boxShadow: "0px 0px 10px 5px rgb(10,10,10)",
                    }}
                >
                    {props.displayLabel}
                    {props.progress}%
                </p>
            </div>
        </div>
    );
}
