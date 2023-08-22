// SPDX-License-Identifier: MIT
// Source: // https://gist.github.com/AlmostEfficient/669ac250214f30347097a1aeedcdfa12
pragma solidity >=0.8.21;

library LibString {
  /**
   * @dev Returns the length of a given string
   *
   * @param s The string to measure the length of
   * @return The length of the input string
   */
  function len(string memory s) internal pure returns (uint) {
    uint length;
    uint i = 0;
    uint bytelength = bytes(s).length;
    for (length = 0; i < bytelength; length++) {
      bytes1 b = bytes(s)[i];
      if (b < 0x80) {
        i += 1;
      } else if (b < 0xE0) {
        i += 2;
      } else if (b < 0xF0) {
        i += 3;
      } else if (b < 0xF8) {
        i += 4;
      } else if (b < 0xFC) {
        i += 5;
      } else {
        i += 6;
      }
    }
    return length;
  }
}
