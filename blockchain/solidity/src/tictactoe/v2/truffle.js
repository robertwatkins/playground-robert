require('babel-register');
require('babel-polyfill');

module.exports = {
  networks: {
    test: {
      host: "127.0.0.1",
      port: 8545, //8545 is ganache-cli, 7545 is ganache (UI)
      network_id: "*" // Match any network id
    }
  }
};

