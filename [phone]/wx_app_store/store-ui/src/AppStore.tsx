import { AppStoreContext , AppCardContext} from "./AppStoreContext"
import { AppIcon } from "./components"
import style from "./AppStore.module.css"

function AppStore() {
    return (
        <div>
            <AppStoreContext.Consumer>
                {({ appList }) => (
                    <div className={style.appCardList}>
                        {appList.map((app, index) => (
                            <div>
                                <AppCardContext.Provider
                                    value={{ app }}
                                    key={index}
                                >
                                    <AppIcon
                                        style={{
                                            width: "100%",
                                        }}
                                    />
                                </AppCardContext.Provider>
                            </div>
                        ))}
                    </div>
                )}
            </AppStoreContext.Consumer>
        </div>
    );
}



export default AppStore