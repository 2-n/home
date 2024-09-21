{ config, lib, pkgs, modulesPath, ... }:

{
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.kernelPackages = pkgs.linuxPackages_zen;

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelModules = [ "kvm-amd" ];

    boot.tmp.cleanOnBoot = true;
  
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    fileSystems."/" = { 
        device = "/dev/disk/by-uuid/651a31fd-f525-435e-8d34-a8d18381e48d";
        fsType = "btrfs";
        options = [ "subvol=@" ];
    };
        
    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/76A0-FB0D";
        fsType = "vfat";
    };
        
    fileSystems."/mnt/hdd" = {
        device = "/dev/disk/by-uuid/E62CF22F2CF1FA7F";
        fsType = "ntfs-3g";
        options = [ "rw" "uid=1000"];
    };

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
