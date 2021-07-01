var HDWalletProvider = require("truffle-hdwallet-provider");
const MNEMONIC = 'fossil unhappy warrior prison hybrid age benefit solution rail can eye calm';

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(MNEMONIC, "https://ropsten.infura.io/v3/e528fac8ef804730ba41c0c6eb6b3d85")
      },
      network_id: 3,
      gas: 4000000     
    }
  },
 
  compilers: {
    solc: {
      version: "^0.7.0"
    }
  }
};

