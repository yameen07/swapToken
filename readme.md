# Contract to swap Token for Eth using Uniswap Router


Project Implementation : yameen khan

The contract is deployed on ropsten testnet.
on address:0x6F2082574811eD6CEB6f0787a2E92aFa63C7103e

## function swap

this function is used to swap the exact amount of tokens for the ETH.

it requires 2 input :
1. adress of the token to swap.
2. amount of token to swap.

## function withdrawETH

this function transfer the amount of eth recieved during exchange from contract to the user address.

the user address will be the function caller address.

## index.html
 
 this file is used to access the functionalities of the contract deployed on the ropsten testnet,
 by using its contract abi and contract address.

## known issues

the index.html (web interface) cannot access and interface with the contract abi.