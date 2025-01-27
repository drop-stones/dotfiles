if [[ $(uname -s) == "Linux" && ! $(uname -r) =~ "Microsoft" ]]; then
  export GTK_IM_MODULE=fcitx5
  export QT_IM_MODULE=fcitx5
  export XMODIFIERS=@im=fcitx5
  export INPUT_METHOD=fcitx5
fi
