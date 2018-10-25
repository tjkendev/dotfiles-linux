export EDITOR=vim
export LANG=ja_JP.UTF-8
export KCODE=u

bindkey -v

# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

setopt no_beep            # beep音なし
setopt auto_cd            # ディレクトリ入力で移動
setopt magic_equal_subst  # =以降の保管
setopt notify             # bg jobの状態変化通知
setopt equals             # '=command' => 'which command'

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

autoload -U compinit; compinit # 補完機能有効
setopt auto_list               # 補完候補一覧表示
setopt auto_menu               # 補完キーで補完候補を順に表示
setopt list_packed             # 補完候補を詰めて表示
setopt list_types              # 補完候補にファイルの種類表示

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt bang_hist          # '!'
setopt extended_history   # ヒストリに実行時間も保存
setopt hist_ignore_dups   # 直前の同じコマンドは保存しない
setopt share_history      # 他のシェルのヒストリを共有
setopt append_history     # historyに上書きではなく追加
setopt hist_reduce_blanks # 余分なスペース削除

export CLICOLOR=true # lsコマンド色付き

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
  local left=' %{\e[38;5;2m%}(%~)%{\e[m%}'
  vcs_info
  local right="%{\e[38;5;32m%}${vcs_info_msg_0_}%{\e[m%}"
  local invisible='%([BSUbfksu]|([FK]|){*})'
  local leftwidth=${#${(S%%)left//$~invisible/}}
  local rightwidth=${#${(S%%)right//$~invisible/}}
  local padwidth=$(($COLUMNS - ($leftwidth + $rightwidth) % $COLUMNS))

  print -P $left${(r:$padwidth:: :)}$right
}

autoload -U colors; colors # プロンプト色付き
# 通常
tmp_prompt="%{${bg[green]}%}%n%{${reset_color}%} $ "
tmp_prompt2="%{${fg[white]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# root
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
#RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

# ------ alias and path settings ------

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dir_colors && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias h='history'

# Math Kernel Library
if [ -f /opt/intel/bin/compilervars.sh ]; then
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/mkl/lib/intel64:/opt/intel/lib/intel64
  source /opt/intel/bin/compilervars.sh intel64
fi

# eclipse
export PATH="/usr/local/eclipse:$PATH"
alias eclipse-indigo="/usr/local/eclipse-indigo/eclipse"
alias sudo-eclipse-indigo="sudo /usr/local/eclipse-indigo/eclipse"

# mozc
alias mozc-config="/usr/lib/mozc/mozc_tool -mode=config_dialog"
alias mozc-dict="/usr/lib/mozc/mozc_tool --mode=dictionary_tool"

# wine
WINENOPULSE=1
# wine32
alias wine32='WINEARCH=win32 WINEPREFIX=~/.wine32 wine'
alias winebuild32='WINEARCH=win32 WINEPREFIX=~/.wine32 winebuild'
alias winecfg32='WINEARCH=win32 WINEPREFIX=~/.wine32 winecfg'
alias wineconsole32='WINEARCH=win32 WINEPREFIX=~/.wine32 wineconsole'
alias winecpp32='WINEARCH=win32 WINEPREFIX=~/.wine32 winecpp'
alias winedbg32='WINEARCH=win32 WINEPREFIX=~/.wine32 winedbg'
alias winedump32='WINEARCH=win32 WINEPREFIX=~/.wine32 winedump'
alias winefile32='WINEARCH=win32 WINEPREFIX=~/.wine32 winefile'
alias winegcc32='WINEARCH=win32 WINEPREFIX=~/.wine32 winegcc'
alias wineg++32='WINEARCH=win32 WINEPREFIX=~/.wine32 wineg++'
alias winepath32='WINEARCH=win32 WINEPREFIX=~/.wine32 winepath'
alias winetricks32='WINEARCH=win32 WINEPREFIX=~/.wine32 winetricks'

# Java
JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
export JAVA_HOME
PATH=$PATH:$JAVA_HOME/bin
export PATH

# ANTLR
export CLASSPATH="/usr/local/lib/antlr-4.5-complete.jar:$CLASSPATH"
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.5-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java org.antlr.v4.runtime.misc.TestRig'

# Windowsの"a --> a.exe"みたいな感じ
alias a='./a.out'

# nvm
if [ -f ~/.nvm/nvm.sh ]; then
  source ~/.nvm/nvm.sh
fi

# rbenv
if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# pyenv
if [ -d ~/.pyenv ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# plenv
if [ -d ~/.plenv ]; then
  export PATH="$HOME/.plenv/bin:$PATH"
  eval "$(plenv init -)"
fi

# nodebrew
if [ -d ~/.nodebrew ]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

# golang
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
export GOPATH=$HOME/go

# linuxbrew
export PATH='/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin':"$PATH"
export PATH=$PATH:/home/linuxbrew/.linuxbrew/opt/go/libexec/bin

# npm
#export PATH=$(npm bin -g):$PATH

# cabal
export PATH="$PATH:~/.cabal/bin"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# scala
export PATH="/usr/local/scala-2.11.7/bin:$PATH"

# play framework
export PLAY_HOME=/usr/local/play
export PATH=$PATH:$PLAY_HOME

# pbcopy
alias pbcopy='xsel --clipboard --input'

# clear screen
alias clear='tput reset'
