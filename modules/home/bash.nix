{ lib
, config
, ...
}:

{
  config = lib.mkIf (config.programs.bash.enable) {
    programs.bash = {
      historySize = 512;
      historyFileSize = 4096;
      historyIgnore = [ "ls" "lc" "ll" "clear" "exit" ];
      bashrcExtra = ". $HOME/.profile";
      sessionVariables = {
        PATH = "$HOME/bin:$PATH";
        EDITOR = "micro";
        VISUAL = "$EDITOR";
      };
      shellAliases = {
        e = "$EDITOR";
        c = "bc -q";
        calc = "c";
        ls = "LC_COLLATE=C ls --group-directories-first --color";
        lc = "ls -A";
        ll = "ls -lAh";
        mv = "mv -iv";
        rm = "rm -iv";
        mkdir = "mkdir -p";
      };
    };
  };
}
