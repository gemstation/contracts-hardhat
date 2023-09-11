// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { ERC20 } from "../facades/ERC20.sol";
import { IERC20Facet } from "../interfaces/IERC20Facet.sol";
import { ERC20Token, ERC20TokenConfig } from "../shared/Structs.sol";
import { LibERC20 } from "../libs/LibERC20.sol";
import { AccessControl } from "../shared/AccessControl.sol";
import { LibAppStorage } from "../libs/LibAppStorage.sol";
import { LibString } from "../libs/LibString.sol";

error ERC20InvalidInput();
error ERC20InvalidReceiver(address receiver);
error ERC20NotEnoughAllowance(address owner, address spender);


/**
 * This is a complex example facet that shows how to use the ERC20 facade to launch multiple ERC20 tokens backed by a single diamond proxy.
 */
contract ERC20Facet is IERC20Facet, AccessControl {  
  /**
   * @dev Emitted when a new token is deployed.
   */
  event ERC20NewToken(address token);
  /**
   * @dev Emitted when a token is approved for a spender.
   */
  event ERC20Approval(address token, address owner, address spender, uint256 value);

  /*
    IERC20Facet interface implementation
  */


  function erc20DeployToken(ERC20TokenConfig memory config) isAdmin() external {
    if (LibString.len(config.name) == 0 || LibString.len(config.symbol) == 0 || config.decimals == 0) {
      revert ERC20InvalidInput();
    }

    address token = address(new ERC20(this));

    ERC20Token storage t = LibAppStorage.diamondStorage().erc20s[token];
    t.name = config.name;
    t.symbol = config.symbol;
    t.decimals = config.decimals;

    LibERC20.mint(token, msg.sender, 100);

    emit ERC20NewToken(token);
  }

  function erc20Name() external view returns (string memory) {
    return LibAppStorage.diamondStorage().erc20s[msg.sender].name;
  }

  function erc20Symbol() external view returns (string memory) {
    return LibAppStorage.diamondStorage().erc20s[msg.sender].symbol;    
  }

  function erc20Decimals() external view returns (uint8) {
    return LibAppStorage.diamondStorage().erc20s[msg.sender].decimals;
  }

  function erc20TotalSupply() external view returns (uint256) {
    return LibAppStorage.diamondStorage().erc20s[msg.sender].totalSupply;
  }

  function erc20BalanceOf(address account) external view returns (uint256) {
    return LibAppStorage.diamondStorage().erc20s[msg.sender].balances[account];
  }

  function erc20Allowance(address account, address spender) external view returns (uint256) {
    return LibAppStorage.diamondStorage().erc20s[msg.sender].allowances[account][spender];
  }

  function erc20Approve(address account, address spender, uint256 amount) external {
    address token = msg.sender;
    LibAppStorage.diamondStorage().erc20s[token].allowances[account][spender] = amount;
    emit ERC20Approval(token, account, spender, amount);
  }

  function erc20Transfer(address caller, address from, address to, uint256 amount) external {
    address token = msg.sender;

    if (to == address(0)) {
      revert ERC20InvalidReceiver(to);
    }

    ERC20Token storage t = LibAppStorage.diamondStorage().erc20s[token];

    if (caller != from) {
      if (t.allowances[from][caller] < amount) {
        revert ERC20NotEnoughAllowance(from, caller);
      }

      t.allowances[from][caller] -= amount;
    }

    LibERC20.transfer(token, from, to, amount);
  }
}
