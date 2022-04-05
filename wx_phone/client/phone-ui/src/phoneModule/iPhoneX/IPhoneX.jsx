import "./iPhoneX.css"
import "./Backdrop.png";

import React from "react";

export default class IPhoneX extends React.Component {
    constructor(props) {
        super(props);
        const phoneData = props.phoneData;
    
        this.rootContainerRef = React.createRef();
        this.screenViewRef = React.createRef();
    }

    componentDidMount() {

    }

    render() {
        return (
            <div className="root-container">
                <img src="./Backdrop.png" alt="Backdrop" className="backdrop" />
                <div className="screen-view" ref={this.screenViewRef}>
                    dwaadww
                </div>
            </div>
        );
    }
}