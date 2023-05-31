# Connecting to Thermcoin Network

## Create wallet with MetaMask

1. Download and open MetaMask

2. Go to Settings -> Add a network -> Add a network manually

3. Fill in network URL and chain ID

   Network name: Thermcoin Network <br/>
   RPC URL: http://3.80.95.168:8545 <br/>
   Chain ID: 4222 <br/>
   Symbol: BTUC <br/>

## Mining quick-start guide

1. Download Thermcoin executable from https://github.com/ThermCoin-Protocol/go-thermcoin/releases/

2. Unzip and place "therm" executable in folder with genesis block (genesis.json)

3. Create your data directory:

   ```shell
   mkdir myNode
   ```
   
4. Initialize your data directory: <br/>

   MacOS/Linux:
   ```shell
   ./therm --datadir ./myNode init genesis.json
   ```
   
   Windows:
   ```shell
   ./therm.exe --datadir ./myNode init genesis.json
   ```
   
5. Start your miner and connect to the Thermcoin network, make sure to replace --miner.etherbase with your wallet address:

   MacOS/Linux:
   ```shell
   
   ./therm --datadir ./myNode --bootnodes enode://0a1c75aa6733ad3b07d512aed5dc209b951adb459db3db4e19df122ae92250b77f7c1cb5212c18b37526b7b764188648b7e7bf3700e1808bebb432c2fa8feb21@3.80.95.168:30304 console  --mine --miner.threads=1 --miner.etherbase=0x000...

   admin.addPeer("enode://15de3044dc7d3a0185da17011e3d3725054b5df20d86d4a03e6c38052408d67ea0db8b16846b2b907226a33c9417cab394f3b7c2f814408d8bbcac07e14696d4@3.80.95.168:30303")

   ```
   
   Windows:
   ```shell
   
   therm.exe --datadir ./myNode --bootnodes enode://0a1c75aa6733ad3b07d512aed5dc209b951adb459db3db4e19df122ae92250b77f7c1cb5212c18b37526b7b764188648b7e7bf3700e1808bebb432c2fa8feb21@3.80.95.168:30304 console  --mine --miner.threads=1 --miner.etherbase=0x000...

   admin.addPeer("enode://15de3044dc7d3a0185da17011e3d3725054b5df20d86d4a03e6c38052408d67ea0db8b16846b2b907226a33c9417cab394f3b7c2f814408d8bbcac07e14696d4@3.80.95.168:30303")

   ```

Congrats! You are now connected and supporting the Thermcoin protocol

## Network URL (JSON-RPC Endpoints)

3.80.95.168:8545 <br/>
3.80.95.168:8546 <br/>

## Bootnode Enode-URL's

enode://15de3044dc7d3a0185da17011e3d3725054b5df20d86d4a03e6c38052408d67ea0db8b16846b2b907226a33c9417cab394f3b7c2f814408d8bbcac07e14696d4@3.80.95.168:30303 <br/>

enode://0a1c75aa6733ad3b07d512aed5dc209b951adb459db3db4e19df122ae92250b77f7c1cb5212c18b37526b7b764188648b7e7bf3700e1808bebb432c2fa8feb21@3.80.95.168:30304 <br/>

enode://d645fa278e5b7e3d0f0496c04587704de8ad5331fa06bfd226ca5c207849e060bc11bc29a6064456d26e0f25ebb33e4de21e9bf8caa798af3c6e06f49691d2e5@3.80.95.168:30305 <br/>

## Download ThermCoin binaries or build from source

ThermCoin binaries are released and hosted on github for download. Otherwise, clone this repo and
build from source.

Download the latest binaries from here:
https://github.com/ThermCoin-Protocol/go-thermcoin/releases/

Building `therm` requires both a Go (version 1.16 or later) and a C compiler. You can install
them using your favourite package manager. Once the dependencies are installed, run

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

## Creating the rendezvous point (For devs)

Bootnodes jumpstart the network by allowing nodes to quickly connect and find other peers.

```shell
$ bootnode --genkey=boot.key
$ bootnode --nodekey=boot.key -verbosity 7 -addr "0.0.0.0:30303"
```

Bootnodes will display an `enode` URL that other nodes can use to connect to it and exchange peer information. Make sure to
replace the displayed IP address information (most probably `[::]`) with your externally
accessible IP to get the actual `enode` URL.

_Note: You could also use a full-fledged `therm` node as a bootnode, but it's the less
recommended way._

## Start up a node

With the bootnode operational and externally reachable (you can try
`telnet <ip> <port>` to ensure it's indeed reachable), start every subsequent `therm`
node pointed to the bootnode for peer discovery via the `--bootnodes` flag. It will
probably also be desirable to keep the data directory of your private network separated, so
do also specify a custom `--datadir` flag.

```shell
$ therm --datadir=path/to/custom/data/folder --bootnodes=<bootnode-enode-url>
```

_Note: Since your network will be completely cut off from the main and test networks, you'll
also need to configure a miner to process transactions and create new blocks for you._

## Running a private miner

To start a `therm` instance for mining, run it with all your usual flags, extended by:

```shell
$ therm <usual-flags> --mine --miner.threads=1 --miner.etherbase=0x000...
```

Which will start mining blocks and transactions on a single CPU thread, crediting all
proceedings to the account specified by `--miner.etherbase`. You can further tune the mining
by changing the default gas limit blocks converge to (`--miner.targetgaslimit`) and the price
transactions are accepted at (`--miner.gasprice`).

## DEV GUIDE

### Bootnode:

```shell
mkdir bootnode
therm --datadir ~/bootnode init genesis.json
cd bootnode
bootnode --genkey boot.key
nohup bootnode --nodekey boot.key --addr 0.0.0.0:30303 &
```

### Open-node 1 (OPEN HTTP ACCESS):

```shell
mkdir node1
therm --datadir ~/node1 init genesis.json
cd ~/node1
nohup therm --datadir ~/node1 --nat extip:3.80.95.168 --bootnodes enode://15de3044dc7d3a0185da17011e3d3725054b5df20d86d4a03e6c38052408d67ea0db8b16846b2b907226a33c9417cab394f3b7c2f814408d8bbcac07e14696d4@3.80.95.168:30303 --port 30304 --http --http.addr 0.0.0.0 --http.port 8545 --http.corsdomain '*' &
```

### Open-node 2 (OPEN HTTP ACCESS):

```shell
mkdir node2
therm --datadir ~/node2 init genesis.json
cd ~/node2
nohup therm --datadir ~/node2 --nat extip:3.80.95.168 --bootnodes enode://15de3044dc7d3a0185da17011e3d3725054b5df20d86d4a03e6c38052408d67ea0db8b16846b2b907226a33c9417cab394f3b7c2f814408d8bbcac07e14696d4@3.80.95.168:30303 --port 30305 --http --http.addr 0.0.0.0 --http.port 8546 --http.corsdomain '*' --authrpc.port 8552 &
```

### Add a peer

```shell
therm attach therm.ipc
admin.peers
admin.nodeInfo.enode
admin.addPeer("enode://<enode-url-of-first-node>")
```
