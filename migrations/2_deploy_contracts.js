var UnicoreToken = artifacts.require("./UnicoreToken.sol");
var UnicoreCrowdsale = artifacts.require("./UnicoreCrowdsale.sol");
var UnicoreTimelock = artifacts.require("./UnicoreTimelock.sol");

const Web3 = require('web3');
const web3 = new Web3(UnicoreToken.web3.currentProvider);

module.exports = async function(deployer, network, [me]) {
    // This address will receive all ETH from crowdsale
    // This address will be able to withdraw all tokens from timelock contract
    const beneficiary = '0x33f16a8dAdB3B037021DFCa7aD269b2387a60C6a';
    // const beneficiary = '0x0f4d0EbD48346652C84042d8C9a3a1c70f1a2DAf';
    console.log('me', me);

    deployer.then(async () => {
        const unicoreToken = await UnicoreToken.new({from: me});
        const unicoreTimelock = await UnicoreTimelock.new(
            unicoreToken.address,
            beneficiary,
            // GMT: Saturday, 24 November 2018 г., 14:28:34
            '1543069714',
            {from: me});

        const unicoreCrowdsale = await UnicoreCrowdsale.new(
            // 1_000_000 UCR per 1 ETH
            '10',
            // Thursday, 22 November 2018 г., 17:40:34
            '1542908434',
            // close - GMT: Saturday, 24 November 2018 г., 14:28:34
            '1543069714',
            beneficiary,
            unicoreToken.address,
            unicoreTimelock.address,
            {from: me});

        // transfer 80% of UCR supplo to timelock contract
        await unicoreToken.transfer(unicoreTimelock.address, ether('160000000'), { from: me });

        // transfer 20% of UCR supplo to crowdsale contract
        await unicoreToken.transfer(unicoreCrowdsale.address, ether('40000000'), { from: me });

        console.log('UnicoreToken', unicoreToken.address);
        console.log('UnicoreTimelock', unicoreTimelock.address);
        console.log('UnicoreCrowdsale', unicoreCrowdsale.address);
    });
};

function ether(number) {
    return web3.utils.toWei(number.toString(), 'ether');
}