import "@matterlabs/hardhat-zksync-deploy";
import "@matterlabs/hardhat-zksync-verify";
import "@matterlabs/hardhat-zksync-solc";
import "@nomiclabs/hardhat-waffle";
import "@nomiclabs/hardhat-solhint";
import "hardhat-gas-reporter";
require('dotenv').config()

module.exports = {
  // hardhat-zksync-solc
  // The compiler configuration for zkSync artifacts.
  zksolc: {
    version: "latest",
    compilerSource: "binary",
  },

  // The compiler configuration for default artifacts.
  solidity: {
    compilers: [
      {
        version: "0.8.15",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
            details: {
              yul: false
            }
          },
        }
      },
      {
        version: "0.6.12",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
            details: {
              yul: false
            }
          },
        }
      },
    ]
  },

  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },

  defaultNetwork: 'hardhat',
  networks: {
    hardhat: {
      allowUnlimitedContractSize: false,
    },

    sepolia: {
      url: "https://rpc2.sepolia.org"
    },

    mainnet: {
      url: "https://eth.llamarpc.com"
    },

    zkSyncTestnet: {
      zksync: true,
      // URL of the Ethereum Web3 RPC, or the identifier of the network (e.g. `mainnet` or `sepolia`)
      ethNetwork: "sepolia",
      // URL of the zkSync network RPC
      url: 'https://sepolia.era.zksync.dev',
      // Verification endpoint for Sepolia
      verifyURL: 'https://sepolia.explorer.zksync.io/contract_verification'
    },

    zkSyncMainnet: {
      zksync: true,
      ethNetwork: "mainnet",
      url: 'https://mainnet.era.zksync.io',
      verifyURL: 'https://explorer.zksync.io/contract_verification'
    },
  },
  mocha: {
    timeout: 40000
  },
};