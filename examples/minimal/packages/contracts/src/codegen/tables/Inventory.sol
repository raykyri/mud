// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

/* Autogenerated file. Do not edit manually. */

// Import schema type
import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { Schema, SchemaLib } from "@latticexyz/store/src/Schema.sol";
import { PackedCounter, PackedCounterLib } from "@latticexyz/store/src/PackedCounter.sol";

bytes32 constant _tableId = bytes32(abi.encodePacked(bytes16(""), bytes16("Inventory")));
bytes32 constant InventoryTableId = _tableId;

library Inventory {
  /** Get the table's schema */
  function getSchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](1);
    _schema[0] = SchemaType.UINT32;

    return SchemaLib.encode(_schema);
  }

  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _schema = new SchemaType[](3);
    _schema[0] = SchemaType.ADDRESS;
    _schema[1] = SchemaType.BYTES32;
    _schema[2] = SchemaType.UINT32;

    return SchemaLib.encode(_schema);
  }

  /** Get the table's metadata */
  function getMetadata() internal pure returns (string memory, string[] memory) {
    string[] memory _fieldNames = new string[](1);
    _fieldNames[0] = "amount";
    return ("Inventory", _fieldNames);
  }

  /** Register the table's schema */
  function registerSchema() internal {
    StoreSwitch.registerSchema(_tableId, getSchema(), getKeySchema());
  }

  /** Register the table's schema (using the specified store) */
  function registerSchema(IStore _store) internal {
    _store.registerSchema(_tableId, getSchema(), getKeySchema());
  }

  /** Set the table's metadata */
  function setMetadata() internal {
    (string memory _tableName, string[] memory _fieldNames) = getMetadata();
    StoreSwitch.setMetadata(_tableId, _tableName, _fieldNames);
  }

  /** Set the table's metadata (using the specified store) */
  function setMetadata(IStore _store) internal {
    (string memory _tableName, string[] memory _fieldNames) = getMetadata();
    _store.setMetadata(_tableId, _tableName, _fieldNames);
  }

  /** Get amount */
  function get(address user, bytes32 item, uint32 variant) internal view returns (uint32 amount) {
    bytes32[] memory _primaryKeys = new bytes32[](3);
    _primaryKeys[0] = bytes32(uint256(uint160((user))));
    _primaryKeys[1] = bytes32((item));
    _primaryKeys[2] = bytes32(uint256((variant)));

    bytes memory _blob = StoreSwitch.getField(_tableId, _primaryKeys, 0);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Get amount (using the specified store) */
  function get(IStore _store, address user, bytes32 item, uint32 variant) internal view returns (uint32 amount) {
    bytes32[] memory _primaryKeys = new bytes32[](3);
    _primaryKeys[0] = bytes32(uint256(uint160((user))));
    _primaryKeys[1] = bytes32((item));
    _primaryKeys[2] = bytes32(uint256((variant)));

    bytes memory _blob = _store.getField(_tableId, _primaryKeys, 0);
    return (uint32(Bytes.slice4(_blob, 0)));
  }

  /** Set amount */
  function set(address user, bytes32 item, uint32 variant, uint32 amount) internal {
    bytes32[] memory _primaryKeys = new bytes32[](3);
    _primaryKeys[0] = bytes32(uint256(uint160((user))));
    _primaryKeys[1] = bytes32((item));
    _primaryKeys[2] = bytes32(uint256((variant)));

    StoreSwitch.setField(_tableId, _primaryKeys, 0, abi.encodePacked((amount)));
  }

  /** Set amount (using the specified store) */
  function set(IStore _store, address user, bytes32 item, uint32 variant, uint32 amount) internal {
    bytes32[] memory _primaryKeys = new bytes32[](3);
    _primaryKeys[0] = bytes32(uint256(uint160((user))));
    _primaryKeys[1] = bytes32((item));
    _primaryKeys[2] = bytes32(uint256((variant)));

    _store.setField(_tableId, _primaryKeys, 0, abi.encodePacked((amount)));
  }

  /** Tightly pack full data using this table's schema */
  function encode(uint32 amount) internal view returns (bytes memory) {
    return abi.encodePacked(amount);
  }

  /** Encode keys as a bytes32 array using this table's schema */
  function encodeKeyTuple(
    address user,
    bytes32 item,
    uint32 variant
  ) internal pure returns (bytes32[] memory _primaryKeys) {
    _primaryKeys = new bytes32[](3);
    _primaryKeys[0] = bytes32(uint256(uint160((user))));
    _primaryKeys[1] = bytes32((item));
    _primaryKeys[2] = bytes32(uint256((variant)));
  }

  /* Delete all data for given keys */
  function deleteRecord(address user, bytes32 item, uint32 variant) internal {
    bytes32[] memory _primaryKeys = new bytes32[](3);
    _primaryKeys[0] = bytes32(uint256(uint160((user))));
    _primaryKeys[1] = bytes32((item));
    _primaryKeys[2] = bytes32(uint256((variant)));

    StoreSwitch.deleteRecord(_tableId, _primaryKeys);
  }

  /* Delete all data for given keys (using the specified store) */
  function deleteRecord(IStore _store, address user, bytes32 item, uint32 variant) internal {
    bytes32[] memory _primaryKeys = new bytes32[](3);
    _primaryKeys[0] = bytes32(uint256(uint160((user))));
    _primaryKeys[1] = bytes32((item));
    _primaryKeys[2] = bytes32(uint256((variant)));

    _store.deleteRecord(_tableId, _primaryKeys);
  }
}
