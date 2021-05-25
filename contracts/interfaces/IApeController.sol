pragma solidity 0.5.16;

interface IApeController {
    function vault() external view returns (string memory, address, uint256, uint256);
    function whitelist(address _account) external view returns (bool);
}