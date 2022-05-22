import { AppCardContext } from "../../AppStoreContext";
import style from "./AppIcon.module.css";
import React from "react"

class AppIcon extends React.Component<React.ComponentProps<"div">> {
    render() {
        return (
            <AppCardContext.Consumer>
                {({ app }) => (
                    <div className={style.container} {...this.props}>
                        <div className={style.iconContainer}>
                            <img alt={app.AppPackageName} src={app.AppIcon} />
                            <p className={style.iconName}>{app.AppName}</p>
                        </div>
                        <div className={style.iconDescription}>
                            <p className={style.iconDescriptionWord}>
                                {app.AppDescription}
                            </p>
                        </div>
                    </div>
                )}
            </AppCardContext.Consumer>
        );
    }
}

export default AppIcon;