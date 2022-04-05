import "./ShopHandler.css";
import React from "react"
import ShopView from "../ShopView/ShopView";

export default function ShopHandler() {
    const [show, setShow] = React.useState(false)
    const [shopItem, setShopItem] = React.useState([
        {
            IID: 1,
            ItemDisplayName: "Shop Item",
            ItemName: "shop_item",
            ItemPrice: 100,
            ItemDiscountPrice: 99,
            ItemOnSale: false,
            ItemType: "测试",
            ItemCanSale: true,
            ItemInStock: 10,
            ItemImage:
                "data:image/jpeg;base64,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",
        },
        {
            IID: 2,
            ItemDisplayName: "Shop Item",
            ItemName: "shop_item",
            ItemPrice: 100,
            ItemDiscountPrice: 99,
            ItemOnSale: false,
            ItemType: "测试",
            ItemCanSale: true,
            ItemInStock: 0,
            ItemImage: "https://i.ytimg.com/vi/ubnLs5A5KFc/maxresdefault.jpg",
        },
        {
            IID: 3,
            ItemDisplayName: "Shop Item",
            ItemName: "shop_item",
            ItemPrice: 100,
            ItemDiscountPrice: 99,
            ItemOnSale: true,
            ItemType: "测试",
            ItemCanSale: true,
            ItemInStock: 10,
            ItemImage: "https://i.ytimg.com/vi/ubnLs5A5KFc/maxresdefault.jpg",
        },
        {
            IID: 3,
            ItemDisplayName: "Shop Item",
            ItemName: "shop_item",
            ItemPrice: 100,
            ItemDiscountPrice: 99,
            ItemOnSale: true,
            ItemType: "测试",
            ItemCanSale: true,
            ItemInStock: 10,
            ItemImage: "https://i.ytimg.com/vi/ubnLs5A5KFc/maxresdefault.jpg",
        },
        {
            IID: 4,
            ItemDisplayName: "Shop Item",
            ItemName: "shop_item",
            ItemPrice: 100,
            ItemDiscountPrice: 99,
            ItemOnSale: true,
            ItemType: "测试",
            ItemCanSale: true,
            ItemInStock: 10,
            ItemImage: "https://i.ytimg.com/vi/ubnLs5A5KFc/maxresdefault.jpg",
        },
        {
            IID: 5,
            ItemDisplayName: "Shop Item",
            ItemName: "shop_item",
            ItemPrice: 100,
            ItemDiscountPrice: 99,
            ItemOnSale: true,
            ItemType: "测试",
            ItemCanSale: true,
            ItemInStock: 10,
            ItemImage: "https://i.ytimg.com/vi/ubnLs5A5KFc/maxresdefault.jpg",
        },
        {
            IID: 6,
            ItemDisplayName: "Shop Item",
            ItemName: "shop_item",
            ItemPrice: 100,
            ItemDiscountPrice: 99,
            ItemOnSale: true,
            ItemType: "测试",
            ItemCanSale: true,
            ItemInStock: 10,
            ItemImage: "https://i.ytimg.com/vi/ubnLs5A5KFc/maxresdefault.jpg",
        },
        {
            IID: 7,
            ItemDisplayName: "Shop Item",
            ItemName: "shop_item",
            ItemPrice: 100,
            ItemDiscountPrice: 99,
            ItemOnSale: true,
            ItemType: "测试",
            ItemCanSale: true,
            ItemInStock: 10,
            ItemImage: "https://i.ytimg.com/vi/ubnLs5A5KFc/maxresdefault.jpg",
        },
        {
            IID: 8,
            ItemDisplayName: "Shop Item",
            ItemName: "shop_item",
            ItemPrice: 100,
            ItemDiscountPrice: 99,
            ItemOnSale: true,
            ItemType: "测试",
            ItemCanSale: true,
            ItemInStock: 10,
            ItemImage: "https://i.ytimg.com/vi/ubnLs5A5KFc/maxresdefault.jpg",
        },
        {
            IID: 9,
            ItemDisplayName: "Shop Item",
            ItemName: "shop_item",
            ItemPrice: 100,
            ItemDiscountPrice: 99,
            ItemOnSale: true,
            ItemType: "测试2",
            ItemCanSale: true,
            ItemInStock: 10,
            ItemImage:
                "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxEHBhUSBxITFREWFhoVExUXGB0YGxYaGBYbFxcYExUYICggGx8lHRcaIjEhMSo3Ly4uFx8zODM4NygtLisBCgoKDg0ODw8NDzcZFR0rLSstMjgrNystKysrKysrNystLjArKysrKysrKysrKzc3KysrLSsrKysrKysrKysrK//AABEIALsBDQMBIgACEQEDEQH/xAAcAAEAAgIDAQAAAAAAAAAAAAAABAYFBwIDCAH/xAA9EAACAQMBBAcFBgMJAQAAAAAAAQIDBBEFEiExQQYiUXGBkaEHEzJSYRQjQnKxwSRikjM0U3OCorPR4SX/xAAVAQEBAAAAAAAAAAAAAAAAAAAAAf/EABgRAQEAAwAAAAAAAAAAAAAAAAARAQIh/9oADAMBAAIRAxEAPwDbgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPgA+gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAY+51q3ta2zXqxT58cLva3IDIA67avC7p7VrKM12xakvQ7JRaA4ykorMmQbrUNhYoLf2vh5EDX3cqD+wJL+bCm/6W1j1K9pmrXlzcbFzb5gniVXEqOP9E85fcyVYssdblT/t4Z+sX+zJVDWqFX4p7L7JbvXgYKut5BrR7QL1CanHMGmu1PPqjka7jKVCeaEpRf8AK8foTaHSK5oPrSjNfzLf5rBUXcFdtOlUak1G4pTTfydb03MsEJbccrPisPxTA5AAAAAAAAAAAAAAAAAAAAAAAAAFe6e65Po90Wq17XHverTp53pSqS2VJrnjOcfQCwPct/A6at1GC3bzzbS6TX8Lp1Hd1ZSby3J5XlyLPpvtPuKKxqdNVF8y4+gGzNW1CU4tOWF2L9+0pGr3OM4Z30+mFrqscU57E/llu9TF6xLMMreu1b15gUvV9Rq2uqqdjUqU5KK60JOD4vnFozmke1XU9PwripC4h2VYra8KkMPzyVTWJ5vn3Iggbo032w2t0satRqUXzlH72PolJeTLNYdILTWo50y4p1H8qeJeMJYkvI844Cjlrdl8iRXpKuscSua1ptW8lF29aUGnxTaSX5V8XmjWWk6/qGnxXuK83Bfgn94mu6eX5NGzehmrvpTHZ6kKiW1J53OPNxT3965EzrRFsbe6o1cXtWMocsx6z8Vw9Szad0bq3q2q/wB3T+Z8X3Iy1CNtpclsYnVbwpS3LPZFczsq3Uq7+8fh/wCDHBIsrehpccWUNqfOciTRqOrlz45/YxX2mMaijne3jC7cN7+zcmZGweaL72USQAVAAAAAAAAAAAAAAAAAAAAAAKR7Y1noJP8AzaP/ACIu5T/axT970FrJcpUpeVaH7AaLsLCd/UcbfZ2ks4bxlfQ417adtPFeLT4r6rtT4MyvRVqGpNzcV1Gll4y3jh28CXd2n/xaMdQkoSUpKLabxF5eHjfyXoBXHTU/iRItrqtaP+FqSX0zlf8AfqZTVLenDTKMqcY7UspzjlJ7PNL69pH1DT/s1RKhtyTim8xaw9+eX0AjVq8Lvff0VtP8dJ7Mu9rh6Miy02nVf8DWWfkqLZl4NcfJHacvdqa66TAx9CxnVuNj8XDHa+xd/IyVnYYfAhXNWVpdQll7OcZ5rx+nFGc1e/2Lt+6XxJSb+sopv1yB2U6UbeOZ4Ojobqbs+m2zQ+Cc8JfmWH+r9DHyqubzNnDotLa6cUsf4i/YDe1zp1K8vKdWvtbdJt08Pq9bGXKON76qxvOVre1amp1KdSjKNOOz7uWHmq2t7guaXDvTJ9rp1S431epH/c+5cjL29tG2jiku98W+9kVgtF6PTopu+klmTmow3Yzn4nl8myxUoKlBKmsJcEclwPpUAAAAAAAAAAAAAAAAAAAAAAAACFrOnQ1fSatvc/DVhKDa4rK3NfVPD8CaAPNGt6NW0LUJUdSjiSbw/wAM1ynB9j9ODIeXJLab3cPp3Hpu+sqWoUNi+pwqQ+WcVJepTNY9l1neZenSnQl2Lrw/plvXgwNWR1KFWhCF1T3Qzs7L3b1jrRl58TMWt3CtXXuJJ4ouGHuecrdh8Tlq/s7v9My6dNVoLnS3vxpvf5ZKvUpypTca0XGS4qSw13p7wLRRS+30W4pOVFuWEln4Xw8WYXUrBWTWZ5k8txxw39p1Wt9UtmvdS4cE96WezPA7bm9V1bJVo9ePwyXY3waYGB1tfwL70K1bEIc3sR/Q5a3/AHB96/U79N0OvrFWnGyg393BZxu4AQHUbMv7N7OpX9odvsReI1NqX0UYttvyNj6F7KnQtNq4qRjWfBuO3s/VLKWfMuHRLobb9F6bdrmdaXx1Z/E/okuCAsh8CPoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgano1tq1PGpUadTscoptfllxRPAGvNX9llGs3LSas6b5Qn14+DWJL1KVq/Qm/wBKealF1IfPS668UusvI3wAPNtv0fr9ILiNCypybcltSw1GC5ucuC7uJv3o5oNLQNMp0rWKzGCjKXOTS35feZTB9AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/9k=",
        },
    ]);

    window.onkeydown = function (e) {
        if (e.keyCode === 27) {
            e.preventDefault();
            e.stopPropagation();
            setShow(false);
            fetch(`https://wx_supermarket/closeShop`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json; charset=UTF-8",
                },
            });
        }
    };

    window.addEventListener('message', function (event) {
        if (event.data.type === "showShop") {
            setShow(true);
            setShopItem(event.data.shopItem);
        }
    })

    const Render = () => {
        return (
            <div className="shop-container">
                <ShopView shopItem={shopItem} setShow={setShow} />
            </div>
        );
    }
    return show?<Render/>:<div></div>
}