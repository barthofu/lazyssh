{
  description = "Terminal-based SSH manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.buildGoModule {
          pname = "lazyssh";
          version = "0.3.1";

          src = self;

          vendorHash = "sha256-OMlpqe7FJDqgppxt4t8lJ1KnXICOh6MXVXoKkYJ74Ks=";

          ldflags = [
            "-X=main.version=0.3.1"
            "-X=main.gitCommit=v0.3.1"
          ];

          postInstall = ''
            mv $out/bin/cmd $out/bin/lazyssh
          '';

          meta = {
            description = "Terminal-based SSH manager";
            homepage = "https://github.com/barthofu/lazyssh";
            license = pkgs.lib.licenses.asl20;
            maintainers = with pkgs.lib.maintainers; [ kpbaks ];
            mainProgram = "lazyssh";
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go
            golangci-lint
          ];
        };
      }
    );
}
