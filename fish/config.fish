# starship
# https://starship.rs/

# Init starship prompt
starship init fish | source

# fzf.fish
# https://github.com/PatrickF1/fzf.fish

# Change the directory preview command to use exa
set fzf_preview_dir_cmd exa --all --color=always

# Disable keybinding for processes and variables
fzf_configure_bindings --processes= --variables=
fzf_configure_bindings --processes= --variables=
