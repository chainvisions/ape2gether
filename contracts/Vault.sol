pragma solidity 0.5.16;

import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/SafeERC20.sol";
import "./interfaces/IApeController.sol";
import "./interfaces/IVault.sol";
import "./VaultStorage.sol";

/// @title Ape2Gether Vault Implementation.
/// @author Chainvisions
/// @notice Implementation contract for Ape2gether vaults.

contract Vault is ERC20, ERC20Detailed, IVault, VaultStorage {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    function initializeVault(
        address _underlying,
        address _controller
    ) public initializer {
        _setUnderlying(_underlying);
        _setController(_controller);
    }

    modifier defense {
        require(msg.sender == tx.origin || IApeController(_controller()).whitelist(msg.sender), "Vault: Contract not whitelisted");
        _;
    }

    function deposit(uint256 _amount) public {
        _deposit(msg.sender, msg.sender, _amount);
    }

    function _deposit(address _from, address _for, uint256 _amount) internal defense {
        require(_amount > 0, "Vault: Cannot deposit 0");
    }

    /// @dev Performs an exit from the vault.
    /// @return The status of the exit from the vault.
    function withdraw(uint256 _liquidity) public returns (uint256) {
        require(_liquidity > 0, "Vault: Cannot withdraw 0");
        require(_liquidity <= balanceOf(msg.sender), "Vault: Cannot withdraw more than your deposit");

        // Calculate the amount of liquidity needed.
        uint256 availableToCover = availableLiquidity().sub(liquidityNeeded());

        // If the vault cannot cover the liquidity, we need to queue a withdrawal.
        if(availableToCover < _liquidity) {
            _burn(msg.sender, _liquidity);
            userRequestedLiquidity[msg.sender] = _liquidity;
            return uint256(Exit.Queued);
        } else {
            // We have enough liquidity to cover the withdrawal.
            _burn(msg.sender, _liquidity);
            IERC20(underlying()).safeTransfer(msg.sender, _liquidity);
            return uint256(Exit.Covered);
        }

    }

    /// @dev Claims vault rewards.
    function claim() public {
        
    }

    function underlying() public view returns (address) {
        return _underlying();
    }

    function controller() public view returns (address) {
        return _controller();
    }

    function availableLiquidity() public view returns (uint256) {
        return _availableLiquidity();
    }

    function liquidityNeeded() public view returns (uint256) {
        return _liquidityNeeded();
    }
}