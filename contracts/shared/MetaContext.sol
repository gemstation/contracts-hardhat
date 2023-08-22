// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { Context } from "lib/openzeppelin-contracts/contracts/utils/Context.sol";
import { LibAppStorage } from "../libs/LibAppStorage.sol";

/**
 * @dev ERC2711 meta-transaction context variant using AppStorage.
 */
abstract contract MetaContext is Context {
  function isTrustedForwarder(address forwarder) internal view returns (bool) {
    return forwarder == LibAppStorage.diamondStorage().metaTxContext.trustedForwarder;
  }

  function _msgSender() internal view override returns (address sender) {
    if (isTrustedForwarder(msg.sender)) {
      // The assembly code is more direct than the Solidity version using `abi.decode`.
      /// @solidity memory-safe-assembly
      assembly {
        sender := shr(96, calldataload(sub(calldatasize(), 20)))
      }
    } else {
      return super._msgSender();
    }
  }

  function _msgData() internal view override returns (bytes calldata) {
    if (isTrustedForwarder(msg.sender)) {
      return msg.data[:msg.data.length - 20];
    } else {
      return super._msgData();
    }
  }
}
