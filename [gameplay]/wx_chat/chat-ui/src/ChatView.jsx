import "./index.css"
import React from "react"
export default function ChatView() {    
    const [chatList, setChatList] = React.useState([
        {
            Source: "Pitter",
            Message:
                "Hello World 德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜",
            Time: new Date(),
            Type: "Text",
        },
        {
            Source: "Pitter",
            Message:
                "<h1>Hello World 德瓦达我对我的</h1>启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜",
            Time: new Date(),
            Type: "Text",
        },
        {
            Source: "Pitter",
            Message:
                "Hello World 德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜",
            Time: new Date(),
            Type: "Text",
        },
        {
            Source: "Pitter",
            Message:
                "Hello World 德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜",
            Time: new Date(),
            Type: "Text",
        },
        {
            Source: "Pitter",
            Message:
                "Hello World 德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜",
            Time: new Date(),
            Type: "Text",
        },
        {
            Source: "Pitter",
            Message:
                "Hello World 德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜",
            Time: new Date(),
            Type: "Text",
        },
        {
            Source: "Pitter",
            Message:
                "Hello World 德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜",
            Time: new Date(),
            Type: "Text",
        },
        {
            Source: "Pitter",
            Message:
                "Hello World 德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜德瓦达我对我的启动巨大囧为基地哦呜",
            Time: new Date(),
            Type: "Text",
        },
    ]);

    const [showTextarea, setShowTextarea] = React.useState(true);

    var chatRef = React.useRef(null);
    
    React.useEffect(() => {
        chatRef.current.scrollTop = chatRef.current.scrollHeight;
    })

    return (
        <div>
            <div
                ref={chatRef}
                className="chat-view"
                style={{
                    borderRadius: showTextarea
                        ? "20px 20px 0 0"
                        : "20px 20px 20px 20px",
                }}
            >
                <ul className="chat-list">
                    {chatList.map((msg, index) => (
                        <li className="chat-msg" style={{"--indexOfAnime":index*100+"ms"}} key={index}>
                            {msg.Source} : {msg.Message}
                        </li>
                    ))}
                </ul>
            </div>
            <textarea
                className="chat-type"
                style={{ opacity: showTextarea ? 1 : 0 }}
            />
        </div>
    );
}