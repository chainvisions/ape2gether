pragma solidity 0.5.16;

interface IVault {
    function deposit(uint256 _amount) external;
    function depositFor(address _for, uint256 _amount) external;

    function claim() external;
    function apeIn() external;

    function underlyingBalanceWithInvestment() external view returns (uint256);
}