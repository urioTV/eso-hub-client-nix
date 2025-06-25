{
  description = "A Nix Flake for the ESO Hub Client";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    eso-hub-client-jar = {
      url = "https://data.eso-hub.com/client/download/linux";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, eso-hub-client-jar }:
    let
      lib = nixpkgs.lib;
      pname = "eso-hub-client";
      version = "2025-06-25";
      supportedSystems = lib.systems.flakeExposed;

      mkPackage = system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
              "eso-hub-client"
            ];
          };
        in
        pkgs.stdenvNoCC.mkDerivation {
          inherit pname version;

          src = eso-hub-client-jar;

          nativeBuildInputs = [ pkgs.makeWrapper ];
          dontUnpack = true;

          installPhase = ''
            runHook preInstall
            
            mkdir -p $out/bin $out/share/java
            
            cp $src $out/share/java/${pname}.jar
            
            makeWrapper ${pkgs.jre}/bin/java $out/bin/${pname} \
              --add-flags "-jar $out/share/java/${pname}.jar"
            
            runHook postInstall
          '';

          meta = with lib; {
            description = "Client for the ESO Science Data Hub";
            homepage = "https://data.eso-hub.com/";
            license = licenses.unfree;
            platforms = platforms.all;
            maintainers = [ maintainers.your-github-username ];
          };
        };
    in
    {
      overlay = final: prev: {
        ${pname} = self.packages.${prev.system}.default;
      };

      packages = lib.genAttrs supportedSystems (system: {
        default = mkPackage system;
      });

      apps = lib.genAttrs supportedSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/${pname}";
        };
      });
    };
}
