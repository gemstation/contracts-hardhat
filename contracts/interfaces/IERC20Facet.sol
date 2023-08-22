// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;


/**
 * @dev ERC20 diamond facet interface.
 */
interface IERC20Facet {
  /**
   * @dev Deploy new token.
   * 
   * @param name The name of the token.
   * @param symbol The symbol of the token.
   * @param decimals The decimals places of the token.
   */
  function erc20DeployToken(string memory name, string memory symbol, uint8 decimals) external;

  /**
   * @dev Returns the name of the token.
   *
   * @param token The token address.
   */
  function erc20Name(address token) external view returns (string memory);

  /**
   * @dev Returns the symbol of the token.
   *
   * @param token The token address.
   */
  function erc20Symbol(address token) external view returns (string memory);

  /**
   * @dev Returns the decimals places of the token.
   *
   * @param token The token address.
   */
  function erc20Decimals(address token) external view returns (uint8);

  /**
   * @dev Get the total supply.
   *
   * @param token The token address.
   */
  function erc20TotalSupply(address token) external view returns (uint256);

  /**
   * @dev Get the balance of the given wallet.
   *
   * @param token The token address.
   * @param account The account address.
   */
  function erc20BalanceOf(address token, address account) external view returns (uint256);

  /**
   * @dev Get the allowance of the given spender for the given owner wallet.
   *
   * @param token The token address.
   * @param account The account address.
   * @param spender The spender address.
   */
  function erc20Allowance(address token, address account, address spender) external view returns (uint256);

  /**
   * @dev Approve an allowance for the given spender for the given owner wallet.
   *
   * @param token The token address.
   * @param account The account address.
   * @param spender The spender address.
   * @param amount The amount to approve.
   */
  function erc20Approve(address token, address account, address spender, uint256 amount) external;

  /**
   * @dev Transfer a token.
   * @param token The token address.
   * @param caller The caller address.
   * @param from The from address.
   * @param to The to address.
   * @param amount The amount to transfer.
   */
  function erc20Transfer(address token, address caller, address from, address to, uint256 amount) external;
}
