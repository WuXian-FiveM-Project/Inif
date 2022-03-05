import react from "react";
import Popover from '@mui/material/Popover';
import Button from '@mui/material/Button';
import DialogTitle from '@mui/material/DialogTitle';
import Dialog from '@mui/material/Dialog';
import Slider from '@mui/material/Slider';
import TextField from "@mui/material/TextField";
import Tooltip from "@mui/material/Tooltip";
import React from "react";


export default function InventoryItem(props) {
    var { itemName,displayName, image, currentAmount, maxAmount, canUse, canThrow, canTransfer, maxUseAmount, maxThrowAmount, maxTransferAmount, itemDescription} = props;
    const [ dropDownStatus, setDropDownStatus ] = react.useState(false);
    const [anchorEl, setAnchorEl] = react.useState(null);
    const [dialogStatus, setDialogStatus] = react.useState(false);
    const [currentSelectData, setCurrentSelectData] = react.useState({ method :'',max:0,min:0});
    
    maxUseAmount = Math.min(maxUseAmount, currentAmount);
    maxThrowAmount = Math.min(maxThrowAmount, currentAmount);
    maxTransferAmount = Math.min(maxTransferAmount, currentAmount);
    
    

    function SimpleDialog(props) {
        const { onClose, selectedValue, open } = props;
        const [sliderValue,SetSliderValue] = react.useState(0);
        const handleClose = () => {
            onClose(selectedValue);
        };

        const confirmAction = () => {
            setDialogStatus(false);
            fetch(`https://wx_inventory_ui/itemAction`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    itemName: itemName,
                    action: currentSelectData.method,
                    amount: sliderValue
                })
            });
        }

        const onSliderChange = (event, newValue) => {
            newValue = newValue || event.target.value;
            if (typeof newValue != 'number') {
                newValue = parseInt(newValue);
            }
            if (newValue <= currentSelectData.max && newValue >= currentSelectData.min) {
                SetSliderValue(newValue);
            }
        }

        return (
            <Dialog onClose={handleClose} open={open} maxWidth="xl" fullWidth>
                <DialogTitle>{currentSelectData.method}{displayName}</DialogTitle>
                <Slider
                    style={{
                        width: '95%',
                        display: 'block',
                        margin: 'auto',
                    }}
                    aria-label="Amount"
                    defaultValue={currentSelectData.min+1}
                    valueLabelDisplay="auto"
                    step={1}
                    marks
                    min={currentSelectData.min}
                    max={currentSelectData.max}
                    onChange={onSliderChange}
                    value={sliderValue}
                />
                <TextField value={sliderValue} onChange={onSliderChange}></TextField>
                <Button onClick={confirmAction} style={{width: '100%',fontSize:"34px"}}>確認</Button>
            </Dialog>
        );
    }

    const handleDialogOpen = () => {
        setDialogStatus(true);
    };


    const showDropdownMenu = (event) => {
        setDropDownStatus(true)
        setAnchorEl(event.currentTarget);
    }
    const closeDropDownMenu = () => {
        setDropDownStatus(false)
        setDropDownStatus(null);
    }

    const useItem = () => {
        closeDropDownMenu()
        handleDialogOpen()
        setCurrentSelectData({ method : '使用',max:maxUseAmount,min:1})
    }

    const throwItem = () => {
        closeDropDownMenu()
        setCurrentSelectData({ method: '丢弃', max: maxThrowAmount, min: 1 })
        handleDialogOpen()
    }

    const transferItem = () => {
        closeDropDownMenu()
        setCurrentSelectData({ method: '转移', max: maxTransferAmount, min: 1 })
        handleDialogOpen()
    }

    

    return (
        <div>
            <SimpleDialog
                open={dialogStatus}
                onClose={setDialogStatus}
            />
            <Tooltip title={<h2>{itemDescription}</h2>} arrow followCursor>
                <div
                    onClick={showDropdownMenu}
                    style={{
                        width: '100%',
                        backgroundColor: "rgba(255,255,255,0.8)",
                        borderRadius: "10px",
                        padding: "5px",
                        boxShadow: "0px 0px 50px -2px black",
                        border: "3px solid rgba(0,0,0,0.2)",
                    }}
                >
                    <p
                        style={{
                            fontWeight: "bold",
                            fontSize: "40px",
                            margin: "10px 0 10px 0",
                            textAlign: "center",
                            filter: "drop-shadow(0px 0px 1px rgb(255,255,255))",
                            fontFamily: "Sans-serif"
                        }}
                    >
                        {displayName}
                    </p>
                    <img
                        style={{
                            width: '100%',
                            borderRadius: "10px",
                        }}
                        src={image}
                        alt={displayName}
                        ></img>
                    <p
                        style={{
                            margin: "10px 0 10px 0",
                            fontSize: "20px",
                            fontFamily: "Sans-serif",
                        }}
                    >
                        數量: {currentAmount}/{maxAmount}</p>
                </div>
            </Tooltip>
            <Popover
                open={dropDownStatus}
                anchorEl={anchorEl}
                onClose={closeDropDownMenu}
                anchorOrigin={{
                    vertical: 'bottom',
                    horizontal: 'left',
                }}
                style={{
                    padding: "1000px",
                }}
            >
                {canUse ?
                    <Button style={{width: "100%", fontSize: "30px"}} onClick={useItem} variant = "contained">使用</Button> :
                    <Button style={{ width: "100%", fontSize:  "25px"}} variant="contained" disabled>使用</Button>
                }
                {canThrow ?
                    <Button style={{ width: "100%", fontSize: "30px" }} onClick={throwItem} variant="contained">丢弃</Button> :
                    <Button style={{ width: "100%", fontSize: "25px" }} variant="contained" disabled>丢弃</Button>
                }
                {canTransfer ?
                    <Button style={{ width: "100%", fontSize: "30px" }} onClick={transferItem} variant="contained">转移</Button> :
                    <Button style={{ width: "100%", fontSize: "25px" }} variant="contained" disabled>转移</Button>
                }
            </Popover>
        </div>
    )
}














