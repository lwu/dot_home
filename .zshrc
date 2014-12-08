# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ANDROID_HOME=/Users/lwu/src/android-sdk-macosx

# PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
PATH="/usr/local/bin:$HOME/bin:$PATH:$ANDROID_HOME/platform-tools"


setopt AUTO_CD
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

unsetopt correct_all # autocorrect no mo

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dpoggi"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias e="emacs"
alias e="emacsclient -n"
alias emacs="/usr/local/Cellar/emacs/24.1/Emacs.app/Contents/MacOS/Emacs -nw"
alias em="/usr/local/Cellar/emacs/24.1/Emacs.app/Contents/MacOS/Emacs"
alias here="pwd | pbcopy"
alias writer="open -a 'iA Writer'"
alias wr="writer"
alias o="open"
alias o.="open ."

# via http://msol.io/blog/tech/2014/03/10/work-more-efficiently-on-your-mac-for-developers/
function f() { find . -iname "*$1*" ${@:2} } # subdir find (ignore case)
function r() { grep "$1" ${@:2} -R . } # recursive grep

autoload -U zmv # extended move command
alias mmv='noglob zmv -W'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
