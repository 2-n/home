{ lib
, config
, pkgs
, ... 
}:

{
    boot = {
        kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
        kernelModules = [ "kvm-amd" ];
        blacklistedKernelModules = [ "ucsi_ccg" ];
        initrd.kernelModules = [ "amdgpu" ];
        initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
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
        options = [ "rw" ];
    };

    swapDevices = [{
        device = "/swap";
        size = 16 * 1024; # 0.5x ram
    }];

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

    hardware.cpu.amd.updateMicrocode = true;
    hardware.amdgpu.overdrive.enable = true;
    hardware.enableRedistributableFirmware = true;
    powerManagement.cpuFreqGovernor = "performance";
    
    nixpkgs.hostPlatform = "x86_64-linux";
}
