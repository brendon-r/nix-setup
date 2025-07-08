
update: 
	sudo nix flake update
	
nixos:
	sudo nixos-rebuild switch --flake . --impure

nixos-oma:
	sudo nixos-rebuild switch --flake .# --override-input omarchy path:/home/henry/Developer/omarchy-nix

nixos-homelab:
	nixos-rebuild switch --flake .#homelab --target-host henry@192.168.1.121 --use-remote-sudo

macos:
	sudo darwin-rebuild switch --flake .#

gc: 
	# run garbage collection
	nix-collect-garbage --delete-older-than 5d

fmt:
	# format the nix files in this repo
	nix fmt ./
