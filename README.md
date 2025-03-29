# byedpictl
Experimental utility for user-friendly DPI desync on Linux. Supports both
command-line and graphical interfaces.

Uses [byedpi](https://github.com/hufrea/byedpi) for processing and
[hev-socks5-tunnel](https://github.com/heiher/hev-socks5-tunnel) for network
tunneling.

Still in the progress of early development, so there are no stable releases
yet.


## Install
1. Download the
   [latest archive](https://github.com/maximilionus/byedpictl/archive/refs/heads/master.zip)
   and unpack it.
2. In the unpacked directory run:
   ```sh
   $ sudo ./make.sh install
   ```

## Remove
1. Use the same `make.sh` script to remove the project:
   ```sh
   $ sudo ./make.sh remove
   ```

## Update
1. Be sure to uninstall the project using the same `make.sh` script that was
   used for initial installation.
2. Follow the "Install" section above with new version.

## Usage
### Command Line
Get all the available information about utility commands usage with:
```sh
$ byedpictl help
```

#### Tunneling
Control the background tunneling.

- Start and stop the tunneling with:
  ```sh
  # Start
  $ byedpictl tun start

  # Stop
  $ byedpictl tun stop
  ```

- Get status of background tunneling with:
  ```sh
  $ byedpictl tun status
  ```


### Graphical Interface
This project also supports a GUI mode (based on Zenity) for some basic
interactions, like starting/stopping the tunneling and so on. A desktop entry
will be created on initial project installation and can be accessed on any
XDG-compliant desktop environment to start the graphical menu.

To run the graphical interface on the target system, `zenity` must be
installed. Most distributions provide it out of the box.


## Configuration
DPI desync (bypass) approaches can be modified by altering the contents of
`/etc/byedpictl/desync.conf` file.


## Debugging
Logs are available in `/var/log/byedpictl` directory.


## Possible issues

### Tunnel after suspend
Tunneling **will** break after waking machine from suspend (sleep) state. To
restore the functionality you should restart the tunnel with the command below:

```sh
$ byedpictl tun restart
```
