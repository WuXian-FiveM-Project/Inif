import React from "react";
import "./HomePage.css"
import AppIconComponent from "./AppIconComponent/AppIconComponent";
import InAppView from "./InAppView/InAppView";

export default class System extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            currentPage: "homepage",
            currentApp: null,
            appHistory: [],
        };
    }

    homepage() {
        return (
            <div className="homepage-applist">
                {this.props.phoneData.PhoneApps.map((app, index) => {
                    return (
                        <AppIconComponent
                            key={index}
                            appName={app.AppName}
                            appIcon={app.AppIcon}
                            className="openingAnimation"
                            onClick={(event) => {
                                event.target.classList.add("openingAnimation");
                                setTimeout(() => {
                                    this.openApp(app);
                                }, 200);
                            }}
                        />
                    );
                })}
            </div>
        );
    }

    openApp(propsApp) {
        this.setState({
            currentPage: "inApp",
            currentApp: propsApp,
            appHistory: [...this.state.appHistory, propsApp],
        });
    }

    inApp() {
        return <InAppView appProps={this.state.currentApp} />;
    }

    componentDidMount() {
        setInterval(() => this.buttonStateHandler(), 1);
    }

    buttonStateHandler = () => {
        if (this.props.homeButtonState) {
            this.setState({
                currentPage: "homepage",
            });
        }
        if (this.props.multiTaskButtonState) {
            this.setState({
                currentPage: "multiTask",
            });
        }
    };

    multiTask() {
        return (
            <div className="multiTask-container">
                {this.state.appHistory.map((app, index) => {
                    return (
                        <AppIconComponent
                            key={index}
                            appName={app.AppName}
                            appIcon={app.AppIcon}
                            onClick={() => this.openApp(app)}
                        />
                    );
                })}
            </div>
        );
    }

    render() {
        switch (this.state.currentPage) {
            case "homepage":
                return this.homepage();
            case "inApp":
                return this.inApp();
            case "multiTask":
                return this.multiTask();
            default:
                return (
                    <div>
                        <h1>Invalid Page</h1>
                        <h1>无效页面</h1>
                        <h1>無效頁面</h1>
                    </div>
                );
        }
    }
}