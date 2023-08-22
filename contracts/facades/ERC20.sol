// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { IERC20 } from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import { IERC20Metadata } from "lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import { IERC20Facet } from "../interfaces/IERC20Facet.sol";
import { MetaContext } from "../shared/MetaContext.sol";

/**
 * @dev Facade implementation of ERC20 token.
 * 
 * Our Diamond can deploy multiple such tokens, all backed by the same implementation within the Diamond.
 */
contract ERC20 is IERC20, IERC20Metadata, MetaContext {
  /**
   * @dev The parent Diamond that implements the business logic.
   */
  IERC20Facet private _parent;

  /**
   * @dev Constructor.
   *
   * @param parent The parent Diamond that implements the business logic.
   */
  constructor(IERC20Facet parent) {
    _parent = parent;
  }

  /*
    IERC20Metadata interface
  */

  function name() public view override returns (string memory) {
    return _parent.erc20Name(address(this));
  }

  function symbol() public view override returns (string memory) {
    return _parent.erc20Symbol(address(this));
  }  

  function decimals() public view override returns (uint8) {
    return _parent.erc20Decimals(address(this));
  }

  /*
    IERC20 interface
  */

  function totalSupply() public view override returns (uint256) {
    return _parent.erc20TotalSupply(address(this));
  }

  function balanceOf(address account) public view override returns (uint256) {
    return _parent.erc20BalanceOf(address(this), account);
  }

  function allowance(address owner, address spender) public view override returns (uint256) {
    return _parent.erc20Allowance(address(this), owner, spender);
  }

  function approve(address spender, uint256 amount) public override returns (bool) {
    _parent.erc20Approve(address(this), _msgSender(), spender, amount);
    return true;
  }

  function transfer(address recipient, uint256 amount) public override returns (bool) {
    address caller = _msgSender();
    _parent.erc20Transfer(address(this), caller, caller, recipient, amount);
    return true;
  }

  function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
    _parent.erc20Transfer(address(this), _msgSender(), sender, recipient, amount);
    return true;
  }
}
