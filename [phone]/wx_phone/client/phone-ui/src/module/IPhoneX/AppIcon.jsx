import "./AppIcon.css"

export default function AppIcon (props) {
    const { app } = props

    return (
        <div className="iphoneX-system-appIconGrid" onClick={props.onClick}>
            <img src={app.AppIcon} alt={app.AppPackageName} />
            <p>{app.AppName}</p>
        </div>
    );
}
