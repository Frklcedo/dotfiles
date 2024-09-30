HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt extendedglob nomatch

bindkey -v
MODE_INDICATOR="%F{yellow}<<<%f"
INSERT_MODE_INDICATOR="%F{green}<<<%f"

autoload -Uz compinit 
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search


source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

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

eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/frkl.json)"
source <(fzf --zsh)
source /usr/share/nvm/init-nvm.sh

# cd alias
alias cd..='cd ..'
alias cdhd='cd /run/media/hd'

## on arch
alias cdap='cd /srv/http'
## on fedora
#alias cdap='cd /var/www/html'

# ls alias
alias ls='ls -lh --color=auto'
alias lsa='ls -a'
#alias ls='exa -alg --color=always --group-directories-first'

#system alias
#reboot='sudo reboot'
#shutdown='sudo shutdown'
alias kbbr='setxkbmap -model abnt2 -layout br' 

#program alias
alias ssh="TERM=xterm-256color $(which ssh)"
alias emacs="emacsclient -c -a 'emacs'"
alias emacskill='emacsclient -e "(kill-emacs)"'
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias startvm="sudo virsh net-start default"
alias startobs="flatpak run com.obsproject.Studio"
alias sshagit='sudo eval "$(ssh-agent -s)"'
alias tmux="tmux -2"

# alias pavucontrol='pavucontrol-qt' 


# fastfetch

if [ -f "$HOME/.keychain.sh" ]; then
  source $HOME/.keychain.sh
  # eval $(keychain --agents ssh --eval --quiet --noask sshkey)

fi

