pragma solidity ^0.8.0;

import "./BEP20.sol";
import "./IBEP20.sol";

contract CujoCoin is BEP20 {
  uint256 MAX_INT = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
  address BURN = 0x000000000000000000000000000000000000dEaD;
  uint256 burnPercentage = 1;

  constructor() BEP20("Cujo Coin", "CUJO") {
    _mint(msg.sender, MAX_INT);
  }

  function setBurnPercentage(uint256 burn) external onlyOwner {
    burnPercentage = burn;
  }

  function transfer(address recipient, uint256 amount) public override returns (bool) {
    uint256 burnAmount = amount * burnPercentage / 100;
    uint256 transferAmount = amount - burnAmount;

    _transfer(_msgSender(), BURN, burnAmount);
    _transfer(_msgSender(), recipient, transferAmount);
    return true;
  }
}