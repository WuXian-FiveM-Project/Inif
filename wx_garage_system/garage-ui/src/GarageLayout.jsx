import "./GarageLayout.css"
import VehicleCard from "./VehicleCard";
import React from "react";

export default function GarageLayout() {
    const handleUnlockAndPay = (VID) => {
        fetch(`https://wx_garage_system/PayAndUnlock`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({
                VID: VID,
            }),
        });
    }
    const handlePay = (VID) => {
        fetch(`https://wx_garage_system/Pay`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({
                VID: VID,
            }),
        });
    };
    const handleRename = (VID, NewName) => {
        fetch(`https://wx_garage_system/Rename`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({
                VID: VID,
                NewName: NewName
            }),
        });
    }
    const [vehicleList, setVehicleList] = React.useState([{ VID: 0, name: "", plate: "", price: 0 }]);
    const [currentMoney, setCurrentMoney] = React.useState(1);
    const [garageListOpen, setGarageListOpen] = React.useState(true);

    setTimeout(() => {
        setVehicleList([
            { VID: 3213, name: "ww", plate: "113dqw", price: 31313131 },
            { VID: 4424, name: "dd", plate: "3f32", price: 0 },
        ]);
    })

    window.addEventListener("message", (event) => {
        if (event.data.type === "openGarageVehicleList") {
            setGarageListOpen(true);
            setVehicleList(event.data.vehicleList);
            setCurrentMoney(event.data.currentMoney);
        }
    });

    return (
        <div className="garageGrid" style={{ opacity: garageListOpen ? 1 : 0 }}>
            {vehicleList.map((vehicleInfo, index) => (
                <VehicleCard
                    key={index}
                    index={index}
                    onUnlockAndPay={handleUnlockAndPay}
                    onRename={(VID, NewName) => {
                        handleRename(VID, NewName);
                    }}
                    onPay={handlePay}
                    vehicleInfo={vehicleInfo}
                    currentMoney={currentMoney}
                />
            ))}
        </div>
    );
}