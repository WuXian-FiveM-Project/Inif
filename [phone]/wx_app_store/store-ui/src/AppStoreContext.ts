import React from "react";
import { IApp } from "./interface"

interface AppStore {
    appList: IApp[]
}

export const AppStoreContext = React.createContext<AppStore>({
    appList: []
});

interface AppCard {
    app: IApp
}
export const AppCardContext = React.createContext<AppCard>({
    app: {
        AppAuthor: "",
        AppDescription: "",
        AppIcon: "",
        AppName: "",
        AppUrl: "",
        AppVersion: "",
        AppAuthorUrl: "",
        AppPackageName: "",
        AppPrice: 0,
        AppSize: 0,
        IsAppOverride: false,
        IsPaySoftware: false,
        IsSystemApp: false,
        IsUploadToAppStore: false,
        IsUploadToGooglePlay: false,
    }
});