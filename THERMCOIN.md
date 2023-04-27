## Go Thermcoin

Official Golang implementation of the Thermcoin protocol.

## Building the source

Building `therm` requires both a Go (version 1.16 or later) and a C compiler. You can install
them using your favourite package manager. Once the dependencies are installed, run

```shell
make therm
```

or, to build the full suite of utilities:

```shell
make all
```

## Running `therm`

### Hardware Requirements

Minimum:

- CPU with 2+ cores
- 4GB RAM
- 1TB free storage space to sync the Mainnet
- 8 MBit/sec download Internet service

Recommended:

- Fast CPU with 4+ cores
- 16GB+ RAM
- High Performance SSD with at least 1TB free space
- 25+ MBit/sec download Internet service

### Full node on the main Thermcoin network

By far the most common scenario is people wanting to simply interact with the Thermcoin
network: create accounts; transfer funds; deploy and interact with contracts. For this
particular use-case the user doesn't care about years-old historical data, so we can
sync quickly to the current state of the network. To do so:

```shell
$ therm console
```

This command will:

- Start `therm` in snap sync mode (default, can be changed with the `--syncmode` flag),
  causing it to download more data in exchange for avoiding processing the entire history
  of the Thermcoin network, which is very CPU intensive.
- Start up `therm`'s built-in interactive JavaScript console through which you can interact using [`web3` methods](https://github.com/ChainSafe/web3.js/blob/0.20.7/DOCUMENTATION.md)

### Configuration

As an alternative to passing the numerous flags to the `therm` binary, you can also pass a
configuration file via:

```shell
$ therm --config /path/to/your_config.toml
```

To get an idea how the file should look like you can use the `dumpconfig` subcommand to
export your existing configuration:

```shell
$ therm --your-favourite-flags dumpconfig
```

_Note: This works only with `therm` v1.6.0 and above._

### Programmatically interfacing `therm` nodes

As a developer, sooner rather than later you'll want to start interacting with `therm` and the
Thermcoin network via your own programs and not manually through the console. To aid
this, `therm` has built-in support for a JSON-RPC based APIs.
These can be exposed via HTTP, WebSockets and IPC (UNIX sockets on UNIX based
platforms, and named pipes on Windows).

The IPC interface is enabled by default and exposes all the APIs supported by `therm`,
whereas the HTTP and WS interfaces need to manually be enabled and only expose a
subset of APIs due to security reasons. These can be turned on/off and configured as
you'd expect.

HTTP based JSON-RPC API options:

- `--http` Enable the HTTP-RPC server
- `--http.addr` HTTP-RPC server listening interface (default: `localhost`)
- `--http.port` HTTP-RPC server listening port (default: `8545`)
- `--http.api` API's offered over the HTTP-RPC interface (default: `eth,net,web3`)
- `--http.corsdomain` Comma separated list of domains from which to accept cross origin requests (browser enforced)
- `--ws` Enable the WS-RPC server
- `--ws.addr` WS-RPC server listening interface (default: `localhost`)
- `--ws.port` WS-RPC server listening port (default: `8546`)
- `--ws.api` API's offered over the WS-RPC interface (default: `eth,net,web3`)
- `--ws.origins` Origins from which to accept websockets requests
- `--ipcdisable` Disable the IPC-RPC server
- `--ipcapi` API's offered over the IPC-RPC interface (default: `admin,debug,eth,miner,net,personal,txpool,web3`)
- `--ipcpath` Filename for IPC socket/pipe within the datadir (explicit paths escape it)

You'll need to use your own programming environments' capabilities (libraries, tools, etc) to
connect via HTTP, WS or IPC to a `therm` node configured with the above flags and you'll
need to speak [JSON-RPC](https://www.jsonrpc.org/specification) on all transports. You
can reuse the same connection for multiple requests!

**Note: Please understand the security implications of opening up an HTTP/WS based
transport before doing so! Hackers on the internet are actively trying to subvert
Thermcoin nodes with exposed APIs! Further, all browser tabs can access locally
running web servers, so malicious web pages could try to subvert locally available
APIs!**

## License

The go-Thermcoin library (i.e. all code outside of the `cmd` directory) is licensed under the
[GNU Lesser General Public License v3.0](https://www.gnu.org/licenses/lgpl-3.0.en.html),
also included in our repository in the `COPYING.LESSER` file.

The go-Thermcoin binaries (i.e. all code inside of the `cmd` directory) is licensed under the
[GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html), also
included in our repository in the `COPYING` file.
