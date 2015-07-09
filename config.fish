# Useful functions {{{

function _prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already in it"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx PATH "$argv[1]" $PATH
        end
    end
end

_prepend_to_path $HOME/bin
_prepend_to_path $HOME/.local/bin
for p in $HOME/.bins/*
    _prepend_to_path $p
end

set -g -x fish_greeting ''
set -g -x EDITOR "emacsclient -a '' -nw"

function ..; cd ..; end
function ...; cd ../..; end
function ....; cd ../../..; end
function .....; cd ../../../..; end

if test -e ~/.fishrc
   . ~/.fishrc
end

. ~/.config/fish/virtualfish/virtual.fish

true
