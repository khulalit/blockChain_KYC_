// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.8.7;

/*
    -function
        addBank
        getBanks
        getBank or getBankDetails
        updateBankDetails
        kycVerification
        getCustomers
        getKycDoneByTheBank


*/

import "./Customer.sol";

contract Bank{
    struct Bank_{
        string name; 
        string code;
        string headOfficeAddress;
        string[] email;
        string[] phone;
        address id_;
        uint kycCount;
        address[] kycDone;
        uint status; // 0 active , 1 not active
    }

    address[] internal bankList;
    mapping(address => Bank_) internal banks;

    modifier isValidBank(address id_) {
        require(banks[id_].id_ != address(0), "Bank not found");
        require(banks[id_].id_ == id_, "Bank not found");
        require(
            banks[id_].status == 0,
            "Bank is not active"
        );
        _;
    }
    function addBank(Bank_ memory b) internal {
        banks[b.id_] = b;
        bankList.push(banks[b.id_].id_);
    }

    function getBanks() internal view returns (address[]  memory) {
        return bankList;
    }

    function getBank(address id_) internal view returns (Bank_ memory) {
        return banks[id_];
    }

    function updateBankDetails(address id_, string memory name, string memory headOfficeAddress, string memory code) internal {
        banks[id_].name = name;
        banks[id_].headOfficeAddress = headOfficeAddress;
        banks[id_].code = code;

    }

    // function kycVerification(address cus_id, address bank_id, )
    function getKycDoneByTheBank(address id_) internal view returns(address[] memory){
        return banks[id_].kycDone;
    }

    

}