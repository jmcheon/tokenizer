const hre = require("hardhat");

async function main() {
  const Jung42Token = await hre.ethers.getContractFactory("Jung42Token");
  const jung42token = await Jung42Token.deploy(100000000, 50);

  await jung42token.waitForDeployment();

  console.log("Jung42 Token deployed: ", await jung42token.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});