SYSTEMD_TARGET ?= /usr/local/lib/systemd/system

socket: install systemd
	sudo systemctl start example.target

systemd:
	@mkdir -p /usr/local/lib/systemd/system
	sudo cp systemd/* /usr/local/lib/systemd/system
	sudo chmod 644 /usr/local/lib/systemd/system/*
	sudo systemctl daemon-reload
	-sudo systemctl stop example-activation.socket
	-sudo systemctl stop example-activation.service
	-sudo systemctl stop example-application.service
	-sudo systemctl stop example-application.socket
	-sudo systemctl stop example.target


release:
	MIX_ENV=prod mix do deps.get, release --overwrite

install: release
	sudo cp -r _build/prod/rel/plug_systemd_example /opt/example
	sudo chown -R root:root /opt/example
	sudo find /opt/example -executable -exec chmod +x '{}' +

.PHONY: release systemd
