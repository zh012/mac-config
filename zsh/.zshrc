# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/jerryzhang/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="myamuse"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(history git docker docker-compose)
plugins=(history git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

function clear-scrollback-buffer {
  # Behavior of clear:
  # 1. clear scrollback if E3 cap is supported (terminal, platform specific)
  # 2. then clear visible screen
  # For some terminal 'e[3J' need to be sent explicitly to clear scrollback
  clear && printf '\e[3J'
  # .reset-prompt: bypass the zsh-syntax-highlighting wrapper
  # https://github.com/sorin-ionescu/prezto/issues/1026
  # https://github.com/zsh-users/zsh-autosuggestions/issues/107#issuecomment-183824034
  # -R: redisplay the prompt to avoid old prompts being eaten up
  # https://github.com/Powerlevel9k/powerlevel9k/pull/1176#discussion_r299303453
  zle && zle .reset-prompt && zle -R
}

zle -N clear-scrollback-buffer
bindkey '^L' clear-scrollback-buffer


function sshenv() {
    if [[ -f ~/.ssh/config.$1 ]]; then
        cd ~/.ssh
        ln -nsf ./config.$1 config
        cd -
    else
        echo "config $1 does not exist"
    fi
}

# switch aws credentials
function awsenv() {
    if [[ -f ~/.aws/credentials.$1 ]]; then
        cd ~/.aws
        rm credentials || true
        ln -nsf ./credentials.$1 credentials
        cd -
        ~/.aws/awsenv-auth.py
    else
        echo "env $1 does not exist"
    fi
}
alias awsotp='~/.aws/pai-sre-otp.py'

alias curl-trace='curl -w "@~/.curl-format" -o /dev/null -s'

alias gconf-side='git config user.name zh012 && git config user.email hui.zhang.jerry@gmail.com'
alias gconf-work='git config user.name "Jerry Zhang"  && git config user.email jerry.zhang@paytm.com'


### brew cask install adoptopenjdk8
# export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# kubectl
alias k='kubectl'
alias kg='kubectl get'
alias kc='kubectl create'
alias ka='kubectl apply'
alias kd='kubectl describe'
alias ke='kubectl exec'
alias kl='kubectl logs'

function kns () {
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
		# realm=$(ls -l ~/.kube/config | sed -e 's/.* -> \.\/config.//')
		# kubectl config use-context "${context}.${realm}"
		kubectl config use-context "${context}"
	fi
	kubectl config get-contexts
}

function kenv () {
    if [[ -f ~/.kube/config.$1 ]]; then
        cd ~/.kube
        rm config || true
        ln -nsf ./config.$1 config
        cd -
    else
        echo "kubectl context $1 does not exist"
    fi
}

# initialize anaconda
source "/usr/local/anaconda3/etc/profile.d/conda.sh"
alias ca='conda activate'

eval "`fnm env`"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jerryzhang/.sdkman"
[[ -s "/Users/jerryzhang/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jerryzhang/.sdkman/bin/sdkman-init.sh"

