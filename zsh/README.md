1. install oh-my-zsh

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

2. install powerline fonts [Meslo LG M for Powerline](https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf)

3. set iterm2 font at

```
Profiles -> Default -> Text -> Non-ASCII Font
```

4. link profile

```
cd
ln -nsf $HOME/Repo/zsh/.zprofile .zprofile
ln -nsf $HOME/Repo/mac-setup/zsh/.zshrc .zshrc
```