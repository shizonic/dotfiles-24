# -----------------------------------------------------------------------------
# ~/.bashrc
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# Setup

# if not running interactively, do nothing
[[ $- != *i* ]] && return

# term
if [[ "x$DISPLAY" != "x" ]]; then
  export HAS_256_COLORS=yes
  alias tmux="tmux -2"
  [[ "$TERM" == "xterm" ]] && export TERM=xterm-256color-it
else
  if [[ "$TERM" == "xterm" || "$TERM" =~ "256color" ]]; then
    export HAS_256_COLORS=yes
    alias tmux="tmux -2"
  fi
fi
if [[ "$TERM" == "screen" && "$HAS_256_COLORS" == "yes" ]]; then
  export TERM=screen-256color-it
elif [[ "$TERM" == "tmux" && "$HAS_256_COLORS" == "yes" ]]; then
  export TERM=tmux-256color-neovim
fi

# miromiro dircolors by jwr
#[[ -f "$HOME/.dir_colors" ]] && eval $(dircolors -b "$HOME/.dir_colors")

# miro8 console colors by jwr
if [[ "$TERM" == "linux" || "$TERM" == "vt100" || "$TERM" == "vt220" ]]; then
   echo -en "\e]P0000000" #black
   echo -en "\e]P83d3d3d" #darkgrey
   echo -en "\e]P18c4665" #darkred
   echo -en "\e]P9bf4d80" #red
   echo -en "\e]P2287373" #darkgreen
   echo -en "\e]PA53a6a6" #green
   echo -en "\e]P37c7c99" #brown
   echo -en "\e]PB9e9ecb" #yellow
   echo -en "\e]P4395573" #darkblue
   echo -en "\e]PC477ab3" #blue
   echo -en "\e]P55e468c" #darkmagenta
   echo -en "\e]PD7e62b3" #magenta
   echo -en "\e]P631658c" #darkcyan
   echo -en "\e]PE6096bf" #cyan
   echo -en "\e]P7899ca1" #lightgrey
   echo -en "\e]PFc0c0c0" #white
   clear # bring us back to default input colours
fi

# editor
export EDITOR=vim
export FCEDIT=vim
export VISUAL=vim
export SUDO_EDITOR=rvim

# man pages
export MANPAGER="less -X"

# mode
set -o vi

# prompt
export PROMPT_COMMAND="history -a;history -c;history -r"
PS1="\[\e[01;31m\]┌─[\[\e[01;35m\u\e[01;31m\]]──[\[\e[00;37m\]${HOSTNAME%%.*}\[\e[01;32m\]]:\w$\[\e[01;31m\]\n\[\e[01;31m\]└──\[\e[01;36m\]>>\[\e[0m\]"

# Do not overwrite existing file by redirect `>`
# Use `>|` to override this setting
set -o noclobber

### disable ctrl-s and ctrl-q
[[ $- =~ i ]] && stty -ixoff -ixon

# fix for terminal vim ctrl-q keybindings
stty start undef


# -----------------------------------------------------------------------------
# Path

# default
export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
# dotfiles
PATH=$HOME/.bin:$PATH
# elixir
PATH=$HOME/.exenv/shims:$PATH
# go
PATH=/usr/lib/go/site/bin:$PATH
# haskell
PATH=$HOME/.cabal/bin:$PATH
# nim
PATH=$HOME/.nimble/bin:$PATH
# node
export N_PREFIX="$HOME/.n"
# ocaml (opam config env) https://github.com/ocaml/opam-repository/issues/584
PATH=$HOME/.opam/4.02.3/bin:$PATH
export CAML_LD_LIBRARY_PATH=$HOME/.opam/4.02.3/lib/stublibs:/usr/lib/ocaml/stublibs
export MANPATH=$HOME/.opam/4.02.3/man:$MANPATH
export PERL5LIB=$HOME/.opam/4.02.3/lib/perl5:$PERL5LIB
export OCAML_TOPLEVEL_PATH=$HOME/.opam/4.02.3/lib/toplevel:$OCAML_TOPLEVEL_PATH
# perl
PATH=/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/bin/site_perl:$PATH
# perl6
if [[ -x /usr/bin/perl6 ]]; then
  # PATH=$(perl6 -e "say ~CompUnit::RepositoryRegistry.repository-for-name('site')")/bin:$PATH
  # PATH=$(perl6 -e "say ~CompUnit::RepositoryRegistry.repository-for-name('vendor')")/bin:$PATH
  PATH=/usr/share/perl6/site/bin:/usr/share/perl6/vendor/bin:$PATH
  # panda
  # PATH=$(perl6 -e "say ~CompUnit::RepositoryRegistry.repository-for-name('home')")/bin:$PATH
fi
# python
PATH=$HOME/.virtualenvs:$PATH
# R
export R_LIBS="$HOME/.R"
# ruby
if [[ -x /usr/bin/gem && -x /usr/bin/ruby ]]; then
  PATH=$(gem env gempath | awk -F: '{print $2}')/bin:$PATH
  PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH
  export GEM_HOME=$(ruby -rubygems -e "puts Gem.user_dir")
fi
PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shim:$PATH


# -----------------------------------------------------------------------------
# History

# don't put duplicate lines in the history. See bash(1) for more
# options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTIGNORE="l:ls:cd:exit"


# -----------------------------------------------------------------------------
# UX

# check the window size after each command and, if necessary, update
# the values of LINES and COLUMNS
shopt -s checkwinsize

# autocorrect typos in path names when using `cd`
shopt -s cdspell

# add tab completion for SSH hostnames based on ~/.ssh/config, ignoring
# wildcards
[[ -e "$HOME/.ssh/config" ]] \
  && complete \
       -o "default" \
       -o "nospace" \
       -W "$(grep "^Host" "$HOME/.ssh/config" \
           | grep -v "[?*]" \
           | cut -d " " -f2)" \
       scp sftp ssh


# -----------------------------------------------------------------------------
# Aliases

[[ -n $TMUX ]] && alias clear='clear; tmux clear-history'
[[ -n $TMUX ]] && alias reset='reset; tmux clear-history'
alias ls='ls -F --color=auto --group-directories-first'
alias l='ls -1F --color=auto --group-directories-first'
alias l1='ls -1AF --color=auto --group-directories-first'
alias la='ls -aF --color=auto'
alias ll='ls -laihF --color=auto'
alias lld='getdirs'
alias llda='getadirs'
alias lldao='getadirso'
alias lsd='ls -ltrF --color=auto | grep --color=never ^d'
alias lx='command ls -lAXB --color=auto' # sort by extension
alias lk='command ls -lASr --color=auto' # sort by size
alias lc='command ls -lAcr --color=auto' # sort by change time
alias lu='command ls -lAur --color=auto' # sort by access time
alias lt='command ls -lAtr --color=auto' # sort by date
alias l\?='ls -1F | grep "$@" -i --color=auto'
[[ -x /usr/bin/tree ]] && alias tree='tree -C --charset utf-8 --dirsfirst'
[[ -x /usr/bin/findx ]] && alias f='findx -x -name .git,.subgit,.hg,.subhg,docs,examples,t,*LICENSE*,META.info,*.md | perl -pne "s/\.\///"'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias du='du -h --max-depth=1'
alias dusort='du -x --block-size=1048576 | sort -nr'
alias df='df -h'
alias disks='echo "╓───── m o u n t . p o i n t s"; echo "╙────────────────────────────────────── ─ ─ "; lsblk -a; echo ""; echo "╓───── d i s k . u s a g e"; echo "╙────────────────────────────────────── ─ ─ "; df -h;'
alias cdd='cd $HOME/Downloads'
alias cdg='cd $(git rev-parse --show-cdup)'
alias cdp='cd $HOME/Projects'
alias cds='cd $HOME/.src'
alias ps='ps --forest'
[[ -x /usr/bin/systemctl ]] && alias userctl='systemctl --user'
[[ -x /usr/bin/archversion ]] && alias avs='archversion sync && archversion report --new'
[[ -x /usr/bin/archversion ]] && alias avr='archversion report --new'
[[ -x /usr/bin/packer ]] && alias aurupdate='packer -Syu --auronly'
[[ "$DISPLAY" == "" ]] && alias vim='vim -X' # if not in X, tell vim not to attempt connection w/ X server
[[ -x /usr/bin/vim ]] && alias view='vim -R'
[[ -x /usr/bin/vim ]] && alias vime='vim -u $HOME/.vimencrypt -x'
[[ -x /usr/bin/vim ]] && alias viml='vim -u $HOME/.vimrc.lite'
[[ -x /usr/bin/vim ]] && alias vimmin='vim -u NONE -U NONE --cmd "set nocompatible | syntax on | filetype plugin indent on"'
[[ -x /usr/bin/gvim ]] && alias gview='gvim -R'
[[ -x /usr/bin/gvim ]] && alias gvime='gvim -u $HOME/.vimencrypt -x'
[[ -x /usr/bin/gvim ]] && alias gviml='gvim -u $HOME/.vimrc.lite'
[[ -x /usr/bin/gvim ]] && alias gvimmin='gvim -u NONE -U NONE --cmd "set nocompatible | syntax on | filetype plugin indent on"'
[[ -x /usr/bin/nvim ]] && alias nv='nvim'
[[ -x /usr/bin/zip ]] && alias zip='zip -9'
alias gzip='gzip -9'
alias bzip2='bzip2 -9'
alias grep='grep --ignore-case --color=auto'
alias fgrep='fgrep --ignore-case --color=auto'
alias egrep='egrep --ignore-case --color=auto'
[[ -x /usr/bin/ag ]] && alias ag='ag --hidden --smart-case --skip-vcs-ignores --path-to-agignore=$HOME/.agignore'
[[ -x /usr/bin/locate ]] && alias locate='locate --ignore-case'
if [[ -x /usr/bin/icdiff ]]; then
  alias diff='icdiff'
elif [[ -x /usr/bin/colordiff ]]; then
  alias diff='colordiff'
fi
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
[[ -x /usr/bin/pcmanfm ]] && alias :o='pcmanfm "$PWD" &'
[[ -x /usr/bin/nvim ]] && alias nview='nvim -R'
alias :e='"$EDITOR"'
alias :q='exit'
[[ -x /usr/bin/subgit ]] && alias sg='subgit'
[[ -x /usr/bin/subhg ]] && alias shg='subhg'
alias pkg\?='pacman -Q | grep -v grep | grep "$@" -i --color=auto'
alias h\?='history | grep -v -E "grep|h\?" | grep "$@" -i --color=auto'
alias p\?='ps auxf | grep -v grep | grep "$@" -i --color=auto'
alias free='free -m'
[[ -x /usr/bin/mosh ]] && alias mosh='mosh -a'
[[ -x /usr/bin/ptipython2 ]] && alias ptipython2='ptipython2 --vi'
[[ -x /usr/bin/ptipython ]] && alias ptipython='ptipython --vi'
[[ -x /usr/bin/ptpython2 ]] && alias ptpython2='ptpython2 --vi'
[[ -x /usr/bin/ptpython ]] && alias ptpython='ptpython --vi'
[[ -x /usr/bin/perl6 ]] && alias p6='perl6'
[[ -x /usr/bin/perl6 ]] && alias prove6='prove -r -e perl6'
[[ -x /usr/bin/perl6 && -x /usr/bin/rlwrap ]] && alias rp='rlwrap perl6'
[[ -x /usr/bin/iex && -x /usr/bin/rlwrap ]] && alias iex='rlwrap -Aa iex'
[[ -x /usr/bin/erl && -x /usr/bin/rlwrap ]] && alias erl='rlwrap -Aa erl'
[[ -x /usr/bin/google-chrome ]] && alias google-chrome='google-chrome --enable-webgl --ignore-gpu-blacklist'


# -----------------------------------------------------------------------------
# Functions

for _fn in $(find "$HOME/.functions.d" -type f -name "*.sh"); do . "${_fn}"; done


# -----------------------------------------------------------------------------
# Archinfo

if [[ -x "$HOME/.bin/archinfo" && -x /usr/bin/python2 ]]; then
  if ! [[ "$UID" == '0' ]]; then archinfo; else archinfo -c red; fi
fi


# -----------------------------------------------------------------------------
# FZF

# use ag/pt/ack as the default source for fzf
if [[ -x /usr/bin/ag ]]; then
  export FZF_DEFAULT_COMMAND='ag --hidden --smart-case --nocolor --skip-vcs-ignores --path-to-agignore=$HOME/.agignore -g ""'
elif [[ -x /usr/bin/pt ]]; then
  export FZF_DEFAULT_COMMAND='pt --hidden --nocolor -e -g=""'
elif [[ -x /usr/bin/ack ]]; then
  export FZF_DEFAULT_COMMAND='ack --nocolor --nopager -g ""'
fi

# use ag/pt/ack for ctrl-t completion
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# use ag/pt/ack for ** completion
_fzf_compgen_path() {
  if [[ -x /usr/bin/ag ]]; then
    ag \
      --hidden \
      --smart-case \
      --nocolor \
      --skip-vcs-ignores \
      --path-to-agignore="$HOME/.agignore" \
      -g "" \
      "$1"
  elif [[ -x /usr/bin/pt ]]; then
    pt --hidden --nocolor -e -g="" "$1"
  elif [[ -x /usr/bin/ack ]]; then
    ack --nocolor --nopager -g "" "$1"
  fi
}

# use multi-select and seoul256 colors
#export FZF_DEFAULT_OPTS='
#  --multi
#  --color fg:242,bg:233,hl:65,fg+:15,bg+:234,hl+:108
#  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
#'

# use multi-select and jellyx colors
export FZF_DEFAULT_OPTS='
  --multi
  --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
  --color info:150,prompt:110,spinner:150,pointer:167,marker:174
'

# improved preview
command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -$LINES'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden --bind ?:toggle-preview"
export FZF_CTRL_T_OPTS="--preview '(cat {} || tree -C {}) 2> /dev/null | head -$LINES'"

# create fzf key bindings
[[ -e "/etc/profile.d/fzf.bash" ]] && . /etc/profile.d/fzf.bash
[[ -e "/etc/profile.d/fzf-extras.bash" ]] && . /etc/profile.d/fzf-extras.bash

# enable fuzzy file completion for additional programs
for _program in abiword \
                evince \
                feh \
                firefox \
                gimp \
                gnumeric \
                inkscape \
                libreoffice \
                mplayer \
                perl6 \
                shotwell \
                vlc \
                vym; do
  complete -F _fzf_file_completion -o default -o bashdefault $_program
done

# enable fuzzy file/dir completion for additional programs
for _program in ack ag pt sift; do
  complete -F _fzf_path_completion -o default -o bashdefault $_program
done


# -----------------------------------------------------------------------------
# CommaCD

[[ -r "/usr/share/commacd/commacd.bash" ]] && . /usr/share/commacd/commacd.bash


# -----------------------------------------------------------------------------
# CryFS

export CRYFS_NO_UPDATE_CHECK=true


# -----------------------------------------------------------------------------
# GPG

export GPG_TTY=$(tty)


# -----------------------------------------------------------------------------
# Host-specific config

[[ -f $HOME/.bashrc.$HOSTNAME ]] && . "$HOME/.bashrc.$HOSTNAME"
