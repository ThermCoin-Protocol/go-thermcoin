### Connecting to Thermcoin Network

#### Download ThermCoin binaries or build from source

Thermcoin binaries are released and hosted on github for download. Otherwise, clone this repo and
build from source.

Building `therm` requires both a Go (version 1.16 or later) and a C compiler. You can install
them using your favourite package manager. Once the dependencies are installed, run

```shell
make therm
```

or, to build the full suite of utilities:

```shell
make all
```

#### Defining the genesis state

The `genesis.json` file included in this repo defines the genesis block of the ThermCoin network.

For the Thermcoin network. you'll need to initialize **every**
`therm` node with it prior to starting it up to ensure all blockchain parameters are correctly
set:

```shell
$ therm init genesis.json
```

#### Creating the rendezvous point (DEV ONLY)

Bootnodes jumpstart the network by allowing nodes to quickly connect and find other peers.

```shell
$ bootnode --genkey=boot.key
$ bootnode --nodekey=boot.key
```

Bootnodes will display an `enode` URL that other nodes can use to connect to it and exchange peer information. Make sure to
replace the displayed IP address information (most probably `[::]`) with your externally
accessible IP to get the actual `enode` URL.

_Note: You could also use a full-fledged `therm` node as a bootnode, but it's the less
recommended way._

#### Start up a node

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

#### Running a private miner

To start a `therm` instance for mining, run it with all your usual flags, extended by:

```shell
$ therm <usual-flags> --mine --miner.threads=1 --miner.etherbase=0x0000000000000000000000000000000000000000
```

Which will start mining blocks and transactions on a single CPU thread, crediting all
proceedings to the account specified by `--miner.etherbase`. You can further tune the mining
by changing the default gas limit blocks converge to (`--miner.targetgaslimit`) and the price
transactions are accepted at (`--miner.gasprice`).

### DEV TESTNET GUIDE

#### First create datadirs and account:

```shell
$ mkdir boot1 node1 node2 node3
$ therm --datadir node3 account new
```

#### Copy the account addrs into the genesis.json alloc. Init datadirs

```shell
$ therm --datadir boot1 init genesis.json
$ therm --datadir node1 init genesis.json
$ therm --datadir node2 init genesis.json
$ therm --datadir node3 init genesis.json
```

#### Boot node:

```shell
$ bootnode --genkey=boot.key
$ bootnode --nodekey=boot.key -addr :30305
```

Copy the enode-url

Now create 3 different nodes in different terminals

#### Node with javascript console and account:

```shell
$ therm --datadir node1 --port 30306 --bootnodes <enode-url> --unlock <0xADDRESS> --password node1/password.txt --authrpc.port 8551
```

#### Node with HTTP Access:

```shell
$ therm --datadir node2 --port 30307 --bootnodes <enode-url>  --http --http.addr "localhost" --http.port 8545 --http.api "eth,web3,net" --http.corsdomain "*"
```

#### Mining Node:

```shell
$ therm --datadir node3 --port 30308 --bootnodes <enode-url>  --mine --miner.threads=1 --miner.etherbase=<0xADDRESS>
```

#### Javascript console commands

```shell
> eth.getBalance(eth.accounts[0])
> eth.sendTransaction({
  to: '0x00',
  from: eth.accounts[0],
  value: 25000
});
```

```shell
$ rm -rf boot1 node1 node2 node3 boot.key
```
