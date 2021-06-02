pragma solidity 0.5.16;

contract VaultStorage {

    bytes32 internal constant _UNDERLYING_SLOT = 0x1994607607e11d53306ef62e45e3bd85762c58d9bf38b5578bc4a258a26a7371;
    bytes32 internal constant _CONTROLLER_SLOT = 0xc86dc58702bb65b33e6cfe9e01b433d3f7e9b5e5106352e1cdfffcb2b0e9ef58;
    bytes32 internal constant _REWARDS_PER_SHARE_SLOT = 0xf0b9b8262b9626c3bacaff49eb9c85ae8e0ab8125db85aa67785f65b7fddd8a5;
    bytes32 internal constant _AVAILABLE_LIQUIDITY_SLOT = 0xd8becd4cf8e1ee5c9f8c2ddae1ddae13e761882a4b694c210791020df123eb4c;
    bytes32 internal constant _LIQUIDITY_NEEDED_SLOT = 0xd4ef9f0703e247f131b4633e628e5488bf7a2757037de165c0f9abc6831f6bba;

    enum Exit {
        Queued,     // Exit was queued and awaiting fulfillment.
        Covered     // Enough liquidity was available to cover the exit.
    }

    mapping(address => uint256) public userRequestedLiquidity;

    constructor() public {
        assert(_UNDERLYING_SLOT == bytes32(uint256(keccak256("eip1967.vaultStorage.underlying")) - 1));
        assert(_CONTROLLER_SLOT == bytes32(uint256(keccak256("eip1967.vaultStorage.controller")) - 1));
        assert(_REWARDS_PER_SHARE_SLOT == bytes32(uint256(keccak256("eip1967.vaultStorage.rewardsPerShare")) - 1));
        assert(_AVAILABLE_LIQUIDITY_SLOT == bytes32(uint256(keccak256("eip1967.vaultStorage.availableLiquidity")) - 1));
        assert(_LIQUIDITY_NEEDED_SLOT == bytes32(uint256(keccak256("eip1967.vaultStorage.liquidityNeeded")) - 1));
    }

    function _setUnderlying(address _address) internal {
        setAddress(_UNDERLYING_SLOT, _address);
    }

    function _underlying() internal view returns (address) {
        return getAddress(_UNDERLYING_SLOT);
    }

    function _setController(address _address) internal {
        setAddress(_CONTROLLER_SLOT, _address);
    }

    function _controller() internal view returns (address) {
        return getAddress(_CONTROLLER_SLOT);
    }

    function _availableLiquidity() internal view returns (uint256) {
        return getUint256(_AVAILABLE_LIQUIDITY_SLOT);
    }

    function _liquidityNeeded() internal view returns (uint256) {
        return getUint256(_LIQUIDITY_NEEDED_SLOT);
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

    uint256[48] private ______gap;
}