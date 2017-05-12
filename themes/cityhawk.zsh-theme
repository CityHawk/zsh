#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Prompt for the Zsh shell:
#   * One line.
#   * VCS info on the right prompt.
#   * Only shows the path on the left prompt by default.
#   * Crops the path to a defined length and only shows the path relative to
#     the current VCS repository root.
#   * Wears a different color wether the last command succeeded/failed.
#   * Shows user@hostname if connected through SSH.
#   * Shows if logged in as root or not.
# ------------------------------------------------------------------------------

# Customizable parameters.
PROMPT_PATH_MAX_LENGTH=30
PROMPT_DEFAULT_END=\>
PROMPT_ROOT_END=#
PROMPT_SUCCESS_COLOR=$fg[yellow]
PROMPT_FAILURE_COLOR=$FG[124]
PROMPT_VCS_INFO_COLOR=$FG[242]

# Set required options.
setopt prompt_subst

# Load required modules.
autoload -U add-zsh-hook
#autoload -Uz vcs_info

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

# Set vcs_info parameters.
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' check-for-changes false # Can be slow on big repos.
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%S" "%r/%s/%b %u%c (%a)"
#zstyle ':vcs_info:*:*' actionformats "%b"
#zstyle ':vcs_info:*:*' formats "%S" "%r/%s/%b %u%c"
zstyle ':vcs_info:*:*' formats "%S" " %{$fg[blue]%}(git:%b)"
zstyle ':vcs_info:*:*' nvcsformats "%~" ""

dyn() {
    setopt shwordsplit
    dyn_pwd=""
    full_path="$(pwd)"
    tilda_path=${full_path/$HOME/\~}
    # write the home directory as a tilda
  [[ $tilda_path[2,-1] == "/" ]] && tilda_path=$tilda_path[2,-1]
  # otherwise the first element of split_path would be empty.
    forwards_in_tilda_path=${tilda_path//[^["\/"]/}
    # remove everything that is not a "/".
    number_of_elements_in_tilda_path=$(( $#forwards_in_tilda_path + 1 ))
    # we removed the first forward slash, so we need one more element than the number of slashes.
    saveIFS="$IFS"
    IFS="/"
    split_path=(${tilda_path})
    start_of_loop=1
    end_of_loop=$number_of_elements_in_tilda_path
    for i in {$start_of_loop..$end_of_loop}
        do
        if [[ $i == $end_of_loop ]]; then
            to_be_added=$split_path[i]'/'
            dyn_pwd=$dyn_pwd$to_be_added
        else
            to_be_added=$split_path[i]
            to_be_added=$to_be_added[1,1]'/'
            dyn_pwd=$dyn_pwd$to_be_added
        fi
    done
    unsetopt shwordsplit
    IFS=$saveIFS
    [[ ${full_path/$HOME/\~} != $full_path ]] && dyn_pwd=${dyn_pwd/\/~/~}
    #prompt="%n@%m%F${promptcolor} $dyn_pwd[0,-2]${BLACK}$user_token%b%k%f"
    #echo $prompt
    echo "$dyn_pwd[0,-2]"
}

bindkey -v
vim_ins_mode="%{$fg[yellow]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[green]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char      # Control-h also deletes the previous char
bindkey "^U" backward-kill-line
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-keymap-select {
	vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
	zle reset-prompt
}

zle -N zle-keymap-select

function zle-line-finish {
	vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# # Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
function TRAPINT() {
	vim_mode=$vim_ins_mode
	return $(( 128 + $1 ))
}

# Define prompts.
PROMPT='${vim_mode} %(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})${SSH_TTY:+[%n@%m]}%{$FX[bold]%}$(dyn)$vcs_info_msg_1_ %{$fg[green]%}%(!.$PROMPT_ROOT_END.$PROMPT_DEFAULT_END)%{$FX[no-bold]%}%{$FX[reset]%} '
#RPROMPT="%{$PROMPT_VCS_INFO_COLOR%}"'$vcs_info_msg_1_'"%{$FX[reset]%}"
RPROMPT=""
