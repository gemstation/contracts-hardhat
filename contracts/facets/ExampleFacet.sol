// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;


/**
 * This is a simple facet example which exports a single function.
 */
contract ExampleFacet {
  function exampleFunction() external pure returns (string memory) {
    return "Hello World!";
  }
}
