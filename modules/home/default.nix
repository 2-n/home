{ config, lib, pkgs, ... }:

{
    imports = [
        ./pkg
        ./wms
    ];

    options = {
        theme = {
            colors = lib.mkOption {
                type = lib.types.attrs;
                description = "set base16 colors";
                default = (import ../../theme/dark);
            };
            font = {
                name = lib.mkOption {
                    type = lib.types.str;
                    description = "set font name";
                    default = "DejaVu Sans Mono";
                };
                size = lib.mkOption {
                    type = lib.types.int;
                    description = "set font size";
                    default = 12;
                };
            };
        };
    };
}
