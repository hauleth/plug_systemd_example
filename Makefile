watchdog: systemd
	sudo systemctl enable example-watchdog.service
	sudo systemctl start example-watchdog.service

socket: systemd
	sudo systemctl enable example-activation.socket
	sudo systemctl start example-activation.socket

systemd: release
	@mkdir -p /usr/local/lib/systemd/system
	sudo cp systemd/* /usr/local/lib/systemd/system
	sudo systemctl daemon-reload
	-sudo systemctl stop example-activation.socket
	-sudo systemctl stop example-activation.service
	-sudo systemctl stop example-watchdog.service

release:
	MIX_ENV=prod mix do deps.get, release --overwrite


.PHONY: release systemd
