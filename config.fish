# Useful functions {{{

function psg -d "Grep for a running process, returning its PID and full string"
    ps auxww | grep -i --color=always $argv | grep -v grep | collapse | cuts -f 2,11-
end

function prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already in it"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx PATH "$argv[1]" $PATH
        end
    end
end

prepend_to_path $HOME/bin
prepend_to_path $HOME/.local/bin
prepend_to_path $HOME/.pyenv/bin

set -g -x fish_greeting ''
set -g -x EDITOR 'emacsclient -q -t -a ""'

function ..; cd ..; end
function ...; cd ../..; end
function ....; cd ../../..; end
function .....; cd ../../../..; end

. ~/.config/fish/virtualfish/virtual.fish

true
