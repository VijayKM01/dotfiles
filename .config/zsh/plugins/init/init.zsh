## Basic Settings
	setopt AUTO_CD          							# `dirname` is equivalent to `cd dirname`
	setopt extended_glob								# Enable globbing
	stty stop undef									# Disable ctrl-s to freeze terminal.
	unsetopt RM_STAR_SILENT 							# Always ask before rm folder/*
# Perform command substitution, parameter and arithmetic expansion in prompt.
	setopt prompt_subst

# Remember recent directories
	autoload -Uz add-zsh-hook
	DIRSTACKFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/dirs"
	if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
		dirstack=("${(@f)"$(< "$DIRSTACKFILE")"}")
		[[ -d "${dirstack[1]}" ]] && cd -- "${dirstack[1]}"
	fi
	chpwd_dirstack() {
		print -l -- "$PWD" "${(u)dirstack[@]}" > "$DIRSTACKFILE"
	}
	add-zsh-hook -Uz chpwd chpwd_dirstack
	DIRSTACKSIZE='20'
	setopt auto_pushd
	setopt pushd_silent
	setopt pushd_to_home
	setopt pushd_ignore_dups
	setopt pushdminus

# function to visualize dir stack
	function di () {
	  if [[ -n $1 ]]; then
	    dirs "$@"
	  else
	    dirs -v | head -10
	  fi
	}
	compdef _dirs di

## Colors & Appearance
	autoload -U colors && colors

## Autocompletion # +0.2
	autoload -U compinit
	zmodload zsh/complist
	compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
# Add .files to autocomplete
	_comp_options+=(globdots)							# Include hidden files.
# Basic autocomplete: case-insensitive and colored with LS_COLORS
	zstyle ':completion:*:*:*:*:*' menu select
	zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
	zstyle ':completion:*' rehash true
