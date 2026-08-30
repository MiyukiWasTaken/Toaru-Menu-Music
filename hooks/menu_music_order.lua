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
        if entry.track then
            return entry.track
        end

        if entry.id then
            return entry.id
        end
    end

    return nil
end

local function reorder_menu_music_list(list)
    if type(list) ~= "table" then
        return list
    end

    local ordered = {}
    local seen = {}

    for _, music_id in ipairs(menu_music_order) do
        for _, entry in ipairs(list) do
            local entry_id = get_track_id(entry)
            if entry_id == music_id and not seen[music_id] then
                table.insert(ordered, entry)
                seen[music_id] = true
                break
            end
        end
    end

    for _, entry in ipairs(list) do
        local entry_id = get_track_id(entry)
        if entry_id and not seen[entry_id] then
            table.insert(ordered, entry)
            seen[entry_id] = true
        end
    end

    return ordered
end

Hooks:PostHook(TweakData, "init", "toaru_menu_music_order_reorder", function(self)
    if not self.music or type(self.music.track_menu_list) ~= "table" then
        return
    end

    self.music.track_menu_list = reorder_menu_music_list(self.music.track_menu_list)
end)
