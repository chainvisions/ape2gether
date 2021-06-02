pragma solidity 0.5.16;

import "./interfaces/IVault.sol";

/// @title Ape2Gether Controller
/// @author Chainvisions
/// @notice Controller contract for Ape2Gether vaults.
contract ApeController {
    struct VaultData {
        string name;            // Name of the vault.
        address vaultAddr;      // Address of the vault contract.
        uint256 performanceFee; // Performance fee for the protocol.
        uint256 depositCap;     // Cap on deposits into the vault due to risk.
    }

    mapping(address => bool) public harvesters;
    mapping(address => bool) public whitelist;
    mapping(address => VaultData) public vault;

    function addToWhitelist(address _contract) public {
        whitelist[_contract] = true;
    }

    function removeFromWhitelist(address _contract) public {
        whitelist[_contract] = false;
    }

    function apeIn(address _vault) public {
        IVault(_vault).apeIn();
    }

}