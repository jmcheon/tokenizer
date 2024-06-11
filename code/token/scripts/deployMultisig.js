const hre = require("hardhat");
require("dotenv").config();

async function main() {
  const Multisig = await hre.ethers.getContractFactory("Multisig");
  const multisig = await Multisig.deploy(process.env.TOKEN_ADDRESS || "", 
  	[
		process.env.MULTISIG_ACCOUNT1 || "",
		process.env.MULTISIG_ACCOUNT2 || "",
		process.env.MULTISIG_ACCOUNT3 || "",
		process.env.MULTISIG_ACCOUNT4 || "",
	], process.env.NUM_CONFIRMATIONS_REQUIRED);

  await multisig.waitForDeployment();

  console.log("Multisig contract deployed: ", await multisig.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});