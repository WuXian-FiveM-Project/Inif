import React from 'react'
import "./AppIconComponent.css";

export default class AppIconComponent extends React.Component {
    render() {
        return (
            <div className="appIcon-container" onClick={(event) => {
                event.preventDefault();
                this.props.onClick(event);
            }}>
                <img className="appIcon-icon" src={this.props.appIcon} alt={this.props.appName}></img>
                <p>{this.props.appName}</p>
            </div>
        );
    }
}