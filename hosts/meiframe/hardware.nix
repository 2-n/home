{ lib
, config
, pkgs
, ...
}:

{
  boot = {
    kernelParams = [ "quiet" "splash" "split_lock_detect=off" ];
    kernelModules = [ "kvm-amd" "ntsync" ];
    initrd.kernelModules = [ "amdgpu" ];
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/54f1d5b5-479a-42a5-8041-1366fff917ce";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E90A-6232";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" "noatime" ];
  };

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/E62CF22F2CF1FA7F";
    fsType = "ntfs3";
    options = [ "uid=1000" "noatime" "nofail" ];
  };

  fileSystems."/mnt/nvme" = {
    device = "/dev/disk/by-uuid/d9a8df28-5bfb-4ae3-aa91-4ba98252ceb7";
    fsType = "ext4";
    options = [ "noatime" "nofail" ];
  };

  swapDevices = [{
    device = "/swap";
    size = 16 * 1024;
  }];

  services.fstrim.enable = true;

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  powerManagement.cpuFreqGovernor = "performance";

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  hardware.amdgpu.overdrive.enable = true;
  hardware.amdgpu.overdrive.ppfeaturemask = "0xffffffff";

  nixpkgs.hostPlatform = "x86_64-linux";
}
