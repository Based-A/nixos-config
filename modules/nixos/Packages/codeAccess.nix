{
  pkgs,
  inputs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    neovim
    
    # Git
    git
    github-desktop
    gh
    
    #VS Code
    vscode
    nixfmt-rfc-style
    nixd
  ];
}