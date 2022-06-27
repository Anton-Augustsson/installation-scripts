all:
	mkdir -p ~/Programs
	cp setBacklight.sh ~/Programs/setBacklight.sh
	sudo apt install brightnessctl
	chmod u+x ~/Programs/setBacklight.sh
	# sudo visudo
	# anton ALL = NOPASSWD: /usr/bin/brightnessctl
clean: 
	rm ~/Programs/setBacklight.sh
	sudo apt purge brightnessctl 
