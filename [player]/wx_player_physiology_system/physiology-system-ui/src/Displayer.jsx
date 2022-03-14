import React from "react";
import Progress from "./Progress";

export default function Displayer() {
    const [thirst, setThirst] = React.useState(100);
    const [satiety, setSatiety] = React.useState(100);
    const [tiredness, setTiredness] = React.useState(100);
    const [Urine, setUrine] = React.useState(100);
    const [shit, setShit] = React.useState(100);

    window.addEventListener("message", (event) => {
        if (event.data.type === "thirst") {
            setThirst(event.data.value);
        } else if (event.data.type === "satiety") {
            setSatiety(event.data.value);
        } else if (event.data.type === "tiredness") {
            setTiredness(event.data.value);
        } else if (event.data.type === "urine") {
            setUrine(event.data.value);
        } else if (event.data.type === "shit") {
            setShit(event.data.value);
        }
    });

    return (
        <div
            style={{
                position: "absolute",
                right: "10px",
                bottom: "10px",
                margin: "0px",
                width: "10%",
                padding: "10px",
                borderRadius: "10px",
                paddingRight: "20px",
                // backdropFilter: "blur(15px)",
            }}
        >
            <p
                style={{
                    fontSize: "20px",
                    textAlign: "center",
                    margin: "10px",
                    marginTop: "10px",
                    fontWeight: "600",
                }}
            >
                饱食度
            </p>
            <Progress
                progress={satiety}
                displayLabel=""
                endColor="rgba(20,255,0,1)"
            />
            <p
                style={{
                    fontSize: "20px",
                    textAlign: "center",
                    fontWeight: "600",
                    margin: "10px",
                }}
            >
                干渴度
            </p>
            <Progress
                progress={thirst}
                displayLabel=""
                endColor="rgba(100,150,250,1)"
            />
            <p
                style={{
                    fontSize: "20px",
                    textAlign: "center",
                    fontWeight: "600",
                    margin: "10px",
                }}
            >
                疲倦感
            </p>
            <Progress
                progress={tiredness}
                displayLabel=""
                endColor="rgba(200,100,255,1)"
            />
            <p
                style={{
                    fontSize: "20px",
                    textAlign: "center",
                    fontWeight: "600",
                    margin: "10px",
                }}
            >
                膀胱储液量
            </p>
            <Progress
                progress={Urine}
                displayLabel=""
                endColor="rgba(255,255,0,1)"
            />
            <p
                style={{
                    fontSize: "20px",
                    textAlign: "center",
                    fontWeight: "600",
                    margin: "10px",
                }}
            >
                直肠储屎量
            </p>
            <Progress
                progress={shit}
                displayLabel=""
                endColor="rgba(160,136,10,1)"
            />
        </div>
    );
}
