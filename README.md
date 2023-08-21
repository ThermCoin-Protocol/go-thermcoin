# Connecting to Thermcoin Network

## Create wallet with MetaMask

1. Download and open MetaMask

2. Go to Settings -> Add a network -> Add a network manually

3. Fill in network URL and chain ID

   Network name: Thermcoin Network
   RPC URL: http://3.23.128.68:8545
   Chain ID: 42221
   Symbol: Promethius

4. Import token:
   Contract address: 0xB5db108Cb7378c2Fd680e934686BCb81F63aDB49
   Token symbol: BTUC

## Mining quick-start guide

1. Download Thermcoin executable from https://github.com/ThermCoin-Protocol/go-thermcoin/releases/

2. Unzip and place "therm" executable in folder with genesis block (genesis.json)

3. Set up your data directory:

   ```shell

   mkdir myNode

   ./therm --datadir ./myNode init genesis.json

   ```

4. Start your miner and connect to the Thermcoin network, make sure to replace --miner.etherbase with your wallet address:

   ```shell

   ./therm --datadir ./myNode --bootnodes enode://013d9d55cb18fc36efea3cf846742a020b1c6468f6073750b01252061d65ce5d0fff0fa980490b6eface44a0c8bdf743d4aa5ec7754265be7abd80be24356116@3.23.128.68:30303 console  --snapshot=false --mine --miner.threads=1 --miner.etherbase=0xb0b85Ae295dDa42E7E189864cA1251703F3b8254



   admin.addPeer("enode://013d9d55cb18fc36efea3cf846742a020b1c6468f6073750b01252061d65ce5d0fff0fa980490b6eface44a0c8bdf743d4aa5ec7754265be7abd80be24356116@3.23.128.68:30303")

   admin.addPeer("enode://bbcda61c5f838e8429b7f2b59ccccca7f54b8bf20590d467e327f66cfe3bf4ef440ce84888b3e21f565f0febfc8d03d16afc6e97e2928e6190889936b4b8e204@3.23.128.68:30304")

   admin.addPeer("enode://38b49771992930260bd265cab8c648b24349fffc2dd6db3f050acd91747847fafc801932b3ed5f260db361ea0c799d2b5db681930f6edc681f61913880911f1f@3.23.128.68:30305")

   ```

Congrats! You are now connected and supporting the Thermcoin protocol

#### Network URL (JSON-RPC Endpoints)

3.23.128.68:8545
3.23.128.68:8546

#### Bootnode Enode-URL's

1. Bootnode:
   enode://013d9d55cb18fc36efea3cf846742a020b1c6468f6073750b01252061d65ce5d0fff0fa980490b6eface44a0c8bdf743d4aa5ec7754265be7abd80be24356116@3.23.128.68:30303

2. Node 1:
   enode://bbcda61c5f838e8429b7f2b59ccccca7f54b8bf20590d467e327f66cfe3bf4ef440ce84888b3e21f565f0febfc8d03d16afc6e97e2928e6190889936b4b8e204@3.23.128.68:30304

3. Node 2:
   enode://38b49771992930260bd265cab8c648b24349fffc2dd6db3f050acd91747847fafc801932b3ed5f260db361ea0c799d2b5db681930f6edc681f61913880911f1f@3.23.128.68:30305

## Create wallet with MetaMask

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

#### Creating the rendezvous point (For devs)

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

#### DEV GUIDE

##### Bootnode:

```shell
mkdir boot
~/build/bin/therm --datadir ~/boot init ~/build/bin/genesis.json
cd boot
~/build/bin/bootnode --genkey boot.key
nohup ~/build/bin/bootnode --nodekey boot.key --addr 0.0.0.0:30303 > bootnohup.txt &
cd ..
```

##### Open-node 1 (OPEN HTTP ACCESS):

```shell
mkdir node1
~/build/bin/therm --datadir ~/node1 init ~/build/bin/genesis.json
cd ~/node1
nohup ~/build/bin/therm --datadir ~/node1 --nat extip:3.23.128.68 --bootnodes enode://013d9d55cb18fc36efea3cf846742a020b1c6468f6073750b01252061d65ce5d0fff0fa980490b6eface44a0c8bdf743d4aa5ec7754265be7abd80be24356116@3.23.128.68:30303 --port 30304 --http --http.addr 0.0.0.0 --http.port 8545 --http.corsdomain '*' > node1nohup.txt &
```

##### Open-node 2 (OPEN HTTP ACCESS):

```shell
mkdir node2
~/build/bin/therm --datadir ~/node2 init ~/build/bin/genesis.json
cd ~/node2
nohup ~/build/bin/therm --datadir ~/node2 --nat extip:3.23.128.68 --bootnodes enode://013d9d55cb18fc36efea3cf846742a020b1c6468f6073750b01252061d65ce5d0fff0fa980490b6eface44a0c8bdf743d4aa5ec7754265be7abd80be24356116@3.23.128.68:30303,enode://bbcda61c5f838e8429b7f2b59ccccca7f54b8bf20590d467e327f66cfe3bf4ef440ce84888b3e21f565f0febfc8d03d16afc6e97e2928e6190889936b4b8e204@3.23.128.68:30304 --port 30305 --http --http.addr 0.0.0.0 --http.port 8546 --http.corsdomain '*' --authrpc.port 8552 > node2nohup.txt &
```

#### Add a peer

```shell
therm attach therm.ipc
admin.peers
admin.nodeInfo.enode
admin.addPeer("enode://<enode-url-of-first-node>")
```
