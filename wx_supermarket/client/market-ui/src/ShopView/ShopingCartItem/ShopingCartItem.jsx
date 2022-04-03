import {Typography} from "@mui/material";

export default function ShopingCartItem(props) {
    const { item } = props;
    console.log(item)
    return (
        <div>
            <Typography variant="h4">{item.ItemDisplayName}</Typography>
            <Typography variant="h4">数量：{item.ItemCount}</Typography>
            <Typography variant="h5">总价格:${item.ItemOnSale ?
                item.ItemCount * item.ItemDiscountPrice
                :
                item.ItemCount * item.ItemPrice}
            </Typography>
        </div>
    );
}