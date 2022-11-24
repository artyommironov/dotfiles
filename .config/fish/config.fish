set -U fish_greeting
set -gx ANDROID_HOME $HOME/android-sdk
set -gx ANDROID_EMULATOR_USE_SYSTEM_LIBS 1
set -gx BROWSER qutebrowser
set -gx EDITOR kak
set -gx TERMINAL alacritty
set -gx FZF_DEFAULT_OPTS "--color 16,bg+:-1,fg:8,fg+:-1,info:3,border:8,header:7"
set -gx FZF_DEFAULT_COMMAND "fd --hidden --type f --exclude .git"
set -gx GTK_CSD 0
set -gx VISUAL "$EDITOR"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx QT_IM_MODULE fcitx
set -gx XMODIFIERS @im=fcitx
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"

# fix blank IDEA window in some WMs
set -gx _JAVA_AWT_WM_NONREPARENTING 1

test -e /usr/lib/jvm/openjdk17 && set -gx JAVA_HOME /usr/lib/jvm/openjdk17

set -l as_java_home "/Applications/Android Studio.app/Contents/jbr/Contents/Home"
if test -e "$as_java_home"
  set -gx JAVA_HOME "$as_java_home"
else if test -e /usr/libexec/java_home
  set -gx JAVA_HOME (/usr/libexec/java_home)
end

set fish_color_autosuggestion black
set fish_color_cancel --reverse
set fish_color_command blue --bold
set fish_color_comment black
set fish_color_end cyan
set fish_color_error red
set fish_color_escape yellow
set fish_color_history_current --bold
set fish_color_match green
set fish_color_normal normal
set fish_color_operator cyan
set fish_color_param white
set fish_color_quote green
set fish_color_redirection cyan
set fish_color_search_match normal --background=black
set fish_color_selection white --bold --background=cyan
set fish_color_valid_path --bold
set fish_pager_color_completion normal
set fish_pager_color_description yellow
set fish_pager_color_prefix normal
set fish_pager_color_progress white --background dcyan

fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/android-sdk/platform-tools
fish_add_path $HOME/Library/Android/sdk/platform-tools
fish_add_path $XDG_DATA_HOME/npm/bin
fish_add_path /opt/local/bin
fish_add_path /opt/local/libexec/gnubin/
fish_add_path /Applications/MacPorts/Alacritty.app/Contents/MacOS

abbr adblc 'adb logcat -c'
abbr adbld 'adb logcat "*:D" | grep '
abbr adble 'adb logcat "*:E" | grep '
abbr cp 'cp -irv'
abbr e '$EDITOR'
abbr eb '$EDITOR $XDG_CONFIG_HOME/qutebrowser/config.py'
abbr ee '$EDITOR $XDG_CONFIG_HOME/kak/kakrc'
abbr eg '$EDITOR $XDG_CONFIG_HOME/git/config'
abbr es '$EDITOR $XDG_CONFIG_HOME/fish/config.fish'
abbr ew '$EDITOR $XDG_CONFIG_HOME/sway/config'
abbr flu 'fluidsynth -a pulseaudio -m alsa_seq -l -i -s /usr/share/soundfonts/FluidR3_GM.sf2'
abbr g 'git'
abbr gethosts 'sudo curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -o /etc/hosts'
abbr gh 'git --git-dir=$HOME/.gh/.git --work-tree=$HOME'
abbr gogd 'lgogdownloader --download --platform linux --game'
abbr gogl 'lgogdownloader --list'
abbr grep 'grep -E'
abbr ls 'ls -A -l --group-directories-first'
abbr lyrics 'python3 ~/Projects/lyric-get/main_cli.py'
abbr mkdir 'mkdir -pv'
abbr mv 'mv -iv'
abbr off 'sudo poweroff'
abbr ping 'ping -c 5 8.8.8.8'
abbr svi 'sudo ln -s -t /var/service /etc/sv/'
abbr svd 'sudo rm /var/service/'
abbr svl 'ls -l /var/service/'
abbr qutebrowserproxy 'qutebrowser -s content.proxy socks://localhost:8080'
abbr rm 'rm -rv'
abbr reb 'sudo reboot'
abbr tunnel 'ssh -C2qTnN -D 8080'

if test (uname) = "Darwin"
  abbr pkgc 'sudo port uninstall inactive'
  abbr pkgi 'sudo port install'
  abbr pkgl 'port list installed'
  abbr pkgr 'sudo port uninstall'
  abbr pkgs 'port search'
  abbr pkgu 'sudo port selfupdate && sudo port upgrade outdated'
else
  abbr pkgc 'sudo xbps-remove --clean-cache --remove-orphans && sudo vkpurge rm all'
  abbr pkgi 'sudo xbps-install --sync'
  abbr pkgl 'xbps-query --list-pkgs'
  abbr pkgr 'sudo xbps-remove --recursive'
  abbr pkgs 'xbps-query --repository --search'
  abbr pkgu 'sudo xbps-install --sync --update'
end

function fish_prompt
  set -l last_pipestatus $pipestatus
  set -lx __fish_last_status $status
  set -g fish_prompt_pwd_dir_length 0
  set -g __fish_git_prompt_showdirtystate 1
  set -g __fish_git_prompt_showcolorhints
  set -g __fish_git_prompt_color_branch yellow
  set -g __fish_git_prompt_char_stateseparator ''
  set -l user_color (fish_is_root_user && set_color red || set_color magenta)
  set -l host_color (set -q SSH_TTY && set_color red || set_color magenta)
  set -l status_color (set_color red)
  set -l status_bold_color (set_color --bold red)
  set -l cwd_color (set_color blue)
  printf '%s%s@%s%s %s%s %s %s\n%s> ' \
    "$user_color" $USER "$host_color" (prompt_hostname) "$cwd_color" (prompt_pwd) (fish_vcs_prompt "%s") \
    (__fish_print_pipestatus "[" "]" "|" "$status_color" "$status_bold_color" $last_pipestatus) \
    (set_color white)
end

function fixmac
  set -l dir "$HOME/Library/KeyBindings/"
  mkdir -p "$dir"
  cp -f "$XDG_CONFIG_HOME/mac/DefaultKeyBinding.Dict" "$dir"
  # disable accent characters by holding the key
  defaults write -g ApplePressAndHoldEnabled -bool false
end

function backup
  set -l destinations (ls /media/)
  if test (count $destinations) -eq 1
    sudo rsync \
      --archive --delete --delete-excluded --human-readable --info=progress2 \
      --exclude /.cache \
      --exclude /.gradle \
      --exclude /.konan \
      --exclude /.m2 \
      --exclude /.wine \
      --exclude /android-sdk \
      --exclude /android-studio \
      --exclude /idea \
      --exclude /Projects/fdroiddata/ \
      --exclude /Projects/fdroidserver/ \
      --exclude /Projects/kotlin/ \
      --exclude /Projects/void-packages/ \
      ~/ /media/$destinations[1]/
   else
     echo "Can't choose destination"
   end
end

function mnt
  set -l name (lsblk --list --noheadings | fzf --info=hidden | cut --delimiter=' ' --fields=1)
  if test -n "$name"
    set -l dir "/media/$name"
    sudo mkdir -p "$dir"
    sudo mount -o rw,uid=$USER,gid=$USER "/dev/$name" "$dir"
    #sudo chown $USER:$USER "$dir"
  end
end

function umnt
  for dir in /media/*
    echo "Unmounting $dir"
    test -d "$dir" && sudo umount "$dir" && sudo rm -r "$dir" && echo "Done"
  end
end

function udevadd
  set -l id (lsusb | fzf | cut --delimiter=' ' --fields=6)
  if string match -req '^[0-9a-f]{4}:[0-9a-f]{4}$' "$id"
    set -l vendor (echo $id | cut --delimiter=':' --fields=1)
    set -l product (echo $id | cut --delimiter=':' --fields=2)
    set -l dir "/etc/udev/rules.d"
    set -l file "$dir/51-android.rules"
    set -l rule "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"$vendor\", ATTR{idProduct}==\"$product\", MODE=\"0666\""
    sudo mkdir -p "$dir"
    echo $rule | sudo tee -a "$file" > /dev/null
    sudo udevadm control --reload-rules
  end
end

function adbss
  set -l file "/sdcard/temp.png"
  adb root
  adb shell screencap -p $file
  sleep 2
  adb pull $file (date +%s).png
  adb shell rm $file
end

function color
  for i in (seq 0 15)
    printf (tput setaf $i)" %2s "(tput setab $i)"  "(tput sgr0) $i
    test $i -eq 7 && echo ""
  end
  echo ""
end

function rmmeta
  fd --type directory '^__MACOSX$' --exec rm -rf {}
  fd --hidden --type file '^(Thumbs.db|.DS_Store)$' --exec rm -f {}
end

function convmvbf
  for enc in (convmv --list)
    echo $enc
    convmv -f $enc -t utf8 $argv
  end
end

function unoflash
  arduino-cli compile -b arduino:avr:uno
  arduino-cli upload -b arduino:avr:uno -p /dev/ttyACM0
end

function edict
  grep "^$argv.*" ~/Downloads/edict2u | sed 's/\(.*\)\/Ent.*/\1/'
end

function f
  test (count $argv) -eq 1 && set -l path "$argv[1]" || set -l path "$PWD"
  if test -d "$path"
    cd "$path"
  else
    fopen "$path"
    return 0
  end
  clear
  set -l result (
    fls | fzf --ansi --exact --cycle --multi --no-info \
      --layout=reverse-list --prompt="$PWD " --delimiter="\s+" --nth=8.. \
      --preview="fpreview {8..}" \
      --preview-window hidden \
      --bind "enter:execute(f {8..} < /dev/tty > /dev/tty 2>&1)" \
      --bind 'backward-eof:abort' \
      --bind 'f3:toggle-preview' \
      --bind 'f5:reload(fls)' \
      # use expect instead of bind to access multi-selection
      --expect=f2
  )
  if test "$result[1]" = "f2"
    set -l script bulkdo.sh
    printf '%s\n' $result \
    # drop line indicating pressed key
    | tail -n +2 \
    # drop file info
    | sed -E -e 's/^([^ ]+ +){7}//' \
    # escape double quotes
    | sed 's/"/\\\"/' \
    # prefix with # and surround with double quotes
    | sed 's/.*/# "&"/' \
    > $script
    test -f $script && $EDITOR $script && source $script
    rm $script && f
  end
end

function fls
  # make file names color as white
  LS_COLORS="fi=1;37" \
  ls -l -v --all --dereference --group-directories-first --human-readable \
    --color=always --time-style=long-iso \
  # drop total info, "." and ".."
  | tail -n +4
end

function is_in_git_repo
  git rev-parse --git-dir > /dev/null 2>&1
end

function gfl -d "Show commit history and selected commit diff"
  is_in_git_repo || return
  git log --graph \
    --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --color=always \
  | fzf --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'echo {} | grep -o "[a-f0-9]\{7,\}" | xargs git show --color=always' \
  | grep -o "[a-f0-9]\{7,\}"
end

function fkill
  ps aux | fzf --tac | awk '{print $2}' | xargs kill -9
end

function fapps
  rg --no-filename --only-matching -r '$2' '.*Exec=([^ ]*/)?([^ ]+)' \
  (rg Terminal=true /usr/share/applications --files-without-match) \
  | sort -u | fzf --no-info | begin; nohup $SHELL > /dev/null 2>&1 &; end
end

function fmusic
  cd "$HOME/Music"
  mpvd (fd --hidden --type file --type symlink --exclude '*.txt' | LC_ALL=C sort | fzf --cycle --no-info)
end

if status is-login
  if test ! (set -q XDG_RUNTIME_DIR)
    set -gx XDG_RUNTIME_DIR /tmp/runtime-(id -u)
    if ! test -d "$XDG_RUNTIME_DIR"
      mkdir "$XDG_RUNTIME_DIR"
      chmod 0700 "$XDG_RUNTIME_DIR"
    end
  end
  # wait 1 second before starting WM to have chance to cancel it and fix broken WM config
  if test -z "$DISPLAY" -a (tty) = "/dev/tty1"
    echo -n "Starting WM.." && sleep 1 && eval (ssh-agent -c) && exec dbus-run-session sway
  end
end
