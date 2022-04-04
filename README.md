# Upgradable Smart Contract & Proxy Patterns

## EIP-1822: Universal Upgradeable Proxy Standard
This EIP describes a standard for proxy contracts which is universally compatible with all contracts, and does not create incompatibility between the proxy and business-logic contracts. This is achieved by utilizing a unique storage position in the proxy contract to store the Logic Contract’s address. A compatibility check ensures successful upgrades. Upgrading can be performed unlimited times, or as determined by custom logic. In addition, a method for selecting from multiple constructors is provided, which does not inhibit the ability to verify bytecode.

## EIP-1967 Standard Proxy Storage Slots
This EIP standardizes how proxies store the logic contract address. Storage slot `0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc`(obtained as `bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1))` is reserved for the logic contract.

`The Beacon Contract`
The idea behind the beacon contract is re-usability. If you have several proxies pointing to the same logic contract address then, every time you want to update the logic contract, you'd have to update all proxies. As this can become gas intensive, it would make more sense to have a beacon contract that returns the address of the logic contract for all proxies.

So, if you use beacons, you are having another layer of Smart Contract in between that returns the address of the actual logic contract.


## EIP-2535 💎 Diamond Standard 

Diamonds are a proxy pattern for Solidity development that allows a single gateway contract to proxy calls and storage to any number of other contracts. This provides a single interface for anyone to use your contracts, while allowing your feature set to grow into many contracts. The Diamond Standard also allows for replacing or extending functionality after your contracts are deployed. 





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
