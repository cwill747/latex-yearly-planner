{
  description = "Install latex reqs";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    font-flake = {
      url = "git+ssh://gitea@git-ssh.thewills.net:37083/cameron/font-flake.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, font-flake }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        tx02 = font-flake.packages.${system}.tx02;

        # Build the plannergen as a binary using fixed input versions
        # This means that the subsequent pdf generation does not need internet access
        # and is therefore a "pure" nix output
        plannergen = pkgs.buildGoModule {
          src = self;
          name = "plannergen";
          vendorHash = "sha256-T3x9Mtum87xEYz886P2YpchmrsGKWYwOLWxOrpErlA0=";
        };

        # Go is packaged into the devShell for developing the package,
        # but is not used for the "nix build" outputs - these use the pre-built
        # binary instead
        goDeps = [
          pkgs.go
        ];

        # Dependencies for building the latex files
        texDeps = with pkgs; [
          python3 # used by translate.py
          qpdf # linearize PDFs for faster page access on e-ink devices
          tx02
          (texlive.combine {
            inherit (texlive)
              metafont
              scheme-medium  # Updated from scheme-small for better coverage
              xcolor
              multirow
              marginnote
              adjustbox
              ifmtarg
              extsizes
              fontspec
              l3kernel     # Modern LaTeX3 kernel
              l3packages   # LaTeX3 packages including xparse functionality
              ;
          })
        ];
        pdfs = pkgs.stdenv.mkDerivation
          {
            name = "pdfs";
            # Minimal set of dependencies to build the pdfs:
            # latex and the built plannergen binary
            buildInputs = texDeps ++ [ plannergen ];
            # Let fontconfig find TX-02 in the sandbox.
            FONTCONFIG_FILE = pkgs.makeFontsConf {
              fontDirectories = [ tx02 ];
            };
            OSFONTDIR = "${tx02}/share/fonts/truetype//";
            src = "${self}";
            # currentTime is read at evaluation time, not inside the
            # sandbox. It becomes part of the derivation, so a cache
            # from a previous year cannot serve stale PDFs; a fresh
            # build runs whenever the eval-time year moves on.
            CURRENT_TIME = builtins.currentTime;
            buildCommand = ''
              cp -r $src/* .
              patchShebangs .
              chmod -R 770 *
              year=$(date -u -d "@$CURRENT_TIME" +%Y)
              for device in rmpp rm2; do
                for y in $year $((year + 1)); do
                  PLANNERGEN_BINARY=plannergen ./build.sh "$device" "$y"
                done
              done
              mkdir $out
              cp *.pdf $out/
            '';
          };
      in
      {
        packages = {
          inherit plannergen pdfs;
          default = pdfs;
        };

        devShells.default = pkgs.mkShell {
          shellHook = ''
            unset GOPATH
            unset GOROOT
            unset GO_VERSION

            # Make fonts available to fontconfig
            export FONTCONFIG_FILE=${pkgs.makeFontsConf {
              fontDirectories = [ tx02 ];
            }}
            export OSFONTDIR=${tx02}/share/fonts/truetype//
          '';
          buildInputs = [
            pkgs.nixpkgs-fmt # utility for pretty formatting of .nix files
            pkgs.fontconfig # For font management
          ] ++ goDeps ++ texDeps;
        };
      }
    );
}
