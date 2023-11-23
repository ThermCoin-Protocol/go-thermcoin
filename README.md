# Connecting to Thermcoin Network

## Create wallet with MetaMask

1. Download and open MetaMask

2. Go to Settings -> Add a network -> Add a network manually

3. Fill in network URL and chain ID

   Network name: Thermcoin Network

   RPC URL: http://<TBA.com>:8545

   Chain ID: 7349

   Symbol: ---

4. Import token:

   Contract address: <TBA>

   Token symbol: BTUC

## Mining quick-start guide

1. Download Thermcoin executable from https://github.com/ThermCoin-Protocol/go-thermcoin/releases/

2. Unzip and place "therm" executable in folder with genesis block (genesis.json)

3. Set up your data directory:

   ```shell

   mkdir myNode

   therm --datadir ./myNode init genesis.json

   ```

4. Start your miner and connect to the Thermcoin network, make sure to replace --miner.etherbase with your wallet address:

   ```shell

   ./therm --datadir ./myNode --bootnodes <bootnode-enode-url> --nodiscover --snapshot=false --mine --miner.threads=1

   ```

Congrats! You are now connected and supporting the Thermcoin protocol

#### Network URL (JSON-RPC Endpoints)

<TBA>:8545

#### Bootnode Enode-URL's

1. Bootnode: <TBA>
2. Bootnode-backup: <TBA>


## Build from source

ThermCoin binaries are released and hosted on github for download. Otherwise, clone this repo and build from source.

Building `therm` requires both a Go (version 1.16 or later) and a C compiler. You can install them using your favourite package manager. Once the dependencies are installed, run

```shell
make therm
```

or, to build the full suite of utilities:

```shell
make all
```

## Defining the genesis state

The `genesis.json` file included in this repo defines the genesis block of the ThermCoin network.

For the ThermCoin network. you'll need to initialize **every**
`therm` node with it prior to starting it up to ensure all blockchain parameters are correctly
set:

```shell
$ therm init genesis.json
```