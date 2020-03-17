#!/bin/bash

if [[ -n "$TMUX" ]] ; then
	if [[ -n "$SSH_CLIENT" ]] ; then
		tmux set -g prefix C-b
		tmux unbind C-a
		tmux bind C-b send-prefix
		tmux bind b last-window
		tmux bind C-b last-window
	else
		tmux set -g prefix C-a
		tmux unbind C-b
		tmux bind C-a send-prefix
		tmux bind a last-window
		tmux bind C-a last-window
	fi
fi
