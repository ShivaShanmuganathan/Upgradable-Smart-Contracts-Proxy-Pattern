// A contract that implements diamond storage.
library LibA {

  // This struct contains state variables we care about.
  struct DiamondStorage {
    address owner;
    bytes32 dataA;
  }

  // Returns the struct from a specified position in contract storage
  // ds is short for DiamondStorage
  function diamondStorage() internal pure returns(DiamondStorage storage ds) {
    // Specifies a random position from a hash of a string
    bytes32 storagePosition = keccak256("diamond.storage.LibA")
    // Set the position of our struct in contract storage
    assembly; {ds.slot := storagePosition}
  }
}

// Our facet uses the diamond storage defined above.
contract FacetA {

  function setDataA(bytes32 _dataA) external {
    LibA.DiamondStorage storage ds = LibA.diamondStorage();
    require(ds.owner == msg.sender, "Must be owner.");
    ds.dataA = _dataA;
  }

  function getDataA() external view returns (bytes32) {
    return LibDiamond.diamondStorage().dataA
  }
}