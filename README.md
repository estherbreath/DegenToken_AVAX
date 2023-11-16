## DegenToken Contract Overview

The contract provides a basic framework for a customizable ERC-20 token with additional features tailored for specific use cases, such as token redemption and burning. Users can interact with the contract to create redemption items, transfer tokens, redeem specific items, and burn their own tokens.

### Key Functionalities:

- Token Details:

Name: DegenToken
Symbol: DGN
Inherits from the OpenZeppelin ERC-20 standard contract (ERC20.sol).
Owner and Minting:

- The contract includes an onlyTokenOwner modifier to restrict certain functions to the owner (tokenOwner).
The constructor initializes the tokenOwner as the sender of the deployment transaction.
Minting Function:

- mintTokens: Allows the owner to mint a specified amount of tokens and assign them to a target address.
Redemption Items:

- RedemptionInfo represents information about a redemption item, including owner, name, and amount.
Maintains a mapping of redemption items using their unique identifiers (redemptionItemId).

- createRedemptionItem: Allows users to create redemption items by providing a name and an amount.
Token Transfers:

- transferTokens: Allows users to transfer tokens to another address, ensuring that the sender has a sufficient balance.
Balance Inquiry:

- getBalance: Enables users to query their token balance.
Token Redemption:

- redeemToken: Facilitates the redemption of a specified redemption item by transferring the associated tokens to the redeemer and updating the item's owner.
Token Burning:

- burnTokens: Permits users to burn a specified amount of their own tokens, reducing the total supply.


##### View Functions:

- viewRedemptionItemOwner: Allows users to view the current owner of a specific redemption item.
- viewRedemption: Allows users to view detailed information about a redemption item using its unique identifier.
Modifiers:

- onlyTokenOwner: Ensures that only the owner can execute certain functions.

### Deployment and Interaction
 The contract was written using foundry, the test were ran successfully and it was deployed to Avalache Network at the address  0x80D3656C0D8cE1e97CD979727F7f5ce419ceCc9E
 
### Authors
Esther Breath @metacraftersio

### License
This project is licensed under the MIT License