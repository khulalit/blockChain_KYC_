// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.8.7;
/*
    - function
        addCustomer
        updateCustomerProfile
        getCustomerDetails
        isValidCustomer
        isCustomerExists
*/
contract Customer {

    struct Customer_ {
        string name;
        string email;
        uint phoneNo;
        address id_;
        address KycVerifiedBy;
        uint KycStatus; // 0 = pending, 1 = verified, 2 = rejected
    }
    //
    address[] customerList;
    mapping(address => Customer_ ) customer;


    // function to addUser
    function isCustomerExists(address id_) internal view returns(bool exits_) {
        require(id_ != address(0) , "ID is empty");
        if(customer[id_].id_ != address(0)){
            exits_ = true;
        }
        return exits_;
        
    }
    // 
    function addCustomer(Customer_ memory c, address id_) internal {
            customer[id_] = c;
            customerList.push(customer[id_].id_);
    }
    function updateCustomerProfile(string memory name, string memory email, uint phone) internal {
        customer[msg.sender].name = name;
        customer[msg.sender].email = email;
        customer[msg.sender].phoneNo = phone;
    }
    function getCustomerDetails(address id_) internal view returns(Customer_ memory) {
        return customer[id_];
    }

    // modifier isValidCustomer(address id_) {
    //     require(id_ != address(0), "Id is Empty");
    //     require(customers[id_].id_ != address(0), "User Id Empty");
    //     require(
    //         !Helpers.compareStrings(customers[id_].email, ""),
    //         "User Email Empty"
    //     );
    //     _;
    // }
}