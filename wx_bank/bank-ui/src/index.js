import React from 'react';
import ReactDOM from 'react-dom';
import CardViewHandler from './CardViewHandler';
import ATMHandler from './atm/ATMHandler';

ReactDOM.render(
    <div>
        <CardViewHandler />
        <ATMHandler />
    </div>,
    document.getElementById('root')
);
