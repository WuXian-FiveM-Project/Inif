
import IPhoneX from './module/IPhoneX/IPhoneX';

function Phone (props) {
    const phoneData = props.phoneData;

    switch (phoneData.PhoneModule) {
        case "iPhone X":
            return (
                <IPhoneX phoneData={phoneData}/>
            )
        default:
            return (
                <div>
                    <h1>机型信息错误：@wx_phone/client/phone-ui/src/Phone.jsx:13:13</h1>
                </div>
            )
    }
}

export default Phone;