// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import "../shared/Structs.sol";

/**
 * @dev ERC20 diamond facet interface.
 */
interface IERC20Facet {
  /**
   * @dev Deploy new token.
   * 
   * @param config Token config.
   */
  function erc20DeployToken(ERC20TokenConfig memory config) external;

  /**
   * @dev Returns the name of the token.
   */
  function erc20Name() external view returns (string memory);

  /**
   * @dev Returns the symbol of the token.
   */
  function erc20Symbol() external view returns (string memory);

  /**
   * @dev Returns the decimals places of the token.
   */
  function erc20Decimals() external view returns (uint8);

  /**
   * @dev Get the total supply.
   */
  function erc20TotalSupply() external view returns (uint256);

  /**
   * @dev Get the balance of the given wallet.
   *
   * @param account The account address.
   */
  function erc20BalanceOf(address account) external view returns (uint256);

  /**
   * @dev Get the allowance of the given spender for the given owner wallet.
   *
   * @param account The account address.
   * @param spender The spender address.
   */
  function erc20Allowance(address account, address spender) external view returns (uint256);

  /**
   * @dev Approve an allowance for the given spender for the given owner wallet.
   *
   * @param account The account address.
   * @param spender The spender address.
   * @param amount The amount to approve.
   */
  function erc20Approve(address account, address spender, uint256 amount) external;

  /**
   * @dev Transfer a token.
   * @param caller The caller address.
   * @param from The from address.
   * @param to The to address.
   * @param amount The amount to transfer.
   */
  function erc20Transfer(address caller, address from, address to, uint256 amount) external;
}
