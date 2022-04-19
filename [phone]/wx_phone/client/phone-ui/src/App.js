import React from "react";
import Phone from "./Phone";

function App () {
    const [showState,setShowState] = React.useState(true);
    const [phoneData, setPhoneData] = React.useState({
        PID: 1,
        PhonePassword: "123",
        PhoneModule: "iPhone X",
        PhoneSetting: {
            DarkMode: true,
        },
        PhoneApps: [
            {
                IsSystemApp: true,
                IsAppOverride: true,
                AppName: "应用商店",
                AppPackageName: "com.system.store",
                IsUploadToGooglePlay: true,
                IsPaySoftware: false,
                AppVersion: "1.0.0",
                // AppUrl: "nui://wx_appstore/index.html",
                AppUrl: "https://sacps.edu.hk",
                AppAuthor: "服主",
                IsUploadToAppStore: true,
                AppAuthorAuthor: "",
                AppIcon:
                    "https://upload.wikimedia.org/wikipedia/commons/5/55/Google_Play_2016_icon.svg",
                AppSize: 113000,
                AppPrice: 0,
                AppDescription: "应用商店",
            },
        ],
        PhoneData: {},
        PhoneRegisterDate: 1,
        PhoneMaxCapacity: 128000000,
        PhoneCurrentCapacity: 226000,
    });

    window.addEventListener("message", (event) => {
        let data = event.data;
        if (data.type === "showPhone") {
            setShowState(true);
            setPhoneData(data.phoneData);
        }
    })


    if (showState) {
        return (
            <div className="App">
                <Phone phoneData={phoneData} />
            </div>
        );
    } else {
        return (<div></div>)
    }
}

export default App;
