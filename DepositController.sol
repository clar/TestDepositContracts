pragma solidity ^0.4.13;

contract Authority {
    function canCall(
        address src, address destination, uint value, bytes data
    ) public view returns (bool);
}

contract AuthEvents {
    event LogSetAuthority (address indexed authority);
    event LogSetOwner     (address indexed owner);
}

contract DepositController {
    function isAuthorized(address src, address desitination, uint value, bytes data) public returns (bool);
}

contract DefaultDepositController is AuthEvents, DepositController {
    Authority  public  authority;
    address      public  owner;
    address public destination;

    function DefaultDepositController() public {
        owner = msg.sender;
        LogSetOwner(msg.sender);
    }

    function setOwner(address owner_)
        public
    {
        require(msg.sender == owner);
        owner = owner_;
        LogSetOwner(owner);
    }

    function setAuthority(Authority authority_)
        public
    {
        require(msg.sender == owner);
        authority = authority_;
        LogSetAuthority(authority);
    }

    function isAuthorized(address src, address destination, uint value, bytes data) public view returns (bool) {
        if (src == owner) {
            return true;
        } else if (authority == Authority(0)) {
            return false;
        } else {
            return authority.canCall(src, destination, value, data);
        }
    }
}