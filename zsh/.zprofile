
# Created by `pipx` on 2022-03-18 15:50:29
export PATH="$PATH:/Users/jerryzhang/.local/bin"

# fnm - nodejs version manager
eval "$(fnm env)"

# sdkman - java version manager
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
