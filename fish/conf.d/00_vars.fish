set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

set -gx GREP_COLOR "1;37;45"

# Rust
set -gx CARGOBIN "$HOME/.cargo/bin"

# Startship
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"

fish_add_path --path \
  $CARGOBIN
