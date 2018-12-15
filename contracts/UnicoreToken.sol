pragma solidity ^0.4.24;
import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/BurnableToken.sol";

contract UnicoreToken is StandardToken, BurnableToken {
    // solium-disable-next-line uppercase
    string public constant name = "UNICORE";

    // solium-disable-next-line uppercase
    string public constant symbol = "UCR";

    // solium-disable-next-line uppercase
    uint8 public constant decimals = 18;

    uint256 public constant INITIAL_SUPPLY = 200 * 1000 * 1000 * (10 ** uint256(decimals));

    constructor() public StandardToken() {
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        emit Transfer(address(0), msg.sender, INITIAL_SUPPLY);
    }
}