{ lib
, config
, pkgs-unstable
, ...
}:

{
  config = lib.mkIf (config.programs.micro.enable) {
    programs.micro = {
      package = pkgs-unstable.micro;
      settings = {
        autosu = true;
        sucmd = "doas";
        mkparents = true;
        saveundo = true;
        multiopen = "tab";
        colorcolumn = 80;
        tabsize = 2;
        tabstospaces = true;
        tabmovement = true;
        rmtrailingws = true;
        matchbrace = true;
        matchbracestyle = "highlight";
        infobar = false;
        ruler = false;
        showchars = "ispace=|,itab=>";
        statusformatl = "$(modified)";
        statusformatr = "$(filename)";
        colorscheme = "custom-simple";
      };
    };

    home.file.".config/micro/bindings.json".text = ''
      {
        "F1": "command:setlocal filetype nix",
        "F2": "command:setlocal filetype shell",
        "F3": "None",
        "F4": "None",
      }
    '';

    home.file.".config/micro/colorschemes/custom-simple.micro".text = ''
      # default "simple" colorscheme
      # with indent-char edited
      color-link comment "blue"
      color-link constant "red"
      color-link identifier "cyan"
      color-link statement "yellow"
      color-link symbol "yellow"
      color-link preproc "magenta"
      color-link type "green"
      color-link special "magenta"
      color-link ignore "default"
      color-link error ",brightred"
      color-link todo ",brightyellow"
      color-link hlsearch "black,yellow"
      color-link statusline "black,white"
      color-link indent-char "white"
      color-link line-number "yellow"
      color-link current-line-number "red"
      color-link diff-added "green"
      color-link diff-modified "yellow"
      color-link diff-deleted "red"
      color-link gutter-error ",red"
      color-link gutter-warning "red"
      #Cursor line causes readability issues. Disabled for now.
      #color-link cursor-line "white,black"
      color-link color-column "white"
      #No extended types. (bool in C)
      color-link type.extended "default"
      #No bracket highlighting.
      color-link symbol.brackets "default"
      #Color shebangs the comment color
      color-link preproc.shebang "comment"
      color-link match-brace ",magenta"
      color-link tab-error "brightred"
      color-link trailingws "brightred"
    '';
  };
}
