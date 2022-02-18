function lowercase
  find . -depth -exec rename 's/(.*)\/([^\/]*)/$1\/\L$2/' {} \;
end
