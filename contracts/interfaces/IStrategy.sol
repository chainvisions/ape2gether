pragma solidity 0.5.16;

interface IStrategy {
    function apeIn() external;
    function withdrawableLiquidity() external view returns (uint256);
}