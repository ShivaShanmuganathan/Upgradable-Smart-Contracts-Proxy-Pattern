# Upgradable Smart Contract & Proxy Patterns

## EIP-1822: Universal Upgradeable Proxy Standard
This EIP describes a standard for proxy contracts which is universally compatible with all contracts, and does not create incompatibility between the proxy and business-logic contracts. This is achieved by utilizing a unique storage position in the proxy contract to store the Logic Contract’s address. A compatibility check ensures successful upgrades. Upgrading can be performed unlimited times, or as determined by custom logic. In addition, a method for selecting from multiple constructors is provided, which does not inhibit the ability to verify bytecode.

## EIP-1967 Standard Proxy Storage Slots
This EIP standardizes how proxies store the logic contract address. Storage slot `0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc`(obtained as `bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1))` is reserved for the logic contract.

`The Beacon Contract`
The idea behind the beacon contract is re-usability. If you have several proxies pointing to the same logic contract address then, every time you want to update the logic contract, you'd have to update all proxies. As this can become gas intensive, it would make more sense to have a beacon contract that returns the address of the logic contract for all proxies.

So, if you use beacons, you are having another layer of Smart Contract in between that returns the address of the actual logic contract.


## EIP-2535 💎 Diamond Standard 

A standard for organizing and upgrading a modular smart contract system.
Multi-Facet Proxies for full control over your upgrades.

Diamonds are a proxy pattern for Solidity development that allows a single gateway contract to proxy calls and storage to any number of other contracts. This provides a single interface for anyone to use your contracts, while allowing your feature set to grow into many contracts. The Diamond Standard also allows for replacing or extending functionality after your contracts are deployed. 

### 💎 Diamond Storage
- Diamond storage is a contract storage strategy that is used in proxy contract patterns and diamonds.
- Diamond Standard owns and provides all storage to the facets [smart contracts that are being proxied]
- Diamond storage relies on Solidity structs that contain sets of state variables that are easy to read and write.
- A struct can be defined with state variables and then used in a particular position in contract storage.
- The position can be determined by a hash of a unique string. 

Simple example of diamond storage
```shell
library MyStructStorage {
  bytes32 constant MYSTRUCT_POSITION = 
    keccak256("com.mycompany.projectx.mystruct");

  struct MyStruct {
    uint var1;
    bytes memory var2;
    mapping (address => uint) var3
  }

  function myStructStorage()
    internal 
    pure 
    returns (MyStruct storage mystruct) 
  {
    bytes32 position = MYSTRUCT_POSITION;
    assembly {
      mystruct.slot := position
    }
  }
}
```

The diamond storage defined above can be used like this:

```shell
function myFunction()
  external
{
  MyStructStorage.MyStruct storage mystruct =
    MyStructStorage.myStructStorage();

  mystruct.var1 = 10;
  uint var3 = mystruct.var3[address(this)];

  // etc
}
```

### Modularity by Decoupling Facets from Each Other
In the past it was common for a facet to contain within its source code every single state variable that was ever used by the diamond, in the order they were first declared. Or at least these facets contained state variables in their source code that they didn't use. This was done to avoid the problem of a new facet clobbering existing state variables.

This problem is now solved with Diamond Storage. With Diamond Storage the source code of a facet can just contain the state variables that it actually needs and there is no concern about overwriting existing state variables.

This means that facets that use Diamond Storage are independent from each other and it means that these facets can be reused by different diamonds. In this way facets become reusable libraries for diamonds.

### 💎 DiamondCut, the Swiss-Army Knife for Contract Upgrades
The diamondCut function enables you to add, replace and remove any number of functions from a diamond in a single transaction. For example in one function call to diamondCut you can add 3 new functions, replace 6 functions and remove 4 functions. Or you could call diamondCut one time to add one function. This is really flexible.

In addition the diamondCut function emits an event that shows all changes made to a diamond. It records all additions, replacements and removals of functions.




This project demonstrates an advanced Hardhat use case, integrating other tools commonly used alongside Hardhat in the ecosystem.

The project comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts. It also comes with a variety of other tools, preconfigured to work with the project code.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
npx hardhat help
REPORT_GAS=true npx hardhat test
npx hardhat coverage
npx hardhat run scripts/deploy.js
node scripts/deploy.js
npx eslint '**/*.js'
npx eslint '**/*.js' --fix
npx prettier '**/*.{json,sol,md}' --check
npx prettier '**/*.{json,sol,md}' --write
npx solhint 'contracts/**/*.sol'
npx solhint 'contracts/**/*.sol' --fix
```

# Etherscan verification

To try out Etherscan verification, you first need to deploy a contract to an Ethereum network that's supported by Etherscan, such as Ropsten.

In this project, copy the .env.example file to a file named .env, and then edit it to fill in the details. Enter your Etherscan API key, your Ropsten node URL (eg from Alchemy), and the private key of the account which will send the deployment transaction. With a valid .env file in place, first deploy your contract:

```shell
hardhat run --network ropsten scripts/deploy.js
```

Then, copy the deployment address and paste it in to replace `DEPLOYED_CONTRACT_ADDRESS` in this command:

```shell
npx hardhat verify --network ropsten DEPLOYED_CONTRACT_ADDRESS "Hello, Hardhat!"
```
