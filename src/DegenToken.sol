// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract DegenToken is ERC20 {
    uint public redemptionItemId;
    address public tokenOwner;

    struct RedemptionInfo {
        address owner;
        string name;
        uint256 amount;
    }

    mapping(uint => RedemptionInfo) public redemptions;

    constructor() ERC20("DegenToken", "DGN") {
        tokenOwner = msg.sender;
    }

    modifier onlyTokenOwner() {
        require(msg.sender == tokenOwner, "Not Owner");
        _;
    }

    function mintTokens(address to, uint amount) public onlyTokenOwner {
        _mint(to, amount);
    }

    function createRedemptionItem(string memory _name, uint256 _amount) external {
        redemptionItemId++;
        RedemptionInfo storage item = redemptions[redemptionItemId];
        item.owner = msg.sender;
        item.name = _name;
        item.amount = _amount;
        redemptions[redemptionItemId] = item;
    }

    function transferTokens(address to, uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "Insufficient balance");
        _transfer(msg.sender, to, _value);
    }

    function getBalance() external view returns(uint256) {
        return balanceOf(msg.sender);
    }

    function redeemToken(uint8 itemId) external {
        require(itemId <= redemptionItemId, "No Item with Id");
        transfer(redemptions[itemId].owner, redemptions[itemId].amount);
        redemptions[itemId].owner = msg.sender;
    }

    function burnTokens(uint amount) external {
        require(balanceOf(msg.sender) >= amount, "You don't have enough");
        _burn(msg.sender, amount); 
    }

    function viewRedemptionItemOwner(uint8 itemId) public view returns (address) {
        return redemptions[itemId].owner;
    }

    function viewRedemption(uint id_) public view returns (RedemptionInfo memory) {
        return redemptions[id_];
    }
}
