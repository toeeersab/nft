# NFT

NFT marketplace with encrypted prices and private trading

## The idea

Imagine if your data could stay private even when someone needs to work with it. That's not just wishful thinking - it's what Zama FHEVM makes possible. This project is our take on making that real.

## What we built

A system where encryption isn't just a layer you add on top - it's built into how everything works. Data flows through the system encrypted, gets processed encrypted, and only reveals itself when you say so.

## The stack

- **Zama FHEVM** - The foundation that makes it all work
- **Hardhat** - Our development environment
- **Solidity** - The language of smart contracts
- **TypeScript** - For when you want your types checked

Running on Sepolia testnet - get some test ETH and dive in.

## Getting started

`ash
npm install
npm run compile
`

Set up your environment (.env file, see the template).

Deploy when ready:

`ash
npm run deploy:sepolia
`

## Contracts

- `CollectionManager`
- `NFTMarketplace`

Addresses live in contracts.json after deployment.

## The flow

Encrypt в†’ Send в†’ Process (still encrypted) в†’ Decrypt (only when you allow it)

It's privacy that actually works, not just privacy theater.

## Contributing

Open source means open to contributions. Found something? Fixed something? Want to add something? Pull requests welcome.

## License

MIT - use it, change it, make it yours.


