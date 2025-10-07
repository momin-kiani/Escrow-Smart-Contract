// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

interface ERC20Interface {
function totalSupply() external view returns (uint);
function balanceOf (address account) external view returns (uint balance);
function transfer(address recipient, uint amount) external returns (bool success);
function allowance(address owner, address spender) external view returns (uint remaining);
function approve(address spender, uint amount) external returns (bool success);
function transferFrom(address sender, address recipient, uint amount) external returns (bool success);


event Transfer(address indexed from, address indexed to, uint value);
event Approval(address indexed owner, address indexed spender, uint value);

}

contract escrow {

uint public startTime;
uint public ethDeposit;
uint public alreadyClaimedETH;
uint public alreadyClaimedTokens;

address public depositor;
address public tokenRecipient;
address public ethRecipent;
address public tokenAddress;
uint public tokenDeposit;
bool public cancelled;
ERC20Interface public token;

mapping(address => bool) public greenFlag;

constructor  (
address _tokenRecipient,
address _ethRecipient,
address _tokenAddress
) payable {
depositor = msg.sender;
tokenRecipient = _tokenRecipient;
ethRecipent = _ethRecipient;
tokenAddress = _tokenAddress;
token = ERC20Interface(_tokenAddress);

startTime = block.timestamp + 5 minutes;


}

modifier onlyDepositor() {
require(msg.sender == depositor, "Only depositor allowed");
_;
}

modifier onlyBeforeStart(){
require(block.timestamp <= startTime , "Buffer period ended");
_;
}

function cancelEscrow() external onlyDepositor onlyBeforeStart {
cancelled = true;
payable(depositor).transfer(address(this).balance); // refund ETH

}

function giveGreenFlag() external {
require(msg.sender == tokenRecipient || msg.sender == ethRecipent, "Not a recipient");
greenFlag[msg.sender] = true;
}

function cancelAfterBuffer() external onlyDepositor {
require(block.timestamp > startTime + 5 minutes, "Buffer not over");
require(greenFlag[tokenRecipient] || greenFlag[ethRecipent], "Recipient must approve");
cancelled = true;
payable(depositor).transfer(address(this).balance);
}

function depositTokens(uint _amount) external onlyDepositor {
token.transferFrom(msg.sender, address(this), _amount);
tokenDeposit += _amount;
}

function claimTokens() external {
require(block.timestamp >= startTime, "Escrow has not started yet");
require(msg.sender == tokenRecipient, "Not token recipient");
require(!cancelled, "Escrow cancelled");


uint elapsed = (block.timestamp - startTime) / 2 minutes;
if (elapsed > 10) elapsed = 10;

uint totalEntitled = (tokenDeposit * elapsed * 10) / 100;
uint payout = totalEntitled - alreadyClaimedTokens;

if (payout > 0) {
    alreadyClaimedTokens += payout;
    token.transfer(tokenRecipient, payout);
}


}

function depositETH() external payable onlyDepositor {
ethDeposit += msg.value;
}

function claimETH() external {
require(msg.sender == ethRecipent, "Not ETH recipient");
require(!cancelled, "Escrow cancelled");


uint elapsed = (block.timestamp - startTime) / 90 seconds; 
if (elapsed > 8) elapsed = 8; // max 8 intervals (12 min total)

uint totalEntitled = (ethDeposit * elapsed * 125) / 1000; // 12.5% each interval

uint payout = totalEntitled - alreadyClaimedETH;

if (payout > 0) {
    alreadyClaimedETH += payout;
    payable(ethRecipent).transfer(payout);
}
}
}
