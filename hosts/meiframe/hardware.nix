{ lib
, config
, pkgs
, ... 
}:

{
    boot = {
        kernelParams = [ "quiet" ];
        kernelModules = [ "kvm-amd" ];
        initrd.kernelModules = [ "amdgpu" ];
        initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    };
    
    fileSystems."/" = { 
        device = "/dev/disk/by-uuid/6d24fce4-21af-4309-908e-63f01fc8c216";
        fsType = "ext4";
    };

    fileSystems."/boot" = { 
        device = "/dev/disk/by-uuid/66A3-08E5";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
    };

    fileSystems."/mnt/hdd" = {
        device = "/dev/disk/by-uuid/E62CF22F2CF1FA7F";
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

    powerManagement.cpuFreqGovernor = "performance";
    hardware.cpu.amd.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;
    hardware.amdgpu.overdrive.enable = true;
    hardware.amdgpu.overdrive.ppfeaturemask = "0xffffffff";
    
    nixpkgs.hostPlatform = "x86_64-linux";
}
