/// (From Tag: @subsquid/substrate-metadata-explorer_v1.0.7)
///
/// Referenced from: https://github.com/subsquid/squid/blob/%40subsquid/substrate-metadata-explorer_v1.0.7/substrate-metadata-explorer/src/specVersion.schema.json

// ignore_for_file: constant_identifier_names

const SPEC_VERSION_SCHEMA = <String, dynamic>{
  "description": "Chain spec version description",
  "type": "object",
  "properties": {
    "specName": {
      "type": "string",
    },
    "specVersion": {
      "type": "integer",
    },
    "blockNumber": {
      "description":
          "The height of the block where the given spec version was first introduced",
      "type": "integer",
      "minimum": 0
    },
    "blockHash": {
      "description":
          "The hash of the block where the given spec version was first introduced",
      "type": "string",
      "pattern": "^0x([a-fA-F0-9])+\$"
    },
    "metadata": {
      "description": "Chain metadata",
      "type": "string",
      "pattern": "^0x([a-fA-F0-9])+\$"
    }
  },
  "required": [
    "specName",
    "specVersion",
    "blockNumber",
    "blockHash",
    "metadata"
  ]
};
