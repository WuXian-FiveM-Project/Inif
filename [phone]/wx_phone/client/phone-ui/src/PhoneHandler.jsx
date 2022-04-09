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
            {
                AppName: "微信",
                AppIcon:
                    "https://cdn.icon-icons.com/icons2/1488/PNG/512/5368-wechat_102582.png",
                AppUrl: "http://map.google.com",
            },
            {
                AppName: "QQ",
                AppIcon:
                    "https://cdn.icon-icons.com/icons2/1488/PNG/512/5368-wechat_102582.png",
                AppUrl: "http://localhost:3000/",
            },
            {
                AppName: "支付宝",
                AppIcon:
                    "https://cdn.icon-icons.com/icons2/1488/PNG/512/5368-wechat_102582.png",
                AppUrl: "http://localhost:3000/",
            },
            {
                AppName: "钉钉",
                AppIcon:
                    "https://cdn.icon-icons.com/icons2/1488/PNG/512/5368-wechat_102582.png",
                AppUrl: "http://localhost:3000/",
            },
            {
                AppName: "腾讯新闻",
                AppIcon:
                    "https://cdn.icon-icons.com/icons2/1488/PNG/512/5368-wechat_102582.png",
                AppUrl: "http://localhost:3000/",
            },
            {
                AppName: "腾讯视频",
                AppIcon:
                    "https://cdn.icon-icons.com/icons2/1488/PNG/512/5368-wechat_102582.png",
                AppUrl: "http://localhost:3000/",
            },
        ],
        PhoneSetting: {
            DarkMode: true,
        },
    });

    const [showState, setShowState] = React.useState(true);

    window.onkeydown = (e) => {
        if (e.key === "Escape") {
            setShowState(false);
            APIRequest("HideCurse");
        }
    }

    window.addEventListener("message", (event) => {
        var data = event.data;
        if (data.type === "show") {
            setShowState(true);
            setPhoneData(data.phoneData);
            console.log(data.phoneData);
        }
    })

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