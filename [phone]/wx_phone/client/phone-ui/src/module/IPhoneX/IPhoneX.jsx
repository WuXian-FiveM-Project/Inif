import React from 'react';
import Backdrop from "./Backdrop.png"
import System from "./System"
import "./iPhoneX.css"

class IPhoneX extends React.Component {
    render () {
        return (
            <div>
                <div className="iphoneX-container">
                    <img src={Backdrop} className="iphoneX-backdrop" alt="背板"/>
                    <div className="iphoneX-screenView">
                        <System phoneData={this.props.phoneData}/>
                    </div>
                </div>
            </div>
        );
    }
}

export default IPhoneX;