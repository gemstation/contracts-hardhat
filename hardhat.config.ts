require("dotenv").config();
import type { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.21",
  networks: {
    base_sepolia: {
      url: 'https://sepolia.base.org',
    }
  },
  etherscan: {
    apiKey: {
      base_sepolia: process.env.BASESCAN_API_KEY
    },
    customChains: [
      {
        network: "base_sepolia",
        chainId: 84532,
        urls: {
          apiURL: "https://api-sepolia.basescan.org/api",
          browserURL: "https://sepolia.basescan.org"
        }
      }
    ]    
  },
};

export default config;
