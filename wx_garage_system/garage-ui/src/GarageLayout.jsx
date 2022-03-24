import "./GarageLayout.css"
import VehicleCard from "./VehicleCard";
import React from "react";

export default function GarageLayout() {
    const handleUnlockAndPay = (VID, parkHours) => {
        setGarageListOpen(false);
        fetch(`https://wx_garage_system/PayAndUnlock`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({
                VID: VID,
                parkHours: parkHours,
            }),
        });
    }
    const handlePay = (VID, parkHours) => {
        setGarageListOpen(false);
        fetch(`https://wx_garage_system/Pay`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({
                VID: VID,
                parkHours: parkHours,
            }),
        });
    };
    const handleRename = (VID, NewName) => {
        setGarageListOpen(false);
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
    const [vehicleList, setVehicleList] = React.useState([
        {
            VID: 0,
            VehicleGID: "",
            VehicleOwner: "",
            VehicleNickname: 0,
            VehicleModule: "",
            VehicleParms: "",
            VehiclePlate: "",
            VehiclePosition: {x: 0, y: 0, z: 0},
            VehicleHeading: 0.0,
            StoreDate: "",
        },
    ]);
    const [currentMoney, setCurrentMoney] = React.useState(1);
    const [garageListOpen, setGarageListOpen] = React.useState(false);

    window.onkeydown = (e) => {
        if (e.keyCode === 27) {
            setGarageListOpen(false);
            fetch(`https://wx_garage_system/quit`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json; charset=UTF-8",
                },
            });
        }
    }

    function converTime(d1) {
        var dateBegin = new Date(d1.replace(/-/g, "/"));
        var dateEnd = new Date(); //获取当前时间
        var dateDiff = dateEnd.getTime() - dateBegin.getTime(); //时间差的毫秒数
        //计算相差小时数
        var hours = Math.floor(dateDiff / (3600 * 1000));
        return hours;
    }

    window.addEventListener("message", function (event) {
        console.log(event.data);
        if (event.data.type === "openGarageVehicleList") {
            // setVehicleList([
            //     {
            //         VID: 0,
            //         VehicleGID: "",
            //         VehicleOwner: "",
            //         VehicleNickname: 0,
            //         VehicleModule: "",
            //         VehicleParms: "",
            //         VehiclePlate: "",
            //         VehiclePosition: { x: 0, y: 0, z: 0 },
            //         VehicleHeading: 0.0,
            //         StoreDate: "",
            //     },
            // ]);
            setCurrentMoney(event.data.currentMoney);
            var tempList = event.data.vehicleList
            tempList.forEach((item, index) => {
                tempList[index].parkHours = converTime(new Date(item.StoreDate).toLocaleString());
                tempList[index].price = converTime(new Date(item.StoreDate).toLocaleString())*event.data.garageData.GarageCostPerHours;
            })
            setVehicleList(tempList);
            setGarageListOpen(true);
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