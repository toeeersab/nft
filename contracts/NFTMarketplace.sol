// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ZamaEthereumConfig} from "@fhevm/solidity/config/ZamaConfig.sol";
import {euint32} from "@fhevm/solidity/lib/FHE.sol";

// NFT marketplace with encrypted prices
contract NFTMarketplace is ZamaEthereumConfig {
    struct Listing {
        address seller;
        address nftContract;
        uint256 tokenId;
        euint32 price;      // encrypted price
        bool active;
    }
    
    struct Offer {
        address buyer;
        euint32 amount;     // encrypted offer
        uint256 timestamp;
        bool accepted;
    }
    
    mapping(uint256 => Listing) public listings;
    mapping(uint256 => Offer[]) public offers;
    uint256 public listingCounter;
    
    event NFTListed(uint256 indexed listingId, address seller, address nftContract, uint256 tokenId);
    event OfferMade(uint256 indexed listingId, address buyer);
    event NFTSold(uint256 indexed listingId, address buyer);
    
    function listNFT(
        address nftContract,
        uint256 tokenId,
        euint32 encryptedPrice
    ) external returns (uint256 listingId) {
        listingId = listingCounter++;
        listings[listingId] = Listing({
            seller: msg.sender,
            nftContract: nftContract,
            tokenId: tokenId,
            price: encryptedPrice,
            active: true
        });
        emit NFTListed(listingId, msg.sender, nftContract, tokenId);
    }
    
    function makeOffer(
        uint256 listingId,
        euint32 encryptedAmount
    ) external {
        Listing storage listing = listings[listingId];
        require(listing.active, "Not listed");
        require(listing.seller != msg.sender, "Cannot buy own NFT");
        
        offers[listingId].push(Offer({
            buyer: msg.sender,
            amount: encryptedAmount,
            timestamp: block.timestamp,
            accepted: false
        }));
        
        emit OfferMade(listingId, msg.sender);
    }
    
    function acceptOffer(uint256 listingId, uint256 offerIndex) external {
        Listing storage listing = listings[listingId];
        require(listing.seller == msg.sender, "Not seller");
        
        Offer storage offer = offers[listingId][offerIndex];
        offer.accepted = true;
        listing.active = false;
        
        emit NFTSold(listingId, offer.buyer);
    }
}

