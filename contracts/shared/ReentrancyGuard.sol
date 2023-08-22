// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import { LibAppStorage } from "../libs/LibAppStorage.sol";

// From OpenZeppellin: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/security/ReentrancyGuard.sol

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 */
abstract contract ReentrancyGuard {
  uint256 private constant _NOT_ENTERED = 1;
  uint256 private constant _ENTERED = 2;

  /**
   * @dev Prevents a contract from calling itself, directly or indirectly.
   */
  modifier nonReentrant() {
    require(
      LibAppStorage.diamondStorage().reentrancyStatus != _ENTERED,
      "ReentrancyGuard: reentrant call"
    );

    LibAppStorage.diamondStorage().reentrancyStatus = _ENTERED;

    _;

    LibAppStorage.diamondStorage().reentrancyStatus = _NOT_ENTERED;
  }
}
