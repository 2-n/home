{ inputs, config, lib, pkgs, ... }:

{ 
    imports = [ ../../modules inputs.home-manager.nixosModules.default ];
    
    net.enable = true;
    networking.hostName = "box";

    nixpkgs.hostPlatform = "x86_64-linux";
    
    boot.kernelPackages = pkgs.linuxPackages_zen;    

    boot.initrd.availableKernelModules = [ 
        "nvme"    "xhci_pci"
        "ahci" "usb_storage"
        "usbhid"    "sd_mod"
    ];
    
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelModules = [ "kvm-amd" ];
    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware.enableRedistributableFirmware = true;
    hardware.cpu.amd.updateMicrocode = true;
    
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
    
    gui.enable = true;
    audio.enable = true;
    
    theme = (import ../../theme/dark);

    cwm.enable = true;
    
    xutils.enable = true;
    lemonbar.enable = true;
    ninemenu.enable = true;
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
