#!/bin/bash

# Start bootnode
bootnode --genkey=boot.key
bootnode --nodekey=boot.key --writeaddress > bootnode.log
BOOTNODE_ADDRESS=$(cat bootnode.log)
echo "Bootnode address: ${BOOTNODE_ADDRESS}"
bootnode --nodekey=boot.key &

# Initialize and start the mining member node
geth --datadir <path_to_datadir>/miner --keystore <path_to_datadir>/miner/keystore init <path_to_genesis.json>
geth --datadir <path_to_datadir>/miner --keystore <path_to_datadir>/miner/keystore --mine --miner.threads 1 --bootnodes "enode://${BOOTNODE_ADDRESS}" &

# Initialize and start the non-mining member node with JavaScript console
geth --datadir <path_to_datadir>/member --keystore <path_to_datadir>/member/keystore init <path_to_genesis.json>
geth --datadir <path_to_datadir>/member --keystore <path_to_datadir>/member/keystore --bootnodes "enode://${BOOTNODE_ADDRESS}" attach &