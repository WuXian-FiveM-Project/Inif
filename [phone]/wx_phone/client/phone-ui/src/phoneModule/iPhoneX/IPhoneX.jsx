import "./iPhoneX.css"
import backdrop from "./Backdrop.png";
import System from "./System/System";

import React from "react";

export default class IPhoneX extends React.Component {
    constructor(props) {
        super(props);
        this.rootContainerRef = React.createRef();
        this.screenViewRef = React.createRef();
        this.date = new Date();
        this.state = {
            topStateBarTime:
                this.date.getHours() +
                ":" +
                this.date.getMinutes() +
                ":" +
                this.date.getSeconds(),

            homeButtonState: false,
            returnButtonState: false,
            multiTaskButtonState: false,
        };
    }

    timerLoop = () => {
        this.date = new Date();
        this.setState({
            topStateBarTime:
                this.date.getHours() +
                ":" +
                this.date.getMinutes() +
                ":" +
                this.date.getSeconds(),
        });
    };

    componentDidMount = () => {
        setInterval(() => this.timerLoop(), 1000);
    };

    //#region 下方导航栏事件
    onHomeButtonClick = () => {
        this.setState({
            homeButtonState: true,
        });
    };
    onReturnButtonClick = () => {
        this.setState({
            returnButtonState: true,
        });
    };
    onMultiTaskButtonClick = () => {
        this.setState({
            multiTaskButtonState: true,
        });
    };
    onHomeButtonRelease = () => {
        this.setState({
            homeButtonState: false,
        });
    };
    onReturnButtonRelease = () => {
        this.setState({
            returnButtonState: false,
        });
    };
    onMultiTaskButtonRelease = () => {
        this.setState({
            multiTaskButtonState: false,
        });
    };
    //#endregion

    render = () => {
        return (
            <div className="root-container" ref={this.rootContainerRef}>
                <img src={backdrop} alt="Backdrop" className="backdrop"></img>
                <div className="screen-container" ref={this.screenViewRef}>
                    <div className="screen-view">
                        <div className="grid-item">
                            <div className="top-state-bar">
                                <h1 className="top-state-bar-dateTime">
                                    {this.state.topStateBarTime}
                                </h1>
                                <div></div>
                                <div>
                                    {/* TODO:信號和wifi */}
                                    TODO:信號和wifi
                                </div>
                            </div>
                        </div>
                        <div className="grid-item">
                            <div className="center-system-render">
                                <System
                                    style={{overflow: 'scroll'}}
                                    homeButtonState={this.state.homeButtonState}
                                    returnButtonState={
                                        this.state.returnButtonState
                                    }
                                    multiTaskButtonState={
                                        this.state.multiTaskButtonState
                                    }
                                    phoneData={this.props.phoneData}
                                />
                            </div>
                        </div>
                        <div className="grid-item">
                            <div className="bottom-nav-bar">
                                <div
                                    onMouseUp={this.onReturnButtonRelease}
                                    onMouseDown={this.onReturnButtonClick}
                                    onDoubleClick={() => {
                                        this.onHomeButtonClick();
                                        setTimeout(() => {
                                            this.onHomeButtonRelease();
                                        },10)
                                    }}
                                    className="bottom-nav-bar-icon"
                                >
                                    {"◁"}
                                </div>
                                <div
                                    onMouseUp={this.onHomeButtonRelease}
                                    onMouseDown={this.onHomeButtonClick}
                                    className="bottom-nav-bar-icon"
                                >
                                    {"▢"}
                                </div>
                                <div
                                    onMouseUp={this.onMultiTaskButtonRelease}
                                    onMouseDown={this.onMultiTaskButtonClick}
                                    className="bottom-nav-bar-icon"
                                >
                                    {"▤"}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        );
    };
}