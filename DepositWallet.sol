pragma solidity ^0.4.13;

contract DepositController {
    function isAuthorized(address src, address desitination, uint value, bytes data) public returns (bool);
}

contract DepositWallet {
    DepositController      public  controller;
    
    function DepositWallet(address _controller) public {
        controller = DepositController(_controller);
    }
    
    function () public payable {
    }
    
    function execute(address destination, uint value, bytes data) public {
        require(controller.isAuthorized(msg.sender, destination, value, data));
        destination.call.value(value)(data);
    }
}