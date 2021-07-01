var tokenSwap = artifacts.require("tokenSwap");

module.exports = function(deployer) {
    deployer.deploy(tokenSwap);
};