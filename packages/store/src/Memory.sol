// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { Utils } from "./Utils.sol";

library Memory {
  function load(uint256 memoryPointer) internal pure returns (bytes32 data) {
    assembly {
      data := mload(memoryPointer)
    }
  }

  function load(uint256 memoryPointer, uint256 offset) internal pure returns (bytes32 data) {
    assembly {
      data := mload(add(memoryPointer, offset))
    }
  }

  function dataPointer(bytes memory data) internal pure returns (uint256 memoryPointer) {
    assembly {
      memoryPointer := add(data, 0x20)
    }
  }

  function lengthPointer(bytes memory data) internal pure returns (uint256 memoryPointer) {
    assembly {
      memoryPointer := data
    }
  }

  function store(uint256 memoryPointer, bytes32 value) internal pure {
    assembly {
      mstore(memoryPointer, value)
    }
  }

  function copy(
    uint256 ptrDest,
    uint256 ptrSrc,
    uint256 length
  ) internal view {
    if (length > 32) {
      assembly {
        pop(
          staticcall(
            gas(), // gas (unused is returned)
            0x04, // identity precompile address
            ptrSrc, // argsOffset
            length, // argsSize: byte size to copy
            ptrDest, // retOffset
            length // retSize: byte size to copy
          )
        )
      }
    } else {
      uint256 mask = Utils.leftMask(length);
      assembly {
        mstore(
          ptrDest,
          or(
            // Store the left part
            and(mload(ptrSrc), mask),
            // Preserve the right part
            and(mload(ptrDest), not(mask))
          )
        )
      }
    }
  }
}
