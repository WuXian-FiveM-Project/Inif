
import IPhoneX from './module/IPhoneX/IPhoneX';

export default function Phone(props) {
    switch (props.phoneData.PhoneModule) {
        case "iPhone X":
            return <IPhoneX phoneData={props.phoneData} />;
        default:
            return (
                <div>
                    <h1>
                        机型信息错误：@wx_phone/client/phone-ui/src/Phone.jsx:13:13
                    </h1>
                </div>
            );
    }
}