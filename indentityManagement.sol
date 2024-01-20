// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IdentityVerification {
    mapping(address => bool) public isVerified;
    mapping(address => string) public identityInfo;
    mapping(address => string) public aadharInfo;

    event IdentityVerified(address indexed userAddress, string identityInformation);

    modifier onlyNotVerified() {
        require(!isVerified[msg.sender], "User is already verified");
        _;
    }

    function submitIdentity(string memory identityInformation, string memory aadharInformation) public onlyNotVerified {
        require(bytes(identityInformation).length > 0, "Identity information cannot be empty");
        require(bytes(aadharInformation).length > 0, "Aadhar information cannot be empty");

        identityInfo[msg.sender] = identityInformation;
        aadharInfo[msg.sender] = aadharInformation;
        isVerified[msg.sender] = true;

        emit IdentityVerified(msg.sender, identityInformation);
    }

    function isUserVerified() public view returns (bool) {
        return isVerified[msg.sender];
    }

    function getIdentityInformation() public view returns (string memory) {
        return identityInfo[msg.sender];
    }

    function getAadharInformation() public view returns (string memory) {
        return aadharInfo[msg.sender];
    }
}
