import React from 'react';
import "./System.css"
import AppRenderView from "./AppRenderView";
import AppIcon from "./AppIcon";

class System extends React.Component {
    constructor(props) {
        super();
        var date = new Date();
        this.state = {
            clock: `${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}`,
            currentApp: "Homepage",
            currentAppData: null,
            homeButton: false,
            returnButton: false,
            taskButton: false,
            taskApp: []
        };
    }

    componentDidMount = () => {
        setInterval(() => {
            var date = new Date();
            this.setState({
                clock: `${date.getHours()}:${
                    date.getMinutes().toLocaleString().length === 1
                        ? "0" + date.getMinutes()
                        : date.getMinutes()
                }:${
                    date.getSeconds().toLocaleString().length === 1
                        ? "0" + date.getSeconds()
                        : date.getSeconds()
                }`,
            });
        }, 1000);
    };

    TopStateBar = () => {
        return (
            <div className="iphoneX-system-topStateBar">
                <p className="iphoneX-system-topStateBar-clock">
                    {this.state.clock}
                </p>
                <div className=""></div>
                <div className="">dwa</div>
            </div>
        );
    };

    BottomStateBar = () => {
        const handleReturnButtonClick = () => {
            this.setState({
                returnButton: true,
            });
        };
        const handleReturnButtonDoubleClick = () =>
            this.setState({
                currentApp: "Homepage",
                currentAppData: null,
            });
        const handleReturnButtonUp = () => {
            this.setState({
                returnButton: false,
            });
        };

        const handleHomeButtonClick = () => {
            this.setState({
                currentApp: "Homepage",
                currentAppData: null,
                homeButton: true,
            });
        };
        const handleHomeButtonDoubleUp = () =>
            this.setState({
                homeButton: false,
            });
        const handleHomeButtonDoubleClick = () => {
            this.setState({
                currentApp: "Multitask",
            });
        };

        const handleTaskButtonClick = () => {
            this.setState({
                currentApp: "Multitask",
                currentAppData: null,
                taskButton: true,
            });
        };
        const handleTaskButtonDoubleClick = () =>
            this.setState({
                currentApp: "Homepage",
            });;
        const handleTaskButtonUp = () =>
            this.setState({
                taskButton: false,
            });

        return (
            <div className="iphoneX-system-bottomStateBar">
                <button
                    onMouseDown={handleReturnButtonClick}
                    onDoubleClick={handleReturnButtonDoubleClick}
                    onMouseUp={handleReturnButtonUp}
                >
                    ◁
                </button>
                <button
                    onMouseDown={handleHomeButtonClick}
                    onDoubleClick={handleHomeButtonDoubleClick}
                    onMouseUp={handleHomeButtonDoubleUp}
                >
                    ▢
                </button>
                <button
                    onMouseDown={handleTaskButtonClick}
                    onDoubleClick={handleTaskButtonDoubleClick}
                    onMouseUp={handleTaskButtonUp}
                >
                    ◯
                </button>
            </div>
        );
    };

    Homepage = () => {
        const handleAppOpen = (app) => {
            this.setState({
                currentApp: app.AppName,
                currentAppData: app,
            });
            if (this.state.taskApp.indexOf(app) === -1) {
                this.setState({
                    taskApp: [...this.state.taskApp, app],
                });
            }
        };
        return (
            <div className="iphoneX-system-homepage-grid">
                {this.props.phoneData.PhoneApps.map((app, index) => {
                    return (
                        <AppIcon
                            key={index}
                            app={app}
                            onClick={() => handleAppOpen(app)}
                        />

                    );
                })}
            </div>
        );
    };

    Multitask = () => {
        return (
            <div>
                {this.state.taskApp.map((app, index) => {
                    return (
                        <div>
                            <AppIcon
                                key={index}
                                app={app}
                                onClick={() =>
                                    this.setState({
                                        currentApp: app.AppName,
                                        currentAppData: app,
                                    })
                                }
                            />
                        </div>
                    );
                })}
            </div>
        );
    };

    render = () => {
        return (
            <div className="iphoneX-system-grid">
                <this.TopStateBar />
                {(() => {
                    if (this.state.currentApp === "Homepage") {
                        return <this.Homepage />
                    } else if (this.state.currentApp === "Multitask") {
                        return <this.Multitask />
                    } else {
                        return (
                            <AppRenderView
                                returnButton={this.state.returnButton}
                                homeButton={this.state.homeButton}
                                taskButton={this.state.taskButton}
                                phoneData={this.props.phoneData}
                                app={this.state.currentAppData}
                            />
                        );
                    }
                })()}
                <this.BottomStateBar />
            </div>
        );
    };
}

export default System;