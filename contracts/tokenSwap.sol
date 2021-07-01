// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;


//import the ERC20 interface

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}


//import the uniswap router
//the contract needs to use swapExactTokensForETH
//this will allow us to import swapExactTokensForETH into our contract

interface IUniswapV2Router {
 function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
  

}




contract tokenSwap {
     mapping ( address => uint256 ) public balances;

    //address of the uniswap v2 router
    address private constant UNISWAP_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    
    //address of WETH token. 
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    

    //this swap function is used to trade from one token to another
    //token in = the token address you want to trade out of
    //amount in = the amount of tokens you are sending in
    
   function swap(address _tokenIn,uint256 _amountIn) external {
      
    //first we need to transfer the amount in tokens from the msg.sender to this contract
    //this contract will have the amount of in tokens
    IERC20(_tokenIn).transferFrom(msg.sender, address(this), _amountIn);
    
    //next we need to allow the uniswapv2 router to spend the token we just sent to this contract
    //by calling IERC20 approve you allow the uniswap contract to spend the tokens in this contract 
    IERC20(_tokenIn).approve(UNISWAP_V2_ROUTER, _amountIn);

    //path is an array of addresses.
    address[] memory path;
      path = new address[](2);
      path[0] = _tokenIn;
      path[1] = WETH;
    uint256 balance= address(this).balance;
    
        //then we will call swapExactTokensForETH
        //the deadline is the latest time the trade is valid for
        IUniswapV2Router(UNISWAP_V2_ROUTER).swapExactTokensForETH(_amountIn, 0, path, address(this), block.timestamp);
       
       balances[msg.sender] += address(this).balance-balance;
    }
    
       
    function withdrawETH() external payable returns (uint){
    uint256 amount = balances[msg.sender];
     
    IERC20(address(this)).transfer(msg.sender,amount);
    balances[msg.sender] = 0;
      return amount;
    }
}