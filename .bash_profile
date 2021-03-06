#
# ~/.bash_profile
#

[[ -f ~/.keymap ]] && sudo loadkeys ~/.keymap

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -x /usr/bin/quixand ]] \
  && quixand ~/.bash_history \
             ~/.gmrun_history \
             ~/.lesshst \
             ~/.local/share/recently-used.xbel \
             ~/.sdcv_history \
             ~/.viminfo \
             ~/.vim_mru_files \
             -d ~/Sandbox \
                ~/.cache \
                ~/.thumbnails \
                ~/.vim/.backups \
                ~/.vim/.swaps \
                ~/.vim/.tmp \
                ~/.vim/.undo \
                ~/.vim/view

if [[ -x /usr/bin/perlbrew ]]; then
  export PERLBREW_ROOT=~/.perlbrew_root
  if ! [[ -d "${PERLBREW_ROOT}" ]]; then perlbrew init; fi
  source "${PERLBREW_ROOT}"/etc/bashrc
fi

# OPAM configuration
if [[ -f ~/.opam/opam-init/init.sh ]]; then
  source ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
fi
