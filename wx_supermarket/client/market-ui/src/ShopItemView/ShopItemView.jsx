import "./ShopItemView.css";
import React from 'react';
import $ from "jquery";
import "jquery-ui-dist/jquery-ui"


export default function ShopItemView(props) {
    const { item, index } = props;
    const ComponentRef = React.useRef(null);
    
    React.useEffect(() => {
        $(ComponentRef.current).hide(0);
        setTimeout(() => {
            $(ComponentRef.current).fadeIn(200);
            $(ComponentRef.current).draggable({
                revert: true,
                scroll: false,
                zIndex: 10000,
                opacity: 0.9,
                cursor: "grabbing",
                revertDuration: 200,
                refreshPositions: true,
                helper: "clone",
            });
        }, index*100);
    });

    
    const Render = () => {
        return (
            <div
                className="shop-view-item"
                ref={ComponentRef}
                item={JSON.stringify(item)}
            >
                <img
                    className="shop-view-item-icon"
                    src={item.ItemImage}
                    alt={item.ItemDisplayName}
                />
                <div className="shop-view-item-info">
                    <div className="shop-view-item-name">
                        {item.ItemDisplayName} (库存:{item.ItemInStock})
                    </div>
                    {item.ItemOnSale ? (
                        <div>
                            <div
                                className="shop-view-item-price"
                                style={{
                                    textDecoration: "line-through",
                                    display: "inline",
                                }}
                            >
                                ${item.ItemPrice}
                            </div>
                            <h2
                                style={{
                                    display: "inline",
                                    maringLeft: "20px",
                                }}
                            >
                                特价：${item.ItemDiscountPrice}
                            </h2>
                        </div>
                    ) : (
                        <div className="shop-view-item-price">
                            ${item.ItemPrice}
                        </div>
                    )}
                </div>
            </div>
        );
    }
    return <Render />
}