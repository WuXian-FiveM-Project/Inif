import "./ShopView.css"
import {
    Box,
    Tab,
    Tabs,
    Typography,
    Grid,
    Alert,
    Collapse,
    ButtonGroup,
    Button,
    Fab,
} from "@mui/material";
import React from "react";
import ShopItemView from "../ShopItemView/ShopItemView";
import $ from "jquery";
import "jquery-ui-dist/jquery-ui";
import ShopingCartItem from "./ShopingCartItem/ShopingCartItem";

function TabPanel(props) {
    const { children, value, index, ...other } = props;

    return (
        <div
            role="tabpanel"
            hidden={value !== index}
            id={`full-width-tabpanel-${index}`}
            aria-labelledby={`full-width-tab-${index}`}
            {...other}
        >
            {value === index && (
                <Box sx={{ p: 3 }}>
                    <Typography>{children}</Typography>
                </Box>
            )}
        </div>
    );
}


export default function ShopView(props) {
    const { shopItem } = props;
    const [tabIndex, setTabIndex] = React.useState(0);
    const [shopingCartItem, setShopingCartItem] = React.useState([]);

    const tabIndexChangeHandler = (_, newIndex) => {
        setTabIndex(newIndex);
    }

    const [, forceUpdate] = React.useReducer((x) => x + 1, 0);

    const [itemTypeList, setItemTypeList] = React.useState([]);

    const ShoppingCardRef = React.useRef(null);

    React.useEffect(() => {
        shopItem.forEach((item) => {
            if (itemTypeList.indexOf(item.ItemType) === -1) {
                setItemTypeList([...itemTypeList, item.ItemType]);
            }
        }, []);
        $("#dialog").hide();

        $(ShoppingCardRef.current).droppable({
            over: function (event, ui) {
                $(ShoppingCardRef.current).css("opacity", 0.1);
            },
            out: function (event, ui) {
                $(ShoppingCardRef.current).css("opacity", 1);
            },
            drop: function (event, ui) {
                $(ShoppingCardRef.current).css("opacity", 1);
                const item = JSON.parse(ui.draggable.attr("item"));
                var isInCart = false;
                if (item.ItemInStock !== 0) {
                    shopingCartItem.forEach((cartItem,index) => {
                            console.log(cartItem.ItemDisplayName);
                            if (cartItem.IID === item.IID) {
                                cartItem.ItemCount++;
                                isInCart = true;
                            }
                    });


                    if (!isInCart) {
                        setShopingCartItem([
                            ...shopingCartItem,
                            {
                                ...item,
                                ItemCount: 1,
                            },
                        ]);
                    }
                    forceUpdate();
                } else {
                    noStockAlertShow(2000)
                }
            },
        });
    });
    const noStockAlertShow = (durations) => {
        setNoStockAlert(true)
        setTimeout(() => {
            setNoStockAlert(false);
        }, durations);
    };

    const [noStockAlert, setNoStockAlert] = React.useState(false);

    const buy = () => {
        
    }

    const Render = () => {
        return (
            <div className="shop-view-container">
                <Collapse in={noStockAlert}>
                    <Alert
                        variant="filled"
                        severity="warning"
                        style={{
                            position: "absolute",
                            top: "50%",
                            left: "50%",
                            transform: "translate(-50%, -50%)",
                            zIndex: "1000",
                        }}
                    >
                        <h1>已售罄</h1>
                    </Alert>
                </Collapse>
                <h1>商店</h1>
                <Box className="shop-view-tab-container">
                    <Tabs
                        value={tabIndex}
                        onChange={tabIndexChangeHandler}
                        textColor="inherit"
                    >
                        {itemTypeList.map((item, index) => {
                            return <Tab label={item} key={index} />;
                        })}
                    </Tabs>
                    {itemTypeList.map((Type, TypeIndex) => {
                        return (
                            <TabPanel
                                value={tabIndex}
                                index={TypeIndex}
                                key={TypeIndex}
                            >
                                <Grid container spacing={2}>
                                    {shopItem
                                        .filter(
                                            (item) =>
                                                item.ItemType ===
                                                itemTypeList[TypeIndex]
                                        )
                                        .map((Item, ItemIndex) => {
                                            return (
                                                <Grid item xs={2}>
                                                    <ShopItemView
                                                        item={Item}
                                                        index={ItemIndex}
                                                        key={ItemIndex}
                                                    />
                                                </Grid>
                                            );
                                        })}
                                </Grid>
                            </TabPanel>
                        );
                    })}
                </Box>
                <Grid
                    container
                    spacing={2}
                    className="shoping-cart-container"
                    ref={ShoppingCardRef}
                >
                    <Typography variant="h4">&ensp;购物车</Typography>
                    <br></br>
                    {shopingCartItem.map((item, index) => {
                        return (
                            <Grid item xs={2} key={index}>
                                <ShopingCartItem item={item} index={index} />
                                <ButtonGroup variant="contained">
                                    <Button
                                        onClick={() => {
                                            if (item.ItemCount > 1) {
                                                item.ItemCount--;
                                                setShopingCartItem([
                                                    ...shopingCartItem,
                                                ]);
                                            }
                                        }}
                                    >
                                        -
                                    </Button>
                                    <Typography
                                        variant="h4"
                                        style={{
                                            marginLeft: 15,
                                            marginRight: 15,
                                        }}
                                    >
                                        {item.ItemCount}
                                    </Typography>
                                    <Button
                                        onClick={() => {
                                            if (
                                                item.ItemCount <
                                                item.ItemInStock
                                            ) {
                                                item.ItemCount++;
                                                setShopingCartItem([
                                                    ...shopingCartItem,
                                                ]);
                                            }
                                        }}
                                    >
                                        +
                                    </Button>
                                </ButtonGroup>
                            </Grid>
                        );
                    })}
                </Grid>
                <Fab
                    color="primary"
                    style={{
                        position: "fixed",
                        bottom: "10px",
                        right: "10px",
                    }}
                >
                    <Typography onClick={buy}>结账</Typography>
                </Fab>
            </div>
        );
    }
    return <Render />
}