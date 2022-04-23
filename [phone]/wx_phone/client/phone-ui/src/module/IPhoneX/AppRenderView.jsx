import React from "react";
import "./AppView.css"

export default class AppRenderView extends React.Component {
    constructor(props) {
        super(props);
        this.iframeRef = React.createRef();
    }

    componentDidUpdate(PrevProps, prevState) {
        if (PrevProps.returnButton !== this.props.returnButton) {
            if (this.props.returnButton) {
                this.iframeRef.current.contentWindow.postMessage({
                    type: "returnButtonPress",
                });
            } else {
                this.iframeRef.current.contentWindow.postMessage({
                    type: "returnButtonRelease",
                });
            }
        }
        if (PrevProps.homeButton !== this.props.homeButton) {
            if (this.props.homeButton) {
                this.iframeRef.current.contentWindow.postMessage({
                    type: "homeButtonPress",
                });
            } else {
                this.iframeRef.current.contentWindow.postMessage({
                    type: "homeButtonRelease",
                });
            }
        }
        if (PrevProps.taskButton !== this.props.taskButton) {
            if (this.props.taskButton) {
                this.iframeRef.current.contentWindow.postMessage({
                    type: "taskButtonPress",
                });
            } else {
                this.iframeRef.current.contentWindow.postMessage({
                    type: "taskButtonRelease",
                });
            }
        }
    }

    render = () => {
        return (
            <iframe
                className="iphoneX-system-appRenderView"
                src={this.props.app.AppUrl}
                title={this.props.app.AppPackageName}
                ref={this.iframeRef}
                height="100%"
                width="100%"
                style={{
                    borderRadius: "2vh",
                    border: "none",
                }}
            />
        );
    };
}