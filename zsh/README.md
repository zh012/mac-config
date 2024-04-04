1. install oh-my-zsh

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

2. copy `myamuse.zsh-theme` to `~/.oh-my-zsh/themes`

3. configure `~/.zshrc`

- theme and plugins

```
ZSH_THEME="myamuse"
plugins=(history git)
```

- ssh config switcher

```
function sshenv() {
    if [[ -f ~/.ssh/config.$1 ]]; then
        cd ~/.ssh
        ln -nsf ./config.$1 config
        cd -
    else
        echo "config $1 does not exist"
    fi
}
```