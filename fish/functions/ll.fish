function ll --description 'List contents of directory using long format' --wraps exa
  command exa --all --long --group-directories-first --time-style=long-iso $argv
end
