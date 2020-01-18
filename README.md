# Plug systemd Example

This is example of Plug+Cowboy application that integrates with systemd features
like:

- Socket activation via some socket hopping due to
  [ERL-1138](https://bugs.erlang.org/browse/ERL-1138), however it listens on
  super-user port (80) while VM runs as unprivileged user `www-data`
- Journal logging, which allows for structured logging and multiline logs
- Watchdog integration which allows for triggering restarts from within
  application
- Status notifications where application reports readiness when it is really
  ready and will inform when the application is in process of shutting down

ASCIICinema recording of shutdown handling:

[![asciicast](https://asciinema.org/a/jqTbUdgFkc7206vFK4AScqq5p.svg)](https://asciinema.org/a/jqTbUdgFkc7206vFK4AScqq5p)

## Installation

This project require Elixir 1.10+ for `logger` integration.

1. Clone repo.
2. Run `make` (you will need to enter `sudo` password for installation of
   systemd units).
3. Application will be available at <http://localhost/>.

## Endpoints

- `/` - return OS PID of VM
- `/slow` - wait 5s before sending response
- `/hello` - respond with string `world`
- `/stop` - trigger Watchdog
- `/reload` - simulate application reload that last 10s
