import React from 'react'
import IPhoneX from './phoneModule/iPhoneX/IPhoneX'


export default function PhoneHandler() {
    const APIRequest = (api, parms) => {
        return new Promise((resolve, reject) => {
            fetch(`https://wx_phone/${api}`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json; charset=UTF-8",
                },
                body: parms,
            })
                .then(response => response.json())
                .then(response => {
                    resolve(response);
                }).catch(error => {
                    reject(error);
                });
        });
    }
    
    const [phoneData, setPhoneData] = React.useState({
        PID: 1,
        PhonePassword: "123",
        PhoneModule: "iPhone X",
        PhoneApps: [
            "wechat"
        ],
        PhoneSetting: {
            DarkMode: true,
        }
    });

    const [showState, setShowState] = React.useState(true);


    if (showState) {
        switch (phoneData.PhoneModule) {
            case "iPhone X":
                return <IPhoneX phoneData={phoneData} />;
            default:
                return <div></div>;
        }
    } else {
        return <div></div>;
    }
}