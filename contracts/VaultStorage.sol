pragma solidity 0.5.16;

contract VaultStorage {

    bytes32 internal constant _UNDERLYING_SLOT = 0x1994607607e11d53306ef62e45e3bd85762c58d9bf38b5578bc4a258a26a7371;
    bytes32 internal constant _CONTROLLER_SLOT = 0xc86dc58702bb65b33e6cfe9e01b433d3f7e9b5e5106352e1cdfffcb2b0e9ef58;

    constructor() public {
        assert(_UNDERLYING_SLOT == bytes32(uint256(keccak256("eip1967.vaultStorage.underlying")) - 1));
        assert(_CONTROLLER_SLOT == bytes32(uint256(keccak256("eip1967.vaultStorage.controller")) - 1));
    }

    function setAddress(bytes32 slot, address _address) private {
        // solhint-disable-next-line no-inline-assembly
        assembly {
            sstore(slot, _address)
        }
    }

    function setUint256(bytes32 slot, uint256 _value) private {
        // solhint-disable-next-line no-inline-assembly
        assembly {
            sstore(slot, _value)
        }
    }

    function getAddress(bytes32 slot) private view returns (address str) {
        // solhint-disable-next-line no-inline-assembly
        assembly {
            str := sload(slot)
        }
    }

    function getUint256(bytes32 slot) private view returns (uint256 str) {
        // solhint-disable-next-line no-inline-assembly
        assembly {
            str := sload(slot)
        }
    }

    uint256[50] private ______gap;
}