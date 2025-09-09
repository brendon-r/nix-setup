
update: 
	sudo nix flake update
	
nixos:
	sudo nixos-rebuild switch --flake . 

# Possibly not needed since I won't develop Omarchy
#nixos-oma:
#	sudo nixos-rebuild switch --flake .# --override-input omarchy path:/home/brendon/Developer/omarchy-nix

gc: 
	# run garbage collection
	nix-collect-garbage --delete-older-than 5d

fmt:
	# format the nix files in this repo
	nix fmt ./
