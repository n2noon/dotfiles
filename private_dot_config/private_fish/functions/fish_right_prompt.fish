function fish_right_prompt --description 'Write out the right prompt'
    set -l time_color (set_color 666666)
    # How long did the last command take?
    if test $CMD_DURATION -ne 0
        echo $time_color (echo "$CMD_DURATION 1000" | awk '{printf "%.3fs", $1 / $2}')
        set CMD_DURATION 0
    end
    # Time last command was run
    echo $time_color (date +'%H:%M:%S')
    set_color normal
end
