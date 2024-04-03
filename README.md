# setup the work env on mac bookpro

## Install Homebrew

## Setup dev env

### 1. Install and configure `oh-my-zsh`


### 2. Install and configure `iterm2`

```
brew install iterm2
```

### 3. Install and configure `vscode`

```
brew install visual-studio-code
```

### 3. Install `pyenv`

```
brew install pyenv
pyenv install 3.12
pyenv global 3.12
```

append to .zshrc

```
# configure for pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```

### 4. Install `fnm`

```
brew install fnm
```

append to .zshrc

```
# configure for fnm
eval "$(fnm env --use-on-cd)"
```

### 5. TO be added: golang, java ...


### Utilities

1. Install `Clocker` from app store

2. Install `Hammerspoon` via brew and configure the hotkeys

3. Install `appcleaner` via brew

### Optional


* Media player

```
brew cask iina
```