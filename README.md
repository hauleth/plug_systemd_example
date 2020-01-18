# Plug systemd Example

ASCIICinema recording of shutdown handling:

[![asciicast](https://asciinema.org/a/jqTbUdgFkc7206vFK4AScqq5p.svg)](https://asciinema.org/a/jqTbUdgFkc7206vFK4AScqq5p)

## Installation

This project require Elixir 1.10+ for `logger` integration.

1. Clone repo.
2. Run `make` (you will need to enter `sudo` password for installation of
   systemd units).
3. Application will be available at <http://localhost:4000/>.

## Endpoints

- `/` - return OS PID of VM
- `/slow` - wait 5s before sending response
- `/hello` - respond with string `world`
- `/stop` - trigger Watchdog
- `/reload` - simulate application reload that last 10s
