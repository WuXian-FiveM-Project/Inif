import React from 'react';
import "./InAppView.css";

export default class InAppView extends React.Component {
    render() {
        return (
            <div className="InAppView-container">
                <iframe
                    className="InAppView-view"
                    title="InAppView"
                    height="100%"
                    width="100%"
                    src={this.props.appProps.AppUrl}
                ></iframe>
            </div>
        );
    }
}