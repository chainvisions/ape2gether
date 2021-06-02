pragma solidity 0.5.16;

interface IStrategy {
    function withdrawableLiquidity() external view returns (uint256);
}