{ inputs, ... }:

inputs.nixpkgs.lib.nixosSystem rec { 
    system = "x86_64-linux";
    specialArgs = {
        pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
        pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
        };
    };
    modules = [ 
        ../../modules 
        inputs.home-manager.nixosModules.home-manager
        {
            networking.enable = true;
            networking.hostName = "box";
            
            zen.kernel.enable = true;
            nixpkgs.hostPlatform = "x86_64-linux";
            
            boot.initrd.kernelModules = [ "amdgpu" ];
            boot.initrd.availableKernelModules = [ 
                "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"
            ];
            
            boot.kernelModules = [ "kvm-amd" ];
            boot.blacklistedKernelModules = [ "ucsi_ccg" ];
                        
            services.xserver.videoDrivers = [ "amdgpu" ];
            services.xserver.deviceSection = ''Option "TearFree" "true"'';

            hardware.cpu.amd.updateMicrocode = true;
            hardware.enableRedistributableFirmware = true;
            
            fileSystems."/" = { 
                device = "/dev/disk/by-label/nixos";
                fsType = "btrfs";
                options = [ "subvol=@" ];
            };
                
            fileSystems."/boot" = {
                device = "/dev/disk/by-label/boot";
                fsType = "vfat";
            };
        
            fileSystems."/mnt/hdd" = {
                device = "/dev/disk/by-label/cute";
                fsType = "ntfs-3g";
                options = [ "rw" "uid=1000"];
            };
            
            theme = (import ../../theme/dark);
        
            # avail wms:
            # 2bwm, cwm, windowchef
            wm = "windowchef";
            gui.enable = true;
            
            xutils.enable = true;
            lemonbar.enable = true;
            _9menu.enable = true;
            dzen.enable = true;
            dmenu.enable = true;
        
            alacritty.enable = true;
            micro.enable = true;
            fetch.enable = true;
            git.enable = true;
            zip.enable = true;
            bc.enable = true;
            
            plan9port.enable = true;
        
            firefox.enable = true;
            keepass.enable = true;
            pcmanfm.enable = true;
            discord.enable = true;
            torrent.enable = true;
            gimp.enable = true;
        
            gaming = {
                enable = true;
                lact.enable = true;
                steam.enable = true;
                osu.enable = true;
                minecraft.enable = true;
                openrct2.enable = true;
                protonup.enable = true;
                lutris.enable = false;
            };
        }
    ];
}
