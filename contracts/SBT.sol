// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract SBT_test is ERC721URIStorage  {

    address owner;

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("Fansoul", "FS") {
        owner = msg.sender;
    }

    mapping(address => string) public personToDegree;

    function claimDegree(string memory tokenURI)
        public
        returns (uint256)
    {
        require(issuedDegrees[msg.sender], "Degree is not issued");

        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        personToDegree[msg.sender] = tokenURI;
        issuedDegrees[msg.sender] = false;

        return newItemId;
    }

    function checkDegreeOfPerson(address person) external view returns (string memory) {
        return personToDegree[person];
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    mapping(address => bool) public issuedDegrees;

    function issueDegree(address to) onlyOwner external {
        issuedDegrees[to] = true;
    }
}