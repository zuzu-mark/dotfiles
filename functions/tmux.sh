# tmux 自動ロギング
    if [[ $TERM = screen ]] || [[ $TERM = screen-256color ]]; then
        #[[ x${DOTFILES_INSTALL_DIR} = x"" ]] && echo TMUX-LOG-NG && return
        LOGDIR=${HOME}/.tmux/log
        LOGFILE=$(hostname)_$(date +%Y-%m-%d_%H%M%S_%N.log)
        FILECOUNT=0
        MAXFILECOUNT=30 #ここを好きな保存ファイル数に変える。
        # zsh起動時に自動で$MAXFILECOUNTのファイル数以上ログファイルあれば消す
        for file in $(\find "$LOGDIR" -maxdepth 1 -type f -name "*.log" | sort --reverse); do
            FILECOUNT=$(expr $FILECOUNT + 1)
            if [ $FILECOUNT -ge $MAXFILECOUNT ]; then
                rm -f $file
            fi
        done
        [ ! -d $LOGDIR ] && mkdir -p $LOGDIR
        #tmux set-option default-terminal "screen" \; \
        #    pipe-pane "cat >> $LOGDIR/$LOGFILE" \; \
        #display-message  " Started logging to $LOGDIR/$LOGFILE"
    fi
