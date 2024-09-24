{ config, lib, pkgs, ... }:

{
    imports = [
        ./pkg
        ./sys
        ./wms
    ];

    options = {
        theme = lib.mkOption {
            type = lib.types.attrs;
            description = "base16 colors";
            default = (import ../theme/dark);
        };
    };
}
