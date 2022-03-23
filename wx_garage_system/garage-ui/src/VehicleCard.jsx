import "./NotoSansSC-Regular.otf";
import "./NotoSansSC-Black.otf";
import "./NotoSansSC-Bold.otf";
import "./NotoSansSC-Light.otf";
import "./NotoSansSC-Medium.otf";
import "./NotoSansSC-Thin.otf";
import React from "react";



export default function VehicleCard(props) {
    const { vehicleInfo, currentMoney, onUnlockAndPay, onPay, onRename, index } = props;
    const [renameBoxValue, setRenameValue] = React.useState(vehicleInfo.name);
    const [renameBoxState, setRenameBoxState] = React.useState(false);

    const showRenameBox = () => {
        setRenameBoxState(true)
    }

    const checkOutRename = () => {
        setRenameBoxState(false);
        onRename(vehicleInfo.VID, renameBoxValue);
    }
    
    return (
        <div>
            <div className={`changeNameBox ${renameBoxState ? "show" : "notshow"}`}>
                <div className={`changeNameBox darkness`}></div>
                <div className="changeNameBox box">
                    <h1 className="changeNameBox title">新车辆名称</h1>
                    <input
                        className="changeNameBox inputBox"
                        value={renameBoxValue}
                        onChange={(e) => setRenameValue(e.target.value)}
                        defaultValue={vehicleInfo.VehicleNickname}
                        type="text"
                        placeholder="新车名"
                    ></input>
                    <br></br>
                    <button className="changeNameBox comfirm" onClick={checkOutRename}>确定</button>
                </div>
            </div>

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
                    缴费金额: {vehicleInfo.price}
                </h1>
                <h1 className="garageVehicleCard price">
                    已停靠: {vehicleInfo.parkHours} 小时
                </h1>
                <button
                    className={`garageVehicleCard button ${
                        currentMoney >= vehicleInfo.price ? "" : "noEnoughMoney"
                    }`}
                    onClick={() =>
                        currentMoney >= vehicleInfo.price
                            ? onPay(vehicleInfo.VID,vehicleInfo.parkHours)
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
                            ? onUnlockAndPay(vehicleInfo.VID,vehicleInfo.parkHours)
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
        </div>
    );
}