# PATH 
export PATH=/usr/sbin:$PATH
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.config/composer/vendor/bin:$PATH"
PATH="$HOME/.cargo/bin${PATH:+:${PATH}}"
PATH="$HOME/.pycharm/bin${PATH:+:${PATH}}"
# PATH="$HOME/.local/share/nvim/mason/bin${PATH:+:${PATH}}"
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

[ -f ~/.zsh_path ] && source ~/.zsh_path
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
else
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.config/nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
fi

[ -f ~/wp/wp-completion.bash ] && source ~/wp/wp-completion.bash

# configurations 
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt extendedglob 
setopt nomatch
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# autoloads bindings and completions
autoload -Uz compinit 
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

bindkey -e
MODE_INDICATOR="%F{yellow}<<<%f"
INSERT_MODE_INDICATOR="%F{green}<<<%f"

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^K" up-line-or-beginning-search
bindkey "^J" down-line-or-beginning-search
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^P" backward-word
bindkey "^N" forward-word

WORDCHARS='*?[]~&;!#$%^(){}<>,".-'

# zinit setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

# plugins and customizations
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/frkl.json)"
source <(fzf --zsh)
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light MichaelAquilina/zsh-auto-notify

AUTO_NOTIFY_IGNORE+=("lazygit" "php artisan" "npm run" "tmux" "git")

# plugin bindings
bindkey "^ " autosuggest-accept

eval "$(zoxide init zsh)"

stty -ixon
function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle -N sesh-sessions
bindkey -M emacs '^S' sesh-sessions
bindkey -M vicmd '^S' sesh-sessions
bindkey -M viins '^S' sesh-sessions

# aliases
## cd alias
alias cd='z'
alias cd..='cd ..'
alias cdhd='cd /run/media/hd'
### on arch
alias cdap='cd /srv/http'
### on fedora
#alias cdap='cd /var/www/html'

## ls alias
alias ls='ls -lh --color=auto'
alias lsa='ls -a'
if command -v exa > /dev/null 2>&1; then
    alias ls='exa -alg --color=always --group-directories-first'
fi

#system alias
#reboot='sudo reboot'
#shutdown='sudo shutdown'
alias kbbr='setxkbmap -model abnt2 -layout br' 

## program alias
alias ssh="TERM=xterm-256color $(which ssh)"
alias emacs="emacsclient -c -a 'emacs'"
alias emacskill='emacsclient -e "(kill-emacs)"'
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias startvm="sudo virsh net-start default"
alias startobs="flatpak run com.obsproject.Studio"
alias sshagit='sudo eval "$(ssh-agent -s)"'
alias tmux="tmux -2"

# startup

if [ -f "$HOME/.keychain.sh" ]; then
  source $HOME/.keychain.sh
  # eval $(keychain --agents ssh --eval --quiet --noask sshkey) # --agents deprecated
  # eval $(keychain --eval --quiet --noask sshkey)
  # eval $(keychain --inherit any-once --eval --quiet --noask sshkey) ### wayland

fi
