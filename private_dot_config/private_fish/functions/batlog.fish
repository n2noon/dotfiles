function batlog --description 'See tail of log, refreshed realtime' --argument-names file
    tail -f $file | bat --paging=never -l log
end
