// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.8.7;

import "./Customer.sol";
import "./Bank.sol";
import "./UtilityFunction.sol";

contract KYC is Customer , Bank{

    struct KycRequest {
        string id_; // Combination of customer Id & bank is going to be unique
        address userId_;
        string customerName;
        address bankId_;
        string bankName;
        // string dataHash;
        uint256 updatedOn; //  or kyc done on
        uint status; // 0 = pending, 1 = verified, 2 = rejected
        // DataHashStatus dataRequest; // Get approval from user to access the data
        string remarks; // Notes that can be added if KYC verification fails  OR
        // if customer rejects the access & bank wants to re-request with some message
    }
    address admin;
    address[] internal userList;

    mapping(address => Customer_) internal users;
    mapping(string => KycRequest) internal kycRequests;
    mapping(address => address[]) internal bankCustomers; // All customers associated to a Bank
    mapping(address => address[]) internal customerbanks; // All banks associated to a Customer

    constructor() {
        admin = msg.sender;
    }
    
    modifier isAdmin(){
        require(msg.sender == admin, "Only Admin is permitted to this task");
        _;
    }

    function addBank_(Bank_ memory bank_) public isAdmin {
        addBank(bank_);
    }

    function updateBankDetails_(
        address id_,
        string memory name,
        string memory headOfficeAddress,
        string memory code
    ) public isAdmin {
        updateBankDetails(id_, name, headOfficeAddress, code);
    }

    function addCustomer_(Customer_ memory c , address bank_id, address customer_adrs) public isValidBank(bank_id) {
        addCustomer(c,customer_adrs);
    }
    function searchCustomer(address id_) public view isValidBank(msg.sender) returns(Customer_ memory) {
        Customer_ memory customer;
        for(uint i = 0 ; i< bankCustomers[msg.sender].length; i++){
            if(bankCustomers[msg.sender][i] == id_ )
                return users[id_];
        }
        return customer;
    }

    function isKycAlreadyDone(string memory kycId) public view returns(bool)  {
        if(UtilityFunction.isEqual(kycRequests[kycId].id_,"0"))
            if(kycRequests[kycId].status == 0)
            return true;
        return false;
    }

}