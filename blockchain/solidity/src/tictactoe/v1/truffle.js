require('babel-register');
require('babel-polyfill');

module.exports = {
  networks: {
    test: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    }
  }
};

