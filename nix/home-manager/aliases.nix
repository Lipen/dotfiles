{
  # misc
  cls = "clear";
  clr = ''echo -ne "\033c"'';
  q = "cd && clr";
  da = "date '+%A, %B %d, %Y [%T]'";
  wh = "which -a";

  # new/modified commands
  n = "nnn -dEFHQoRrx";
  df = "df -h";
  ip = "ip --color=auto";
  grep = "grep --color=auto";
  egrep = "egrep --color=auto";
  fgrep = "fgrep --color=auto";

  # safety features
  cp = "cp -i";
  mv = "mv -i";
  rm = "rm -I"; # 'rm -i' prompts for every file
  ln = "ln -i";
  chown = "chown --preserve-root";
  chmod = "chmod --preserve-root";
  chgrp = "chgrp --preserve-root";

  # list files
  ls = "exa --group-directories-first";
  l = "ls -l";
  ll = "ls -la";
  la = "ls -la";
  lt = "ls -lT";
  lta = "ls -laT";

  # dirs
  ".." = "cd ..";
  "..." = "cd ../..";
  mkdir = "mkdir -p";
  md = "mkdir";
  rd = "rmdir";

  # history
  history = "fc -il 1";
  hist = "history | less";

  # tree
  tree = "tree --dirsfirst -ChF";
  tree1 = "tree -L 1";
  tree2 = "tree -L 2";
  tree3 = "tree -L 3";

  # disk usage
  dus = "du | sort -h";
  dusl = "du | sort -rh | less";

  # ping
  ping1 = "ping 1.1.1.1";
  ping8 = "ping 8.8.8.8";

  # clipboard
  pbcopy = "xclip -selection clipboard";
  pbpaste = "xclip -selection clipboard -o";

  # git
  gj = "git lg -10";

  # docker
  lzd = "lazydocker";

  # home-manager
  hm = "home-manager";
  hme = "home-manager edit";
  hms = "home-manager switch";
  hmsw = "home-manager switch";

  # nix
  ne = "nix-env";
  ns = "nix-shell";

  # turn on/off theme
  zsh_theme_enable = "prompt_powerlevel9k_setup";
  zsh_theme_disable = "prompt_powerlevel9k_teardown";
  zsh_theme_reload = "zsh_theme_disable && zsh_theme_enable";
}
