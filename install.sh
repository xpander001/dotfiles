#!/usr/bin/env bash

# Based on https://github.com/kentcdodds/dotfiles/blob/master/.macos and https://github.com/mathiasbynens/dotfiles/blob/master/brew.sh

echo "Hello $(whoami)! Let's install brew and a set of useful apps."

echo "installing homebrew"
# install homebrew https://brew.sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

echo "Installing brew apps"

echo "Installing development and cli apps"

# Install Git tools
brew install git
brew install hub

# Install imagemagick
brew install imagemagick --with-webp

# Install watchman for RN
brew install watchman

# Command line tools
brew install tree
brew install bat
brew install delta
brew install yarn

# Development languages, version managers and tools

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh

brew install yarn
brew install rbenv
brew install pyenv

# Configure ssh
echo "Generating an RSA token for GitHub"
mkdir -p ~/.ssh
touch ~/.ssh/config
ssh-keygen -t rsa -b 4096 -C "me@andersuarez.com"
echo "Host *\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/id_rsa" | tee ~/.ssh/config
eval "$(ssh-agent -s)"
echo "run 'pbcopy < ~/.ssh/id_rsa.pub' and paste that into GitHub"

echo "Finished installing development and cli apps"

echo "Installing general cask apps"
brew cask install alfred google-chrome firefox spectacle iterm2 caffeine protonvpn \
visual-studio-code 1password vlc discord skype workflowy spotify figma staruml \
focus dropbox slack handbrake zoomus betterzip avibrazil-rdm postman \

echo "Finished installing general cask apps"

echo "Adding dotfiles"

git clone git@github.com:xpander001/dotfiles.git "${HOME}/dotfiles"
ln -s "${HOME}/dotfiles/.zshrc" "${HOME}/.zshrc"
ln -s "${HOME}/dotfiles/.gitconfig" "${HOME}/.gitconfig"

# get bat and delta all configured
mkdir -p "${HOME}/.config/bat/themes"
ln -s "${HOME}/dotfiles/.config/bat/config" "${HOME}/.config/bat/config"
git clone https://github.com/batpigandme/night-owlish "${HOME}/.config/bat/themes/night-owlish"
bat cache --build

echo "Finished adding dotfiles"

printf "TODO:\n\
install: \n\
  XCode (App Store) \n\
  Things (App Store) \n\
  Fantastical (App Store) \n\
  Reeder (App Store) \n\
  Bear (App Store) \n\
\n\
Restart Terminal.app\n\
copy git config from your backup/re-login \n\
copy .npmrc from your backup/re-login \n\
login to literally everything \n\
"