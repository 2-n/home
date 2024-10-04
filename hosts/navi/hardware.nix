{ config, lib, pkgs, ... }:

{
    boot = {
        initrd = {
            kernelModules = [ "amdgpu" ];
            availableKernelModules = [
                "nvme"
                "xhci_pci"
                "ahci"
                "usb_storage"
                "usbhid"
                "sd_mod"
            ];
        };
        kernelModules = [ "kvm-amd" ];
        blacklistedKernelModules = [ "ucsi_ccg" ];
        kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
    };
    
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

    hardware = {
        opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
        };
        cpu.amd.updateMicrocode = true;
        enableRedistributableFirmware = true;
    };
    powerManagement.cpuFreqGovernor = "performance";
    
    nixpkgs.hostPlatform = "x86_64-linux";
}
