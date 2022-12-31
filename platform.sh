# add an alias to easily activate python3 venv
alias pyactivate=". ./.venv/bin/activate"

# add aliases for tmux
alias tnew="tmux new -s"
alias tattach="tmux attach -t"
alias tswitch="tmux switch -t"
alias tcont="tmux new-session -d"

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Load Rust stuff
source "$HOME/.cargo/env"
