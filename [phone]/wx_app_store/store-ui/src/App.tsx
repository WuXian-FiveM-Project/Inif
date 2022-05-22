import React from 'react';
import { AppStoreContext } from "./AppStoreContext";
import { IApp } from "./interface"
import AppStore from "./AppStore"
import "./index.css"

function App() {
    const appList: IApp[] = [
        {
            IsSystemApp: true,
            IsAppOverride: true,
            AppName: "AppName",
            AppDescription: "AppDescription",
            AppPackageName: "AppPackageName",
            AppVersion: "AppVersion",
            AppUrl: "AppUrl",
            AppIcon:
                "https://upload.wikimedia.org/wikipedia/commons/5/55/Google_Play_2016_icon.svg",
            AppAuthor: "AppAuthor",
            AppAuthorUrl: "AppAuthorUrl",
            IsPaySoftware: true,
            AppPrice: 1,
            IsUploadToGooglePlay: true,
            IsUploadToAppStore: true,
            AppSize: 1,
        },
        {
            IsSystemApp: true,
            IsAppOverride: true,
            AppName: "AppName",
            AppDescription:
                "AppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescription",
            AppPackageName: "AppPackageName",
            AppVersion: "AppVersion",
            AppUrl: "AppUrl",
            AppIcon:
                "https://upload.wikimedia.org/wikipedia/commons/5/55/Google_Play_2016_icon.svg",
            AppAuthor: "AppAuthor",
            AppAuthorUrl: "AppAuthorUrl",
            IsPaySoftware: true,
            AppPrice: 1,
            IsUploadToGooglePlay: true,
            IsUploadToAppStore: true,
            AppSize: 1,
        },
        {
            IsSystemApp: true,
            IsAppOverride: true,
            AppName: "AppName",
            AppDescription:
                "AppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescription",
            AppPackageName: "AppPackageName",
            AppVersion: "AppVersion",
            AppUrl: "AppUrl",
            AppIcon:
                "https://upload.wikimedia.org/wikipedia/commons/5/55/Google_Play_2016_icon.svg",
            AppAuthor: "AppAuthor",
            AppAuthorUrl: "AppAuthorUrl",
            IsPaySoftware: true,
            AppPrice: 1,
            IsUploadToGooglePlay: true,
            IsUploadToAppStore: true,
            AppSize: 1,
        },
        {
            IsSystemApp: true,
            IsAppOverride: true,
            AppName: "AppName",
            AppDescription:
                "AppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescription",
            AppPackageName: "AppPackageName",
            AppVersion: "AppVersion",
            AppUrl: "AppUrl",
            AppIcon:
                "https://upload.wikimedia.org/wikipedia/commons/5/55/Google_Play_2016_icon.svg",
            AppAuthor: "AppAuthor",
            AppAuthorUrl: "AppAuthorUrl",
            IsPaySoftware: true,
            AppPrice: 1,
            IsUploadToGooglePlay: true,
            IsUploadToAppStore: true,
            AppSize: 1,
        },
        {
            IsSystemApp: true,
            IsAppOverride: true,
            AppName: "AppName",
            AppDescription:
                "AppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescription",
            AppPackageName: "AppPackageName",
            AppVersion: "AppVersion",
            AppUrl: "AppUrl",
            AppIcon:
                "https://upload.wikimedia.org/wikipedia/commons/5/55/Google_Play_2016_icon.svg",
            AppAuthor: "AppAuthor",
            AppAuthorUrl: "AppAuthorUrl",
            IsPaySoftware: true,
            AppPrice: 1,
            IsUploadToGooglePlay: true,
            IsUploadToAppStore: true,
            AppSize: 1,
        },
        {
            IsSystemApp: true,
            IsAppOverride: true,
            AppName: "AppName",
            AppDescription:
                "AppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescription",
            AppPackageName: "AppPackageName",
            AppVersion: "AppVersion",
            AppUrl: "AppUrl",
            AppIcon:
                "https://upload.wikimedia.org/wikipedia/commons/5/55/Google_Play_2016_icon.svg",
            AppAuthor: "AppAuthor",
            AppAuthorUrl: "AppAuthorUrl",
            IsPaySoftware: true,
            AppPrice: 1,
            IsUploadToGooglePlay: true,
            IsUploadToAppStore: true,
            AppSize: 1,
        },
        {
            IsSystemApp: true,
            IsAppOverride: true,
            AppName: "AppName",
            AppDescription:
                "AppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescription",
            AppPackageName: "AppPackageName",
            AppVersion: "AppVersion",
            AppUrl: "AppUrl",
            AppIcon:
                "https://upload.wikimedia.org/wikipedia/commons/5/55/Google_Play_2016_icon.svg",
            AppAuthor: "AppAuthor",
            AppAuthorUrl: "AppAuthorUrl",
            IsPaySoftware: true,
            AppPrice: 1,
            IsUploadToGooglePlay: true,
            IsUploadToAppStore: true,
            AppSize: 1,
        },
        {
            IsSystemApp: true,
            IsAppOverride: true,
            AppName: "AppName",
            AppDescription:
                "AppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescriptionAppDescription",
            AppPackageName: "AppPackageName",
            AppVersion: "AppVersion",
            AppUrl: "AppUrl",
            AppIcon:
                "https://upload.wikimedia.org/wikipedia/commons/5/55/Google_Play_2016_icon.svg",
            AppAuthor: "AppAuthor",
            AppAuthorUrl: "AppAuthorUrl",
            IsPaySoftware: true,
            AppPrice: 1,
            IsUploadToGooglePlay: true,
            IsUploadToAppStore: true,
            AppSize: 1,
        },
    ];
    

    return (
        <AppStoreContext.Provider
            value={{
                appList: appList,
            }}
        >
            <AppStore />
        </AppStoreContext.Provider>
    );
}

export default App;
