function __fish_git_in_working_tree
  [ "true" = (git rev-parse --is-inside-work-tree ^ /dev/null; or echo false) ]
end

function __fish_git_dirty
  not git diff --no-ext-diff --quiet --exit-code ^ /dev/null
  or not git diff-index --cached --quiet HEAD ^ /dev/null
  or count (git ls-files --others --exclude-standard) > /dev/null
end

function __fish_git_current_head
  git symbolic-ref HEAD ^ /dev/null
  or git describe --contains --all HEAD
end

function __fish_git_current_branch
  __fish_git_current_head | sed -e "s#^refs/heads/##"
end


function fish_prompt --description 'Write out the prompt'

    set -l last_status $status

    if [ -n "$VIRTUAL_ENV" ]
        set_color magenta
        printf 'vf:%s ' (basename "$VIRTUAL_ENV")
    end

    if __fish_git_in_working_tree
        if __fish_git_dirty
            set_color red
        else
            set_color blue
        end
        printf "git:%s%s " (__fish_git_current_branch) (set_color normal)
    end

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)

    if test $last_status -eq 0
        set_color white -o
    else
        set_color red -o
    end

    switch $USER
        case root
	    printf ' # '
	case '*'
	    printf ' > '
    end

    set_color normal

end
