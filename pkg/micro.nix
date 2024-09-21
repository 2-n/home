{ config, lib, pkgs, ... }:

{
	programs.micro = {
		enable = true;
		settings = {
		    autosu = true;
		    sucmd = "doas";
		    mkparents = true; 
            multiopen = "hsplit";
			matchbrace = true;
			matchbracestyle = "highlight";
			tabsize = 4;
			tabmovement = true;
			tabstospaces = true;
            infobar = false;
            basename = true;
            statusformatl = "$(filename) $(modified)";
			statusformatr = "filetype:$(opt:filetype)";
			colorscheme = "simple";
		};
	};

	home.file.".config/micro/bindings.json".text = ''
        {
            "Ctrl-t": "HSplit,command-edit:open ",
            "F1": "command:setlocal filetype nix",
            "F2": "command:setlocal filetype shell",
            "F3": "None",
            "F4": "None",
        }
	'';
}
