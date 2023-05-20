#!/bin/bash

# # Step 1: Move binaries to /usr/local/bin
FILE=./usr/local/bin/therm
if [ -f "$FILE" ]; then
    rm -rf /usr/local/bin/therm
    sudo mv ./therm /usr/local/bin/
else 
    sudo mv ./therm /usr/local/bin/
fi

# # Step 2: Create node directories
FILE=./myNode
if [ -f "$FILE" ]; then
    rm -rf myNode
    mkdir myNode
    touch myNode/password.txt
else 
    mkdir myNode
    touch myNode/password.txt
fi

# # Step 3: Set the passwords
PASSWORD="password"

# # Step 4: Save the passwords to files
echo $PASSWORD > myNode/password.txt

# # Step 5: Create new account
echo 'Creating account for Node'
therm --datadir myNode account new --password myNode/password.txt

# # Step 6: Get the address of the node account
ADDR=$(ls myNode/keystore/ | grep -oE '0x[a-fA-F0-9]{40}')

echo "Node 1 address: $ADDR"

# # Step 7: Initialize node with the genesis block
therm init --datadir myNode genesis.json

BOOTNODE_ID=enode://9f2c7a4a04fa4c4d72fa376c0e34d7979e6b44d0053fd235f8efc9d5c13f61867795fda32b6037df70e28f7959065e45fff999a67beef5c46258b4ae075cb929
IP_ADDRESS=76.235.135.8

# # Step 8: Start node
therm --datadir myNode --networkid 4221 --port 30303 --bootnodes $BOOTNODE_ID@$IP_ADDRESS:30301 --mine --miner.etherbase=$ADDR