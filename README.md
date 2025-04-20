# Robins Ultimate Abraxas MacBook Config with some changes

Based on the awesome work Robin did. This is just a copy of [The legends ABX dotfiles](https://gitlab.abraxas-tools.ch/AXRSC09/dotfiles.git)

which in turn is based off [The legends personal dotfiles](https://github.com/rxbn/dotfiles).

## Some of the changes

- I removed Alfred 5, yet to find an free alternative
- Reimplemented `tmux-sshionizer` to `sshw` which is a wrapper for ssh and tmux depending on if you select a single or multiple servers.
- Added some useful aliases
- Turned off Aerospace, as it produces short circuits in my brain module. I need to find a config that works well for me and with a CHDE keybd.
  have since gotten use to the latest MacOS Sequoia which has finally implemented version of tiling.

## Contents

- Terminal: Ghostty
- Editor: Neovim
- tmux/ssh for workspace and ssh session management
- fzf
- 1Password as ssh agent
- starship prompt
- direnv for directory environment vars
- Rancher kubeconfig scripts
- Postgres db state scripts
- usw.

## Install

```bash
git clone https://gitlab.abraxas-tools.ch/axary/dotfiles.git
cd dotfiles
# I did these from memory, so there if some brew pkgs dont intall from abx net then just add them to Brewfile_internet and remove them from Brewfile
bash ./initial_setup_abx.sh  # you can run this while connected to the ABX proxy
bash ./initial_setup_internet.sh  # needs to be run when connected direct to the internet
```
