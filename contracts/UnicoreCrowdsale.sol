pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/crowdsale/distribution/FinalizableCrowdsale.sol";
import "./UnicoreToken.sol";

contract UnicoreCrowdsale is FinalizableCrowdsale {
    address timelockContract;

    constructor (
        uint256 _rate,
        uint256 _openTime,
        uint256 _closeTime,
        address _wallet,
        UnicoreToken _token,
        address _timelockContract
    ) public
        Crowdsale(_rate, _wallet, _token)
        TimedCrowdsale(_openTime, _closeTime)
    {
        timelockContract = _timelockContract;
    }

    function setRate(uint256 _newRate) external onlyOwner {
        rate = _newRate;
    }

    function finalization() internal {
        token.transfer(timelockContract, token.balanceOf(address(this)));
        super.finalization();
    }
}