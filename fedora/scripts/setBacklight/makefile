all:
	mkdir -p ~/Programs
	cp setBacklight.sh ~/Programs/setBacklight.sh
	sudo dnf install brightnessctl
	chmod u+x ~/Programs/setBacklight.sh
	# sudo visudo
	# anton ALL = NOPASSWD: /usr/bin/brightnessctl
	# custom keyboard shortcut ex: Ctrl+Alt+b
clean: 
	rm ~/Programs/setBacklight.sh
	sudo remove purge brightnessctl 
