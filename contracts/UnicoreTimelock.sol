pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/token/ERC20/TokenTimelock.sol";

contract UnicoreTimelock is TokenTimelock {
    constructor(
        ERC20Basic _token,
        address _beneficiary,
        uint256 _releaseTime
    ) public TokenTimelock(_token, _beneficiary, _releaseTime) {}
}