import React from 'react';
import ReactDOM from 'react-dom';
import Displayer from './Displayer';


function Main() {
    const [wh, setWh] = React.useState([
        parseInt(window.innerHeight - (window.innerHeight * 0.351)),
        parseInt(window.innerWidth - (window.innerWidth * 0.15))
    ]);

    window.addEventListener('resize', () => {
        setWh([
            parseInt(window.innerHeight - (window.innerHeight * 0.351)),
            parseInt(window.innerWidth - (window.innerWidth * 0.15))
        ]);
    });

    return (
        <div>
            <object
                id="plugin"
                type="application/x-cfx-game-view"
                style={{
                    position: "absolute",
                    right: "0px",
                    bottom: "0px",
                    width: "100%",
                    height: "100%",
                    clip: "rect(" + wh[0] + "px,10000px,100000px," + wh[1] + "px)"
                }}
            >d</object>
            <Displayer />
        </div>
    )
}

ReactDOM.render(
    <Main />,
    document.getElementById('root')
);

