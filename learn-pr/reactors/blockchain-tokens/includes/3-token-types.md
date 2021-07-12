[Ethereum Improvement Proposals](https://eips.ethereum.org/?azure-portal=true) (EIPs) describe standards for the Ethereum platform. The proposals include core protocol specifications, client APIs, and contract standards. Community members can propose new standards for all aspects of the Ethereum platform through EIPs.

Token standards are defined in the [Ethereum Request for Comments](https://eips.ethereum.org/erc?azure-portal=true) (ERCs). Although new standards are continuously being proposed and accepted, standards for four primary ERC types have been widely adopted:

- **ERC20**
- **ERC721**
- **ERC777**
- **ERC1155**

Let's explore each type of token. We'll take a moment to understand what makes each one significant and unique.

## ERC20

The [ERC20](https://eips.ethereum.org/EIPS/eip-20?azure-portal=true) token is the most widely known and used. ERC20 is the technical standard that's used for smart contracts on the Ethereum blockchain to implement tokens. ERC20 has a simple interface for basic tokens.

You can keep track of fungible tokens by using ERC20 token contracts. Any one ERC20 token is equal to any other token. Also, ERC20 tokens don't have any associated special rights or behaviors, which make the tokens useful for things like staking, currency exchange, and voting rights. 

## ERC721

[ERC721](https://eips.ethereum.org/EIPS/eip-721?azure-portal=true) is the top solution for non-fungible tokens (NFTs). Like all other tokens, NFTs represent ownership both of virtual and physical assets. These assets are likely to include:

- Collectible items, like antiques, cards, or art
- Physical assets, like houses or cars
- Negative-value assets, like loans

Each token is unique and has ownership and status that must be tracked.

While similar, the ERC721 token and ERC20 token differ in complexity. The ERC721 token is more complex. Also, with the ERC721 token, each function has an argument to specify the token ID that uniquely identifies the token being used in the smart contract.

## ERC777

[ERC777](https://eips.ethereum.org/EIPS/eip-777?azure-portal=true) is a richer standard that is used for fungible tokens. The standard can be used for new use cases and to build on learnings from previous token standards. It's backward-compatible with ERC20, which means you can interact with ERC777 tokens as if they're ERC20 tokens. You can use ERC777 tokens for interactions that are more complex trades.

## ERC1155

[ERC1155](https://eips.ethereum.org/EIPS/eip-1155?azure-portal=true) is a standard that's used to manage multiple types of tokens. A contract can represent multiple fungible and non-fungible tokens.

ERC1155 draws on ideas from ERC20, ERC721, and ERC777.

The design of the ERC1155 token type allows for massive gas savings, for a couple reasons. (In Ethereum, *gas* refers to a fee or pricing value charged to execute transactions.) First, you can use this token contract for multiple tokens, which means fewer deployments with less complexity. It also has batched operations, so a single function call can be simpler and less gas-intensive.
