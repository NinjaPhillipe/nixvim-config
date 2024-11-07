{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    {
      nixvim,
      nixpkgs,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, system, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./config; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              # inherit (inputs) foo;
            };
          };

          # Define your nixvim setup with additional dependencies
          nvim = nixvim'.makeNixvimWithModule nixvimModule;

          # Additional tools you want available in the environment
          tools = [
            pkgs.ripgrep # Add ripgrep here
            # Add other dependencies here as needed
          ];
          
          # Construct the PATH by joining the bin paths of each tool
          toolsPath = builtins.concatStringsSep ":" (map (tool: "${tool}/bin") tools);
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

              # Create an executable wrapper for nixvim as the default package, with tools in the PATH
          packages.default = pkgs.writeShellScriptBin "nixvim" ''
            #!${pkgs.stdenv.shell}
            export PATH=${toolsPath}:${nvim}/bin:$PATH
            exec ${nvim}/bin/nvim "$@"
          '';

          # Define a development shell with dependencies
          devShells = {
            default = pkgs.mkShell {
              buildInputs = tools ++ [nvim];
            };
          };
        };
    };
}
