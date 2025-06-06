# NixOS Configurations
This is the flake.nix and list of configurations that run all of the machines on my home network. Currently I have 6 machines, including a Raspberry Pi 4 and a Dell R710 server. I use nixos-anywhere to deploy new machines, and deploy-rs for updating systems.

## Host Systems
| Host Name | Host Type | Architecture | CPU | RAM | GPU |
|-----------|-----------|---------|----------|----------|----------|
| Adam | Desktop | x86_64-linux | AMD Ryzen 9 3900X | 32 GB | NVIDIA GeForce RTX 3070 |
| Lilith | Framework 13 Laptop | x86_64-linux | AMD Ryzen AI 7 350 | 32 GB | AMD Radeon 860M |
| Sachiel | HP 250 G3 Notebook | x86_64-linux | Intel Celeron N2840 | 4 GB | Intel HD Graphics 4000 |
| Shamshel | Raspberry Pi 4 | aarch64-linux | ARM Cortex-A72 | 8 GB | VideoCore VI |
| Ramiel | Dell Poweredge R710 | x86_64-linux | Intel Xeon E5-5540x2 | 96 GB | - |
| Gaghiel | Thinkpad T560 Laptop | x86_64-linux | Intel i5 6300U | 8 GB | Intel HD Graphics 520 |
## Components
### Infrastructure
- sops (Secrets Manager)
- disko (Declarative Disk Management)
- nixos-anywhere (Deployment Tool)
- deploy-rs (Update Tool)
