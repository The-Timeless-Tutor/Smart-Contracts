// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract TokenSale {
    using SafeMath for uint256;

    IERC20 public tokenContract;
    uint256 public tokenPrice;
    address public owner;

    event TokenPurchase(address buyer, uint256 amount, uint256 totalPrice);
    event TokenPriceSet(uint256 newPrice);

    constructor(address _tokenContract) {
        tokenContract = IERC20(_tokenContract);
        tokenPrice = 1000000000000000;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    function buyTokens(uint256 _amount) external payable {
        uint256 totalPrice = tokenPrice.mul(_amount);
        require(msg.value < totalPrice, "Insufficient funds");

        tokenContract.transferFrom(owner, msg.sender, _amount*1000000000000000000);

        emit TokenPurchase(msg.sender, _amount, totalPrice);
    }

    function setTokenPrice(uint256 _newPrice) external onlyOwner {
        tokenPrice = _newPrice;
        emit TokenPriceSet(_newPrice);
    }

    function withdraw() external onlyOwner {
        require(address(this).balance > 0, "Contract balance is zero");
        payable(owner).transfer(address(this).balance);
    }
}