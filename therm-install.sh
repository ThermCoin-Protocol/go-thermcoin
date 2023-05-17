#!/bin/bash

# Step 1: Build the project
# make all

# # Step 2: Move binaries to /usr/local/bin
# sudo mv ./build/bin/* /usr/local/bin/

# Step 3: Set up a private network

# Create node directories
mkdir node1 node2
touch node1/password.txt node2/password.txt

# Set the passwords
PASSWORD1="node1password"
PASSWORD2="node2password"

# Save the passwords to files
echo $PASSWORD1 > node1/password.txt
echo $PASSWORD2 > node2/password.txt

# Create new accounts
echo 'Creating account for Node 1'
therm --datadir node1 account new --password node1/password.txt
echo 'Creating account for Node 2'
therm --datadir node2 account new --password node2/password.txt

# Get the address of the new accounts
ADDR1=$(ls node1/keystore/ | grep -oE '0x[a-fA-F0-9]{40}')
ADDR2=$(ls node2/keystore/ | grep -oE '0x[a-fA-F0-9]{40}')

echo "Node 1 address: $ADDR1"
echo "Node 2 address: $ADDR2"
echo "Node 1 address: $ADDR1"
echo "Node 2 address: $ADDR2"

# Initialize all nodes with the genesis block
therm init --datadir node1 genesis.json
therm init --datadir node2 genesis.json

# Start a new bootnode
BOOTNODE_KEY_FILE=boot.key
bootnode --genkey=$BOOTNODE_KEY_FILE
BOOTNODE_ID=$(bootnode --writeaddress --nodekey=$BOOTNODE_KEY_FILE)

# Run bootnode in the background
bootnode --nodekey=$BOOTNODE_KEY_FILE &
BOOTNODE_PID=$!

echo "Bootnode is running with pid: $BOOTNODE_PID, id: $BOOTNODE_ID"

# Start two miner nodes
therm --datadir node1 --networkid 4221 --port 30303 --bootnodes enode://$BOOTNODE_ID@127.0.0.1:30301 --mine --miner.etherbase=$ADDR1 &
NODE1_PID=$!

therm --datadir node2 --networkid 4221 --port 30304 --bootnodes enode://$BOOTNODE_ID@127.0.0.1:30301 --mine --miner.etherbase=$ADDR2 &
NODE2_PID=$!

echo "Node 1 is running with pid: $NODE1_PID"
echo "Node 2 is running with pid: $NODE2_PID"