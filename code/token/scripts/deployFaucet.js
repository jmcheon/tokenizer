const hre = require("hardhat");

async function main() {
  const Faucet = await hre.ethers.getContractFactory("Faucet");
  const faucet = await Faucet.deploy("0x6Eb3eA000c4591f9dCEFc5E869E0A19628e8a4c2");

  await faucet.waitForDeployment();

  console.log("Faucet contract deployed: ", await faucet.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});