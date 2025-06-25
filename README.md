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

## Contributing
Contributions are welcome! Please feel free to submit pull requests or open issues.

## License
This project is licensed under the Do What The F*** You Want To Public License (WTFPL).
