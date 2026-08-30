local menu_music_order = {
    "index-1_omen",
    "index-1_destiny-begins",
    "index-1_overdrive",
    "index-1_entry-to-darkness",
    "index-1_emptiness",
    "index-1_impatience",
    "index-1_academy-city",
    "index-1_daily-life",
    "index-1_hurry-up",
    "index-1_heat-island",
    "index-1_calm-days",
    "index-1_strain",
    "index-1_great-power",
    "index-1_curse",
    "index-1_one-way-road",
    "index-1_that-which-emerges-from-obscurity",
    "index-1_alchemy",
    "index-1_runaway",
    "index-1_anger",
    "index-1_king-of-witch-hunters",
    "index-1_time-limit",
    "index-1_vampire-killer",
    "index-1_the-thing-you-lost",
    "index-1_confusion",
    "index-1_imagine-breaker",
    "index-1_power-to-confront",
    "index-1_summer-sunshine",
    "index-1_with-the-usual-friend",
    "index-1_im-hungry",
    "index-1_index",
    "index-1_road-to-school",
    "index-1_funny-days",
    "index-1_super-mobile-girl-kanamin-theme",
    "index-1_daily-life-for-the-miss",
    "index-1_sector-i-five-elements-institution",
    "index-1_despair",
    "index-1_impatience-2",
    "index-1_turnabout",
    "index-1_the-thing-you-wanted",
    "index-1_inhuman-one",
    "index-1_magic-society",
    "index-1_into-darkness",
    "index-1_stillness-of-light",
    "index-1_breakthrough",
    "index-1_in-a-heart",
    "index-1_ones-one-feelings",
    "index-1_nice-conclusion",
    "index-1_feather-of-light",
    "index-1_the-thing-you-cant-get-back",
    "index-1_then-once-more"
}

local function get_track_id(entry)
    if type(entry) == "string" then
        return entry
    end

    if type(entry) == "table" then
        return entry.track or entry.id
    end

    return nil
end

local function reorder_menu_music_list(list)
    local ordered = {}
    local used = {}

    for _, wanted_id in ipairs(menu_music_order) do
        for _, entry in ipairs(list) do
            local track_id = get_track_id(entry)

            if track_id == wanted_id and not used[track_id] then
                table.insert(ordered, entry)
                used[track_id] = true
                break
            end
        end
    end

    for _, entry in ipairs(list) do
        local track_id = get_track_id(entry)

        if not track_id or not used[track_id] then
            table.insert(ordered, entry)

            if track_id then
                used[track_id] = true
            end
        end
    end

    return ordered
end

Hooks:PostHook(
    MusicManager,
    "init",
    "ToaruMenuMusicOrder",
    function(self)
        if not tweak_data.music then
            return
        end

        local track_menu_list = tweak_data.music.track_menu_list

        if type(track_menu_list) ~= "table" then
            return
        end

        tweak_data.music.track_menu_list =
            reorder_menu_music_list(track_menu_list)
    end
)