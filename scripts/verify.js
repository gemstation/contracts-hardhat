const hre = globalThis.hre;

(async () => {
  const { $ } = (await import('execa'))
  const rootFolder = process.cwd()

  const deploymentInfo = require('../gemforge.deployments.json')

  const target = process.env.GEMFORGE_DEPLOY_TARGET
  if (!target) {
    throw new Error('GEMFORGE_DEPLOY_TARGET env var not set')
  }

  // skip localhost
  if (target === 'local') {
    console.log('Skipping verification on local')
    return
  }

  console.log(`Verifying for target ${target} ...`);

  const { chainId, contracts = [] } = deploymentInfo[target] || {}

  if (!chainId) {
    throw new Error(`No chainId found for target ${target}`);
  }

  const networkName = Object.keys(hre.config.networks).find((name) => {
    return hre.config.networks[name].chainId === parseInt(chainId);
  });

  if (!networkName) {
    throw new Error(`No network name found for chain ${chainId}`);
  }

  console.log(`Network name: ${networkName}`);

  for (let { name, fullyQualifiedName, onChain } of contracts) {
    let args = "";

    if (onChain.constructorArgs.length) {
      args = onChain.constructorArgs.join(", ")
    }

    console.log(
      `Verifying ${name} [${fullyQualifiedName}]  at ${onChain.address} with args ${args}`
    );

    if (args) {
      await $({ cwd: rootFolder })`npx hardhat verify --network ${networkName} --contract ${fullyQualifiedName} ${onChain.address} ${args}`
    } else {
      await $({ cwd: rootFolder })`npx hardhat verify --network ${networkName} --contract ${fullyQualifiedName} ${onChain.address}`
    }

    console.log(`Verified!`);
  }
})()
