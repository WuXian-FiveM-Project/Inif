import "./NotoSansSC-Regular.otf";
import "./NotoSansSC-Black.otf";
import "./NotoSansSC-Bold.otf";
import "./NotoSansSC-Light.otf";
import "./NotoSansSC-Medium.otf";
import "./NotoSansSC-Thin.otf";
import React from "react";



export default function VehicleCard(props) {
    const { vehicleInfo, currentMoney, onUnlockAndPay, onPay, onRename, index } = props;
    const showRenameBox = () => {
        var result = window.prompt(
            "请输入新的车辆名称",
            vehicleInfo.VehicleNickname
        );
        onRename(vehicleInfo.VID, result);
    }
    
    return (
        <div
            className="garageVehicleCard card"
            style={{ "--index": `${index}00ms` }}
        >
            <h1 className="garageVehicleCard title">
                {vehicleInfo.VehicleNickname}
            </h1>
            <h1 className="garageVehicleCard plate">
                车牌号: {vehicleInfo.VehiclePlate}
            </h1>
            <h1 className="garageVehicleCard price">
                缴费金额: {vehicleInfo.VehiclePlate}
            </h1>
            <button
                className={`garageVehicleCard button ${
                    currentMoney >= vehicleInfo.price ? "" : "noEnoughMoney"
                }`}
                onClick={() =>
                    currentMoney >= vehicleInfo.price
                        ? onPay(vehicleInfo.VID)
                        : null
                }
            >
                缴费
            </button>
            <button
                className={`garageVehicleCard button ${
                    currentMoney >= vehicleInfo.price ? "" : "noEnoughMoney"
                }`}
                onClick={() =>
                    currentMoney >= vehicleInfo.price
                        ? onUnlockAndPay(vehicleInfo.VID)
                        : null
                }
            >
                缴费并解锁
            </button>
            <button
                className="garageVehicleCard button"
                onClick={showRenameBox}
            >
                重命名车辆
            </button>
        </div>
    );
}