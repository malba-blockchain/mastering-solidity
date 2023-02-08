//Get contract from open zeppeling wizard
//Min 51
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTPLATZI is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    uint8 uriDataId = 0;
    string [] uriData = ["https://gateway.pinata.cloud/ipfs/QmQbLn1Am7pEWXeg2MLUAWvHeU2NHk8gLKVmHyqZG56YfZ/semilla.json",
                        "https://gateway.pinata.cloud/ipfs/QmQbLn1Am7pEWXeg2MLUAWvHeU2NHk8gLKVmHyqZG56YfZ/creciendo.json",
                        "https://gateway.pinata.cloud/ipfs/QmQbLn1Am7pEWXeg2MLUAWvHeU2NHk8gLKVmHyqZG56YfZ/florecida.json"];

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("NFTPLATZI", "PLTZ") {}

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uriData[uriDataId]);
    }

    function changeData (uint16 _tokenId) public {
        uriDataId++;
        _setTokenURI(_tokenId, uriData[uriDataId]);
    }
    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
