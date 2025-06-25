# ESO Hub Client Nix Flake

This project provides a Nix Flake to easily run the ESO Hub Client, which is a Java application.

## Features
- Connects to the ESO Hub.
- Provides client-side functionalities.

## Getting Started

### Prerequisites
- Nix package manager

### Installation
To build and run the project, use the following Nix commands:
```bash
nix build .#eso-hub-client
./result/bin/eso-hub-client
```
Alternatively, you can run the project directly using:
```bash
nix run .#eso-hub-client
```

## Project Structure
- `flake.nix`: Nix flake definition for building the project.
- `flake.lock`: Lock file for Nix dependencies.
- `result/`: Output directory for the Nix build, containing the executable JAR and other assets.

## Nix Overlay
This flake provides an overlay that makes the `eso-hub-client` package available in your Nixpkgs. This is useful if you want to integrate the ESO Hub Client into your NixOS configuration or other Nix-managed environments.

To use the overlay, add it to your `flake.nix` inputs and outputs:

```nix
# In your inputs
inputs.eso-hub-client-flake = {
      url = "github:urioTV/eso-hub-client-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

# In your outputs, within the `nixosConfigurations` or `homeConfigurations` section
nixpkgs.overlays = [
  eso-hub-client-flake.overlay
];
```

After adding the overlay, you can refer to `eso-hub-client` directly in your Nix configurations, for example:

```nix
environment.systemPackages = with pkgs; [
  eso-hub-client
];
```

## Contributing
Contributions are welcome! Please feel free to submit pull requests or open issues.

## License
This project is licensed under the Do What The F*** You Want To Public License (WTFPL).
