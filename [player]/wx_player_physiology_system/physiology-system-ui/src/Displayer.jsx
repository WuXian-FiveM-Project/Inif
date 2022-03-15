import React from "react";
import Progress from "./Progress";
import PhMenu from "./PhMenu"

export default function Displayer() {
    const [thirst, setThirst] = React.useState(100);
    const [satiety, setSatiety] = React.useState(100);
    const [tiredness, setTiredness] = React.useState(100);
    const [urine, setUrine] = React.useState(100);
    const [shit, setShit] = React.useState(100);
    const [phmenu, setPhmenu] = React.useState(false);

    window.addEventListener("message", (event) => {
        switch (event.data.type) {
            case "thirst":
                setThirst(event.data.value);
                break;
            case "satiety":
                setSatiety(event.data.value);
                break;
            case "tiredness":
                setTiredness(event.data.value);
                break;
            case "urine":
                setUrine(event.data.value);
                break;
            case "shit":
                setShit(event.data.value);
                break;
            case "openPhsiologyMenu":
                setPhmenu(true);
                break;
            default:
                break;
        }
    });

    const goPee = () => {
        fetch(`https://wx_player_physiology_system/goPee`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
        });
        setPhmenu(false);
    }
    const goShit = () => {
        fetch(`https://wx_player_physiology_system/goShit`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
        });
        setPhmenu(false);
    }

    window.onkeydown = (event) => {
        if (event.keyCode === 27) {
            fetch(`https://wx_player_physiology_system/closePhsiologyMenu`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json; charset=UTF-8",
                },
            });
            setPhmenu(false);
        }
    }

    return (
        <div>
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
                    progress={urine}
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
            <PhMenu open={phmenu} pee={goPee} goShit={goShit}/>
        </div>
    );
}
