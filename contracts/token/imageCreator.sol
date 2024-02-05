// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import "contracts/ragava.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract svgCreator {
    using Strings for uint256;
    address main;
    ERC3525 mainContract;
    string imageurl;
    constructor(address _main,string memory _imageurl) {
        imageurl=_imageurl;
        main = _main;
        mainContract = ERC3525(main);
    }

   function createSVG(uint256 tokenId_) public view returns (string memory) {
    // Get token details
    uint256 balance = mainContract.balanceOf(tokenId_);
    uint256 slot = mainContract.slotOf(tokenId_);
    address owner = mainContract.ownerOf(tokenId_);

    // Construct the SVG content using string concatenation
    string memory svg = string(
        abi.encodePacked(
            '<svg width="600" height="600" xmlns="http://www.w3.org/2000/svg">',
            '<g>',
            // Left side with white background
            '<rect width="300" height="600" fill="#ffffff"/>',

            // Token details on the white background
            '<text xml:space="preserve" text-anchor="start" font-family="Noto Sans JP" font-size="30" id="svg_2" y="60" x="20" stroke-width="0" stroke="#000000" fill="#000000">Token ID: ',
            tokenId_.toString(),
            '</text>',
            '<text xml:space="preserve" text-anchor="start" font-family="Noto Sans JP" font-size="24" id="svg_3" y="110" x="20" stroke-width="0" stroke="#000000" fill="#000000">Balance: ',
            balance.toString(),
            '</text>',
            '<text xml:space="preserve" text-anchor="start" font-family="Noto Sans JP" font-size="24" id="svg_4" y="160" x="20" stroke-width="0" stroke="#000000" fill="#000000">Slot: ',
            slot.toString(),
            '</text>',

            // Right side with image or any other content
             '<image x="300" width="300" height="300" href="', imageurl, '"/>',

            // Value in bigger font
            '<text xml:space="preserve" text-anchor="start" font-family="Noto Sans JP" font-size="36" id="svg_5" y="260" x="320" stroke-width="0" stroke="#000000" fill="#000000">Value: ',
            balance.toString(),
            '</text>',

            // Name
            '<text xml:space="preserve" text-anchor="start" font-family="Noto Sans JP" font-size="28" id="svg_6" y="320" x="320" stroke-width="0" stroke="#000000" fill="#000000">Name: Your NFT Name',
            '</text>',

            // Slot Name
            '<text xml:space="preserve" text-anchor="start" font-family="Noto Sans JP" font-size="24" id="svg_7" y="380" x="320" stroke-width="0" stroke="#000000" fill="#000000">Slot Name: ',
            slot.toString(),
            '</text>',

            // Owner
            '<text xml:space="preserve" text-anchor="start" font-family="Noto Sans JP" font-size="24" id="svg_8" y="440" x="320" stroke-width="0" stroke="#000000" fill="#000000">Owner: ',
            owner,
            '</text>',

            '</g></svg>'
        )
    );

    return svg;
}

function tokenURI(uint256 tokenId_) public  virtual override    returns (string memory) {
    string memory svgImage = createSVG(tokenId_);
    string memory json = string(
        abi.encodePacked(
            '{"name": "VMANNFT #',
            tokenId_.toString(),
            '", "description": "VMANNFT", "attributes": "", "image":"data:image/svg+xml;base64,',
            Base64.encode(bytes(svgImage)),
            '"}'
        )
    );
  
    return string(abi.encodePacked("data:application/json;base64,", Base64.encode(bytes(json))));
   
}
}
