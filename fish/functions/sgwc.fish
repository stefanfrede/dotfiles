function sgwc --description 'Set git work credentials' --wraps exa
  command git config user.name "Stefan Frede"
  command git config user.email "sfr@wyn.rocks"
  command git config commit.gpgsign false
end
