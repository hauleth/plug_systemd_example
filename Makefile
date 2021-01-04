SYSTEMD_TARGET ?= /usr/local/lib/systemd/system

socket: systemd uninstall install
	sudo systemctl start example.target

test: release
	systemd-socket-activate -l 8080 _build/prod/rel/plug_systemd_example/bin/plug_systemd_example start

systemd:
	@sudo mkdir -p /usr/local/lib/systemd/system
	sudo cp -f systemd/* /usr/local/lib/systemd/system
	sudo chmod 644 /usr/local/lib/systemd/system/*
	sudo systemctl daemon-reload
	-sudo systemctl stop example-activation.socket
	-sudo systemctl stop example-activation.service
	-sudo systemctl stop example.socket
	-sudo systemctl stop example.service
	-sudo systemctl stop example.target


release:
	MIX_ENV=prod mix do deps.get, release --overwrite

uninstall:
	-sudo rm -rf /opt/example

install: release
	sudo cp -r _build/prod/rel/plug_systemd_example /opt/example
	sudo chown -R root:root /opt/example
	sudo find /opt/example -executable -exec chmod +x '{}' +

.PHONY: release systemd
