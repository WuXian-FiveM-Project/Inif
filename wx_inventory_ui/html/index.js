const {Accordion, AccordionActions, AccordionDetails, AccordionSummary, AppBar, Avatar, Backdrop, Badge, BottomNavigation, BottomNavigationAction, Box, Breadcrumbs, Button, ButtonBase, ButtonGroup, Card, CardActionArea, CardActions, CardContent, CardHeader, CardMedia, Checkbox, Chip, CircularProgress, ClickAwayListener, Collapse, Container, CssBaseline, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, Divider, Drawer, ExpansionPanel, ExpansionPanelActions, ExpansionPanelDetails, ExpansionPanelSummary, Fab, Fade, FilledInput, FormControl, FormControlLabel, FormGroup, FormHelperText, FormLabel, Grid, GridList, GridListTile, GridListTileBar, Grow, Hidden, Icon, IconButton, ImageList, ImageListItem, ImageListItemBar, Input, InputAdornment, InputBase, InputLabel, LinearProgress, Link, List, ListItem, ListItemAvatar, ListItemIcon, ListItemSecondaryAction, ListItemText, ListSubheader, Menu, MenuItem, MenuList, MobileStepper, Modal, ModalManager, MuiThemeProvider, NativeSelect, NoSsr, OutlinedInput, Paper, Popover, Popper, Portal, Radio, RadioGroup, RootRef, Select, ServerStyleSheets, Slide, Slider, Snackbar, SnackbarContent, Step, StepButton, StepConnector, StepContent, StepIcon, StepLabel, Stepper, StylesProvider, SvgIcon, SwipeableDrawer, Switch, Tab, TabScrollButton, Table, TableBody, TableCell, TableContainer, TableFooter, TableHead, TablePagination, TableRow, TableSortLabel, Tabs, TextField, TextareaAutosize, ThemeProvider, Toolbar, Tooltip, Typography, Unstable_TrapFocus, Zoom, alpha, capitalize, colors, createChainedFunction, createGenerateClassName, createMuiTheme, createStyles, createSvgIcon, createTheme, darken, debounce, decomposeColor, deprecatedPropType, duration, easing, emphasize, fade, getContrastRatio, getLuminance, hexToRgb, hslToRgb, isMuiElement, isWidthDown, isWidthUp, jssPreset, lighten, makeStyles, ownerDocument, ownerWindow, recomposeColor, requirePropFactory, responsiveFontSizes, rgbToHex, setRef, styleFunction, styled, unstable_createMuiStrictModeTheme, unstable_useId, unsupportedProp, useControlled, useEventCallback, useForkRef, useFormControl, useIsFocusVisible, useMediaQuery, useRadioGroup, useScrollTrigger, useTheme, withMobileDialog, withStyles, withTheme, withWidth } = MaterialUI;

const Item = styled(Button)(({ theme }) => ({
    ...theme.typography.body2,
    padding: theme.spacing(1),
    textAlign: 'center',
    color: "white",
    background: "rgb(100,100,100)"
}));
const itemData = [
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'wdaaaaaaaaaaaaa',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: '42222222222222222',
        itemAmount: 100,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
    {
        img: 'https://images.unsplash.com/photo-1551963831-b3b1ca40c98e',
        itemName: 'test item',
        itemAmount: 1,
        itemMaxAmount: 100,
    },
];

function Inventory_ItemComponent() {


    const [open, setOpen] = React.useState(false);
    const [ItemState, SetItemState] = React.useState(itemData);
    const [amount, SetAmount] = React.useState(0);


    var currentlyItemData = "null"

    const handleClickOpen = (item) => {
        SetItemState(item)
        setOpen(true);
        SetAmount(item.itemAmount)
    };

    const handleClose = () => {
        setOpen(false);
    };

    function valuetext(value) {
        return `${value}°C`;
    }

    function amountChangeHandler(e) {
        SetAmount(e.target.value)
    }

    function useItemHandler() {
        
    }
    function throwItemHandler() {

    }
    function transferItemHandler() {
        
    }

    return (
        <ImageList rowHeight={150} gap={1} cols={12}>
            {itemData.map((item) => {
                return (
                    <ImageListItem cols={1} key={item.img} onClick={() => { handleClickOpen(item) }}>
                        <img
                            src={`${item.img}?w=248&fit=crop&auto=format`}
                            srcSet={`${item.img}?w=248&fit=crop&auto=format&dpr=2 2x`}
                            alt={item.itemName}
                            loading="lazy"
                        />
                        <ImageListItemBar
                            title={item.itemName}
                            subtitle={<span>{item.itemAmount}/{item.itemMaxAmount}</span>}
                        />
                    </ImageListItem>
                )
            })}
            <Dialog 
                open={open}
                onClose={handleClose}>
                <DialogTitle>
                    {ItemState.itemName}
                </DialogTitle>
                <DialogContent
                    sx={{
                        width: '500px',
                    }}
                >
                    <Input  sx={{ marginTop: "10px" }} disabled  id="outlined-basic" label="数量" variant="outlined" value={amount}/>
                    <Slider
                        sx={{
                            margin: "40px 0 0 0",
                            width: "100%"
                        }}
                        aria-label="Custom marks"
                        defaultValue={amount}
                        step={1}
                        value={amount}
                        max={ItemState.itemAmount}
                        getAriaValueText={valuetext}
                        onChange={amountChangeHandler}
                        valueLabelDisplay="auto"
                    />
                    <Grid container spacing={2}>
                        <Grid item xs={12 / 3}>
                            <Button variant="contained" sx={{ width: '100%' }} onClick={useItemHandler}>使用</Button>
                        </Grid>
                        <Grid item xs={12 / 3}>
                            <Button variant="contained" sx={{ width: '100%' }} onClick={throwItemHandler}>丢弃</Button>
                        </Grid>
                        <Grid item xs={12 / 3}>
                            <Button variant="contained" sx={{ width: '100%' }} onClick={transferItemHandler}>转移</Button>
                        </Grid>
                    </Grid>
                </DialogContent>
            </Dialog>
        </ImageList>
    )
}


ReactDOM.render(<Inventory_ItemComponent />, document.getElementById("root"));