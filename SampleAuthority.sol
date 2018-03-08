pragma solidity ^0.4.13;

contract SampleAuthority {
    address public coldWallet;

    address public collectAddress;

    address public erc20TokenAddress;

    function SampleAuthority(address _coldWallet, address _collectAddress, address _erc20TokenAddress) public {
        coldWallet = _coldWallet;
        collectAddress = _collectAddress;
        erc20TokenAddress = _erc20TokenAddress;
    }


    function canCall(
        address src, address destination, uint value, bytes data
    ) public view returns (bool)
    {
        if (destination == coldWallet){
            return collectAddress  == src;
        } else if (destination == erc20TokenAddress)
        {
            return collectAddress  == src && value == 0;
        } else {
            return false;
        }
    }
}