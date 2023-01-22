// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// Contract that represents a collection of NFTs related to a home property
contract HomeNFTs is ERC721 {
    // Mapping from NFT ID to owner and sale price

    struct home {
        address owner;
        uint256 price;
    }

    mapping(uint256 => home) public nfts;
   
    // Event for when an NFT is sold
    event NFTSold(uint256 id, address from, address to, uint256 price);

    // Function to sell an NFT
    function sell(uint256 id, uint256 price) public {
        // Ensure that the caller is the owner of the NFT
        require(ownerOf(id) == msg.sender, "You are not the owner of this NFT");

        // Set the new owner and sale price for the NFT
        nfts[id] = (msg.sender, price);

        // Emit an event to record the sale
        emit NFTSold(id, msg.sender, address(this), price);
    }

    // Function to buy an NFT
    function buy(uint256 id) public payable {
        // Get the owner and sale price of the NFT
        address seller = nfts[id].owner;
        uint256 price = nfts[id].price;

        // Ensure that the NFT is for sale
        require(seller != address(0), "This NFT is not for sale");

        // Calculate the commission and send it to the contract
        uint256 commission = price / 10;
        seller.transfer(price - commission);
        msg.sender.transfer(commission);

        // Set the new owner of the NFT
        safeTransferFrom(seller, msg.sender, id);

        // Clear the sale price of the NFT
        nfts[id] = (address(0), 0);
    }
}