#!/bin/sh

# Start function definitions
fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  local green='\033[0;32m'
  printf "${green}\\n$fmt\\n" "$@"
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.zshrc.local" ]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\\n" "$text" >> "$zshrc"
    else
      printf "\\n%s\\n" "$text" >> "$zshrc"
    fi
  fi
}

gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    gem update "$@"
  else
    gem install "$@"
  fi
}

add_or_update_asdf_plugin() {
  local name="$1"

  if ! asdf plugin-list | grep -Fq "$name"; then
    asdf plugin-add "$name"
  else
    asdf plugin-update "$name"
  fi
}

install_asdf_language() {
  local language="$1"
  local version
  fancy_echo "Checking/Installing latest stable ${language} ..."
  version="$(asdf latest "$language" | grep -v "[a-z]" | tail -1)"

  if ! asdf list "$language" | grep -Fq "$version"; then
    asdf install "$language" "$version"
    asdf global "$language" "$version"
  fi
  fancy_echo "${language} version: ${version} installed"
}
# End function definitions

# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

if [ ! -f "$HOME/.zshrc" ]; then
  fancy_echo "Creating .zshrc file"
  touch "$HOME/.zshrc"
fi

# Brew setup
fancy_echo "Homebrew Setup"
if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  fancy_echo "Homebrew already installed"
fi

if brew list | grep -Fq brew-cask; then
  fancy_echo "Uninstalling old Homebrew-Cask ..."
  brew uninstall --force brew-cask
fi


fancy_echo "Homebrew Bundle"
# Install dependencies
brew bundle --file=- <<EOF
brew "git"
brew "ctags"
brew "gnupg"
brew "pinentry-mac"
brew "asdf"
brew "yarn"
brew "neovim"
brew "tmux"
brew "reattach-to-user-namespace"
brew "the_silver_searcher"
brew "imagemagick"
brew "redis"
brew "memcached"
brew "mysql@8.0"
brew "ripgrep"
brew "awscli"
EOF

# ASDF Version Manager Setup
fancy_echo "Configuring asdf version manager ..."

# shellcheck disable=SC1090
source "/opt/homebrew/opt/asdf/libexec/asdf.sh"

add_or_update_asdf_plugin "ruby"
add_or_update_asdf_plugin "nodejs"
add_or_update_asdf_plugin "python"


install_asdf_language "ruby"

fancy_echo "Updating Ruby Gems"
gem update --system
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))

install_asdf_language "nodejs"
install_asdf_language "python"


# TODO: Need to install VIM PLUG, tmux tpm, powerline, patched fonts, zsh plugins
# pip install powerline-status after latest python install in asdf and set to global

#Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# install auto suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install fast syntax highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# install nerd font
  # https://www.nerdfonts.com/font-downloads
