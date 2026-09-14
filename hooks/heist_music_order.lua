local heist_music_order = {
    "new-fight"
}

local function get_heist_music_id(entry)
    if type(entry) == "string" then
        return entry
    end

    if type(entry) == "table" then
        return entry.track or entry.id
    end

    return nil
end

local function reorder_heist_music_list(list)
    local ordered = {}
    local used = {}

    for _, wanted_id in ipairs(heist_music_order) do
        for index, entry in ipairs(list) do
            local entry_id = get_heist_music_id(entry)

            if not used[index] and entry_id == wanted_id then
                table.insert(ordered, entry)
                used[index] = true
                break
            end
        end
    end

    for index, entry in ipairs(list) do
        if not used[index] then
            table.insert(ordered, entry)
        end
    end

    return ordered
end

Hooks:PostHook(
    MusicManager,
    "init",
    "ToaruHeistMusicOrder",
    function(self)
        if not tweak_data.music then
            return
        end

        local track_list = tweak_data.music.track_list

        if type(track_list) ~= "table" then
            return
        end

        tweak_data.music.track_list =
            reorder_heist_music_list(track_list)
    end
)