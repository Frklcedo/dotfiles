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


# zinit setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"


# autoloads bindings and completions
autoload -Uz compinit 
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"


bindkey -v
MODE_INDICATOR="%F{yellow}<<<%f"
INSERT_MODE_INDICATOR="%F{green}<<<%f"

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search


# PATH 
export PATH=/usr/sbin:$PATH
PATH="$HOME/.cargo/bin${PATH:+:${PATH}}"
PATH="$HOME/.pycharm/bin${PATH:+:${PATH}}"
# PATH="$HOME/.emacs.d/bin${PATH:+:${PATH}}"
PATH="$HOME/.config/emacs/bin${PATH:+:${PATH}}"
PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
PATH="$HOME/.local/bin:$PATH"
# export npm_config_prefix="$HOME/.local"
# PATH="$HOME/.dotnet/tools${PATH:+:${PATH}}"
# export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
source /usr/share/nvm/init-nvm.sh



# plugins and customizations
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/frkl.json)"
source <(fzf --zsh)
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light MichaelAquilina/zsh-auto-notify


AUTO_NOTIFY_IGNORE+=("lazygit" "php artisan" "npm run" "tmux" "git")

# aliases
## cd alias
alias cd..='cd ..'
alias cdhd='cd /run/media/hd'
### on arch
alias cdap='cd /srv/http'
### on fedora
#alias cdap='cd /var/www/html'

## ls alias
alias ls='ls -lh --color=auto'
alias lsa='ls -a'
#alias ls='exa -alg --color=always --group-directories-first'

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
# alias pavucontrol='pavucontrol-qt' 


# startup

if [ -f "$HOME/.keychain.sh" ]; then
  source $HOME/.keychain.sh
  # eval $(keychain --agents ssh --eval --quiet --noask sshkey)

fi

fastfetch
