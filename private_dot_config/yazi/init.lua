-- function _format_time(time)
--
--
--
--
-- end

---@diagnostic disable: cast-local-type
function Linemode:size_and_mtime()
    local time = math.floor(self._file.cha.mtime or 0)
    if time == 0 then
        time = ""
    elseif os.date("%Y", time) == os.date("%Y") then
        time = os.date("%b %d %H:%M", time)
    else
        time = os.date("%b %d %Y ", time)
    end

    local size = self._file:size()
    return ui.Line(string.format("%s %s", size and ya.readable_size(size) or "", time))
end

function Linemode:mtime()
    local time = math.floor(self._file.cha.mtime or 0)
    if time == 0 then
        time = ""
    elseif os.date("%Y", time) == os.date("%Y") then
        time = os.date("%b %d %H:%M", time)
    else
        time = os.date("%b %d %Y ", time)
    end

    return ui.Line(string.format("%s", time))
end

function Linemode:ctime()
    local time = math.floor(self._file.cha.btime or 0)
    if time == 0 then
        time = ""
    elseif os.date("%Y", time) == os.date("%Y") then
        time = os.date("%b %d %H:%M", time)
    else
        time = os.date("%b %d %Y ", time)
    end

    return ui.Line(string.format("%s", time))
end
