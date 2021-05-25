pragma solidity 0.5.16;

import "./interfaces/IApeController.sol";
import "./interfaces/IVault.sol";
import "./VaultStorage.sol";

/// @title Ape2Gether Vault Implementation.
/// @author Chainvisions
/// @notice Implementation contract for Ape2gether vaults.

contract Vault is IVault, VaultStorage {
    address public underlying;
    address public controller;

    modifier defense {
        require(msg.sender == tx.origin || IApeController(controller).whitelist(msg.sender), "Vault: Contract not whitelisted");
        _;
    }

    function deposit(uint256 _amount) public {
        _deposit(msg.sender, msg.sender, _amount);
    }

    function _deposit(address _from, address _for, uint256 _amount) internal defense {

    }

}