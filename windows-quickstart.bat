@echo off

REM Step 1: Create node directories
md myNode
echo.>myNode\password.txt

REM Step 3: Set the passwords
set PASSWORD=password

REM Step 4: Save the passwords to files
echo %PASSWORD% > myNode\password.txt

REM Step 5: Create new account
echo Creating account for Node
therm --datadir myNode account new --password myNode\password.txt

REM Step 6: Get the address of the node account
for /R myNode\keystore\ %%G in (*.*) do set "ADDR=%%~nG"
echo Node 1 address: %ADDR%

REM Step 7: Initialize node with the genesis block
therm init --datadir myNode genesis.json

set BOOTNODE_ID=enode://9f2c7a4a04fa4c4d72fa376c0e34d7979e6b44d0053fd235f8efc9d5c13f61867795fda32b6037df70e28f7959065e45fff999a67beef5c46258b4ae075cb929

REM Start node
start cmd.exe /k "therm --datadir myNode --networkid 4221 --port 30303 --bootnodes %BOOTNODE_ID%@127.0.0.1:30301 --mine --miner.etherbase=%ADDR% console"
