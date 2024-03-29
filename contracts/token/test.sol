// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC3525.sol";

contract ERC3525Test {
    ERC3525 public erc3525;

    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals
    ) {
        erc3525 = new ERC3525(name, symbol, decimals);
    }

    function Mint(address to, uint256 slot, uint256 value) external {
        erc3525._mint(to, slot, value);
    }

    function MintValue(uint256 tokenId, uint256 value) external {
        erc3525._mintValue(tokenId, value);
    }

    function Burn(uint256 tokenId) external {
        erc3525._burn(tokenId);
    }

    function BurnValue(uint256 tokenId, uint256 burnValue) external {
        erc3525._burnValue(tokenId, burnValue);
    }
// Function to transfer a full NFT from one address to another
    function transferNFT(address fromAddress, address toAddress, uint256 tokenId) public {
        // You may perform additional checks or validations here before making the call
        erc3525.transferFrom(fromAddress, toAddress, tokenId);
    }

    // Function to transfer a fraction of an NFT from its ID to an address
    function transferFractionFromID(address toAddress, uint256 fromTokenId, uint256 value) public {
        // You may perform additional checks or validations here before making the call
        erc3525.transferFrom(fromTokenId, toAddress, value);
    }

    // Function to transfer a fraction from one ID to another ID
    function transferFractionFromIDToID(uint256 fromTokenId, uint256 toTokenId, uint256 value) public {
        // You may perform additional checks or validations here before making the call
        erc3525.transferFrom(fromTokenId, toTokenId, value);
    }

    function SafeTransferTokenId(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) external {
        erc3525._safeTransferTokenId(from, to, tokenId, data);
    }


    function SetMetadataDescriptor(address metadataDescriptor) external {
        erc3525._setMetadataDescriptor(metadataDescriptor);
    }

    function CreateDerivedTokenId(uint256 fromTokenId) external returns (uint256) {
        return erc3525._createDerivedTokenId(fromTokenId);
    }
     function BalanceOf(uint256 tokenId) external view returns (uint256) {
        return erc3525.balanceOf(tokenId);
    }
    function OwnerOf(uint256 tokenId) external view returns (address) {
        return erc3525.ownerOf(tokenId);
    }
    function SlotOf(uint256 tokenId) external view returns (uint256) {
        return erc3525.slotOf(tokenId);
    }
    function SetApprovalForAll(address owner, address operator, bool approved) external {
        erc3525._setApprovalForAll(owner, operator, approved);
    }
    function Aprove(uint256 tokenId, address to, uint256 value) public {
       
        erc3525.approve(tokenId, to, value);

    }
    function CheckAllowance(uint256 tokenId_, address operator_) public view virtual  returns (uint256 allowance) {
       allowance=erc3525.allowance(tokenId_, operator_);
    }
   
}
