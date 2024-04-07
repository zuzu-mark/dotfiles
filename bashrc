[ -t 0 ] && stty -ixon # disable c-s c-q
# [ -t 0 ] && stty stop undef
# [ -t 0 ] && stty start undef
#ctrl+d を無視
IGNOREEOF=1000
export IGNOREEOF


export GOFLAGS="-mod=vendor"
export LESSCHARSET=utf-8
######################
# alias
######################
alias fcg='find -name "*.c"| xargs grep -a'
alias fccg='find -name "*.cc"| xargs grep -a'
alias ag='ag -u'

# for tmux
alias tm="tmux a -d -t"
alias tmux='tmux -u -2'
alias tmld='tmux source-file ~/.tmux.conf' # reload

# for vim
alias v="vim ."

# for git
alias ga="git add"
alias gf="git fetch"
alias gc="git commit"
alias gdbg="git add .;git commit -m\"dbg\";git push"

# status
alias gs="git diff --name-only"
alias gss="git status"
alias gsi="git status --ignored"
alias gsii="git ls-files --other --ignored --exclude-standard"

# diff
alias gd="git diff"

# branch
alias gb="git branch"
alias gco="git checkout"

# git log
alias gl="git log --graph --pretty=format:'%x09%C(auto) %h %Cgreen %ar %Creset%x09by \"%C(cyan ul)%an%Creset\" %x09%C(auto)%s %d'"
alias gll="git log --oneline --decorate --graph --all"
alias glll='git --no-pager log --oneline --pretty=format:"%ad %d %s <%an>" --date=format:"%Y/%m/%d %H:%M:%S" | head -n 5'

# for repo
alias rd="repo diff"
alias rs="repo status"

######################
# SET
######################
# path
if [[ ! $(echo $PATH | fgrep "$DOTFILES_INSTALL_DIR/bin") ]]; then
    PATH=$PATH:$DOTFILES_INSTALL_DIR/bin
fi
#LD_LIBRARY_PATH=~/dotfiles
source $DOTFILES_INSTALL_DIR/functions/tmux.sh
source $DOTFILES_INSTALL_DIR/functions/git-prompt.sh
source $DOTFILES_INSTALL_DIR/functions/fzf_utils.sh
export PS1='\h:\w$(__git_ps1 " [%s]")\$ '


######################
# FZF
######################
# Ctrl+t カレントディレクトリのファイルとフォルダを一覧する (例: git commit に続けて Ctrl+t を押し、Tab でファイルを選択し、最後に Enter で決定)
export FZF_TMUX=1

# export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_ALT_C_OPTS="--preview ' head -200'"

# export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} ) 2> /dev/null | head -200'"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --no-mouse"


######################
# bashmarks
######################
#unalias l 2>/dev/null
#source ~/.local/bin/bashmarks.sh
