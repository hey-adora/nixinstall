{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  inputs.disko.url = "github:nix-community/disko/latest";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    {
      self,
      disko,
      nixpkgs,
    }:
    {
      nixosConfigurations.b650 = nixpkgs.legacyPackages.x86_64-linux.nixos [
        ./configuration.nix
        disko.nixosModules.disko
        {
          disko.devices = {
            disk = {
              main = {
                device = "/dev/disk/by-id/some-disk-id";
                type = "disk";
                content = {
                  type = "gpt";
                  partitions = {
                    MBR = {
                      type = "EF02";
                      size = "1M";
                      priority = 1;
                    };
                    ESP = {
                      type = "EF00";
                      size = "1G";
                      content = {
                        type = "filesystem";
                        format = "vfat";
                        mountpoint = "/boot";
                        mountOptions = [ "umask=0077" ];
                      };
                    };
                    root = {
                      size = "100%";
                      content = {
                        type = "btrfs";
                        extraArgs = [ "-f" ];
                        subvolumes = {
                          root = {
                            mountpoint = "/";
                          };
                          home = {
                            mountOptions = [ "compress=zstd" ];
                            mountpoint = "/home";
                          };
                          nix = {
                            mountOptions = [
                              "compress=zstd"
                              "noatime"
                            ];
                            mountpoint = "/nix";
                          };
                        };
                      };
                    };
                  };
                };
              };
            };
          };
        }
      ];
    };
}
