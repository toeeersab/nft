// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ZamaEthereumConfig} from "@fhevm/solidity/config/ZamaConfig.sol";
import {euint32} from "@fhevm/solidity/lib/FHE.sol";

// manages NFT collections with encrypted values
contract CollectionManager is ZamaEthereumConfig {
    struct Collection {
        address creator;
        string name;
        euint32 floorPrice;  // encrypted
        uint256 totalSupply;
    }
    
    mapping(uint256 => Collection) public collections;
    mapping(uint256 => address[]) public collectionNFTs;  // collectionId => nft addresses
    uint256 public collectionCounter;
    
    event CollectionCreated(uint256 indexed collectionId, address creator);
    
    function createCollection(
        string memory name,
        euint32 encryptedFloorPrice
    ) external returns (uint256 collectionId) {
        collectionId = collectionCounter++;
        collections[collectionId] = Collection({
            creator: msg.sender,
            name: name,
            floorPrice: encryptedFloorPrice,
            totalSupply: 0
        });
        emit CollectionCreated(collectionId, msg.sender);
    }
    
    function addNFT(uint256 collectionId, address nftContract) external {
        Collection storage collection = collections[collectionId];
        require(collection.creator == msg.sender, "Not creator");
        
        collectionNFTs[collectionId].push(nftContract);
        collection.totalSupply++;
    }
}

