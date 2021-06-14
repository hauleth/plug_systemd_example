This project was merged into [`systemd` library examples][1].

---

# Plug systemd Example

This is example of Plug+Cowboy application that integrates with systemd via
[systemd](https://github.com/hauleth/erlang-systemd) library features like:

- Socket activation to listen on privileged port port (80) while VM running
  as unprivileged user `www-data`
- Journal logging, which allows for structured logging and multiline logs
- Watchdog integration which allows for triggering restarts from within
  application
- Status notifications where application reports readiness when it is really
  ready and will inform when the application is in process of shutting down

ASCIICinema recording of shutdown handling:

[![asciicast](https://asciinema.org/a/jqTbUdgFkc7206vFK4AScqq5p.svg)](https://asciinema.org/a/jqTbUdgFkc7206vFK4AScqq5p)

## Installation

This project require Elixir 1.10+ for `logger` integration and OTP 23+ for
proper socket support

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

[1]: https://github.com/hauleth/erlang-systemd/tree/master/examples/plug
