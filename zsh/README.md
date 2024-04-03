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

- kubectl alias and commands

```
alias k='kubectl'
alias kg='kubectl get'
alias kc='kubectl create'
alias ka='kubectl apply'
alias kd='kubectl describe'
alias ke='kubectl exec'
alias kl='kubectl logs'

function kns() {
	ns=$1
	if [ -z $ns ]; then
		kubectl get namespace
	else
		kubectl config set-context $(kubectl config current-context) --namespace=$ns
		kubectl config get-contexts
	fi
}

function ktx () {
	context=$1
	if [ ! -z $context ]; then
		realm=$(ls -l ~/.kube/config | sed -e 's/.* -> \.\/config.//')
		kubectl config use-context "${context}.${realm}"
	fi
	kubectl config get-contexts
}

function kenv() {
    if [[ -f ~/.kube/config.$1 ]]; then
        cd ~/.kube
        ln -nsf ./config.$1 config
        cd -
    else
        echo "kubectl context $1 does not exist"
    fi
}
```