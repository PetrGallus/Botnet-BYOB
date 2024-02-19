# 📃 Documentation

## Web GUI

### Dashboard

A control panel for your C2 server with a point-and-click interface for executing post-exploitation modules. The control panel includes an interactive map of client machines and a dashboard which allows efficient, intuitive administration of client machines.

[![dashboard\_preview](https://github.com/malwaredllc/byob/raw/master/web-gui/buildyourownbotnet/assets/images/previews/preview-dashboard.png)](https://github.com/malwaredllc/byob/blob/master/web-gui/buildyourownbotnet/assets/images/previews/preview-dashboard.png)

### Payload Generator

The payload generator uses black magic involving Docker containers & Wine servers to compile executable payloads for any platform/architecture you select. These payloads spawn reverse TCP shells with communication over the network encrypted via AES-256 after generating a secure symmetric key using the [Diffie-Hellman IKE](https://tools.ietf.org/html/rfc2409).

[![payloads\_preview](https://github.com/malwaredllc/byob/raw/master/web-gui/buildyourownbotnet/assets/images/previews/preview-payloads2.png)](https://github.com/malwaredllc/byob/blob/master/web-gui/buildyourownbotnet/assets/images/previews/preview-payloads2.png)

### Terminal Emulator

The web app includes an in-browser terminal emulator so you can still have direct shell access even when using the web GUI.

[![terminal\_preview](https://github.com/malwaredllc/byob/raw/master/web-gui/buildyourownbotnet/assets/images/previews/preview-shell.png)](https://github.com/malwaredllc/byob/blob/master/web-gui/buildyourownbotnet/assets/images/previews/preview-shell.png)

## Console Application

### Client

[![client](https://camo.githubusercontent.com/574ffb83d545219304764027c73c4825fc35606b9ac28094e315906746ffa1b2/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f62796f622d636c69656e742d626c75652e737667)](https://github.com/malwaredllc/byob/blob/master/byob/payloads.py)

_Generate fully-undetectable clients with staged payloads, remote imports, and unlimited post-exploitation modules_

1. **Remote Imports**: remotely import third-party packages from the server without writing them to the disk or downloading/installing them
2. **Nothing Written To The Disk**: clients never write anything to the disk - not even temporary files (zero IO system calls are made) because remote imports allow arbitrary code to be dynamically loaded into memory and directly imported into the currently running process
3. **Zero Dependencies (Not Even Python Itself)**: client runs with just the python standard library, remotely imports any non-standard packages/modules from the server, and can be compiled with a standalone python interpreter into a portable binary executable formatted for any platform/architecture, allowing it to run on anything, even when Python itself is missing on the target host
4. **Add New Features With Just 1 Click**: any python script, module, or package you copy to the `./byob/modules/` directory automatically becomes remotely importable & directly usable by every client while your command & control server is running
5. **Write Your Own Modules**: a basic module template is provided in `./byob/modules/` directory to make writing your own modules a straight-forward, hassle-free process
6. **Run Unlimited Modules Without Bloating File Size**: use remote imports to add unlimited features without adding a single byte to the client's file size
7. **Fully Updatable**: each client will periodically check the server for new content available for remote import, and will dynamically update its in-memory resources if anything has been added/removed
8. **Platform Independent**: everything is written in Python (a platform-agnostic language) and the clients generated can optionally be compiled into a portable executable (_Windows_) or bundled into a standalone application (_macOS_)
9. **Bypass Firewalls**: clients connect to the command & control server via reverse TCP connections, which will bypass most firewalls because the default filter configurations primarily block incoming connections
10. **Counter-Measure Against Antivirus**: avoids being analyzed by antivirus by blocking processes with names of known antivirus products from spawning
11. **Encrypt Payloads To Prevent Analysis**: the main client payload is encrypted with a random 256-bit key which exists solely in the payload stager which is generated along with it
12. **Prevent Reverse-Engineering**: by default, clients will abort execution if a virtual machine or sandbox is detected

### Modules

[![modules](https://camo.githubusercontent.com/fc66ac7aceb84eed550a0172928090582f7e4871ffb2c7a642c6ae89d1961efc/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f62796f622d6d6f64756c65732d626c75652e737667)](https://github.com/malwaredllc/byob/blob/master/byob/modules)

_Post-exploitation modules that are remotely importable by clients_

1. **Persistence** (`byob.modules.persistence`): establish persistence on the host machine using 5 different methods
2. **Packet Sniffer** (`byob.modules.packetsniffer`): run a packet sniffer on the host network & upload .pcap file
3. **Escalate Privileges** (`byob.modules.escalate`): attempt UAC bypass to gain unauthorized administrator privileges
4. **Port Scanner** (`byob.modules.portscanner`): scan the local network for other online devices & open ports
5. **Keylogger** (`byob.modules.keylogger`): logs the user’s keystrokes & the window name entered
6. **Screenshot** (`byob.modules.screenshot`): take a screenshot of current user’s desktop
7. **Outlook** (`byob.modules.outlook`): read/search/upload emails from the local Outlook client
8. **Process Control** (`byob.modules.process`): list/search/kill/monitor currently running processes on the host
9. **iCloud** (`byob.modules.icloud`): check for logged in iCloud account on macOS
10. **Miner** (`byob.core.miner`): mine Monero in the background using the built-in miner or XMRig

### Server

[![server](https://camo.githubusercontent.com/6f9c36c88120175f8b947df3cb3b535ab238712f362f73bd3f4ea35832db9a0a/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f62796f622d7365727665722d626c75652e737667)](https://github.com/malwaredllc/byob/blob/master/byob/server.py)

_Command & control server with persistent database and console_

1. **Console-Based User-Interface**: streamlined console interface for controlling client host machines remotely via reverse TCP shells which provide direct terminal access to the client host machines
2. **Persistent SQLite Database**: lightweight database that stores identifying information about client host machines, allowing reverse TCP shell sessions to persist through disconnections of arbitrary duration and enabling long-term reconnaissance
3. **Client-Server Architecture**: all python packages/modules installed locally are automatically made available for clients to remotely import without writing them to the disk of the target machines, allowing clients to use modules which require packages not installed on the target machines

### Core

[![core](https://camo.githubusercontent.com/538a7ea1f0ae8a7f9a96f8f305bc81735926c3df2a82ece348d8c62b302d44bc/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f62796f622d636f72652d626c75652e737667)](https://github.com/malwaredllc/byob/blob/master/byob/core)

_Core framework modules used by the generator and the server_

1. **Utilities** (`byob.core.util`): miscellaneous utility functions that are used by many modules
2. **Security** (`byob.core.security`): Diffie-Hellman IKE & 3 encryption modes (AES-256-OCB, AES-256-CBC, XOR-128)
3. **Loaders** (`byob.core.loaders`): remotely import any package/module/scripts from the server
4. **Payloads** (`byob.core.payloads`): reverse TCP shell designed to remotely import dependencies, packages & modules
5. **Stagers** (`byob.core.stagers`): generate unique payload stagers to prevent analysis & detection
6. **Generators** (`byob.core.generators`): functions which all dynamically generate code for the client generator
7. **DAO** (`byob.core.dao`): handles interaction between command & control server and the SQLite database
8. **Handler** (`byob.core.handler`): HTTP POST request handler for remote file uploads to the server\
