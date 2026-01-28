-- ====================================================================
-- Copper Fever - Data\StaticData.lua
-- 静态数据表
-- Author: David W Zhang
-- ====================================================================

local CF = CopperFever

-- ====================================================================
-- 静态数据初始化
-- ====================================================================
CF.StaticData = CF.StaticData or {}
local SD = CF.StaticData

-- 初始化标志
SD.initialized = false

-- ====================================================================
-- 货币数据表
-- 按扩展版本和类型组织
-- ====================================================================
SD.Currencies = {
    -- 经典旧世
    [CF.EXPANSIONS.CLASSIC] = {
        -- 标准货币
        {id = 0, name = "Gold", type = CF.CURRENCY_TYPES.STANDARD, icon = 133784},
    },
    
    -- 燃烧的远征
    [CF.EXPANSIONS.TBC] = {
        {id = 1901, name = "Badge of Justice", type = CF.CURRENCY_TYPES.SPECIAL, icon = 133441},
    },
    
    -- 巫妖王之怒
    [CF.EXPANSIONS.WOTLK] = {
        {id = 101, name = "Emblem of Heroism", type = CF.CURRENCY_TYPES.SPECIAL, icon = 133441},
        {id = 102, name = "Emblem of Valor", type = CF.CURRENCY_TYPES.SPECIAL, icon = 133441},
        {id = 221, name = "Emblem of Conquest", type = CF.CURRENCY_TYPES.SPECIAL, icon = 133441},
        {id = 301, name = "Emblem of Triumph", type = CF.CURRENCY_TYPES.SPECIAL, icon = 133441},
        {id = 341, name = "Emblem of Frost", type = CF.CURRENCY_TYPES.SPECIAL, icon = 133441},
    },
    
    -- 大地的裂变
    [CF.EXPANSIONS.CATACLYSM] = {
        {id = 395, name = "Justice Points", type = CF.CURRENCY_TYPES.SPECIAL, icon = 133441},
        {id = 396, name = "Valor Points", type = CF.CURRENCY_TYPES.SPECIAL, icon = 133441},
    },
    
    -- 熊猫人之谜
    [CF.EXPANSIONS.MOP] = {
        {id = 697, name = "Elder Charm of Good Fortune", type = CF.CURRENCY_TYPES.SPECIAL, icon = 237282},
        {id = 738, name = "Lesser Charm of Good Fortune", type = CF.CURRENCY_TYPES.SPECIAL, icon = 237281},
        {id = 752, name = "Mogu Rune of Fate", type = CF.CURRENCY_TYPES.SPECIAL, icon = 645218},
        {id = 776, name = "Warforged Seal", type = CF.CURRENCY_TYPES.SPECIAL, icon = 627534},
        {id = 777, name = "Timeless Coin", type = CF.CURRENCY_TYPES.SPECIAL, icon = 237282},
    },
    
    -- 德拉诺之王
    [CF.EXPANSIONS.WOD] = {
        {id = 823, name = "Apexis Crystal", type = CF.CURRENCY_TYPES.SPECIAL, icon = 1062738},
        {id = 824, name = "Garrison Resources", type = CF.CURRENCY_TYPES.SPECIAL, icon = 1005027},
        {id = 910, name = "Secret of Draenor Alchemy", type = CF.CURRENCY_TYPES.SPECIAL, icon = 237171},
        {id = 994, name = "Seal of Tempered Fate", type = CF.CURRENCY_TYPES.SPECIAL, icon = 1129161},
        {id = 1101, name = "Oil", type = CF.CURRENCY_TYPES.SPECIAL, icon = 1044089},
    },
    
    -- 军团再临
    [CF.EXPANSIONS.LEGION] = {
        {id = 1155, name = "Ancient Mana", type = CF.CURRENCY_TYPES.SPECIAL, icon = 1417744},
        {id = 1220, name = "Order Resources", type = CF.CURRENCY_TYPES.SPECIAL, icon = 1397630},
        {id = 1226, name = "Nethershard", type = CF.CURRENCY_TYPES.SPECIAL, icon = 1530375},
        {id = 1273, name = "Seal of Broken Fate", type = CF.CURRENCY_TYPES.SPECIAL, icon = 1604167},
        {id = 1275, name = "Curious Coin", type = CF.CURRENCY_TYPES.SPECIAL, icon = 1604168},
        {id = 1342, name = "Legionfall War Supplies", type = CF.CURRENCY_TYPES.SPECIAL, icon = 1530995},
        {id = 1508, name = "Veiled Argunite", type = CF.CURRENCY_TYPES.SPECIAL, icon = 1064188},
        {id = 1533, name = "Wakening Essence", type = CF.CURRENCY_TYPES.SPECIAL, icon = 1686582},
    },
    
    -- 争霸艾泽拉斯
    [CF.EXPANSIONS.BFA] = {
        {id = 1560, name = "War Resources", type = CF.CURRENCY_TYPES.SPECIAL, icon = 2032592},
        {id = 1580, name = "Seal of Wartorn Fate", type = CF.CURRENCY_TYPES.SPECIAL, icon = 2032600},
        {id = 1710, name = "Seafarer's Dubloon", type = CF.CURRENCY_TYPES.SPECIAL, icon = 2032592},
        {id = 1717, name = "Service Medal", type = CF.CURRENCY_TYPES.SPECIAL, icon = 2032592},
        {id = 1718, name = "Titan Residuum", type = CF.CURRENCY_TYPES.SPECIAL, icon = 2032897},
        {id = 1721, name = "Prismatic Manapearl", type = CF.CURRENCY_TYPES.SPECIAL, icon = 2917326},
        {id = 1755, name = "Coalescing Visions", type = CF.CURRENCY_TYPES.SPECIAL, icon = 3015740},
        {id = 1803, name = "Echoes of Ny'alotha", type = CF.CURRENCY_TYPES.SPECIAL, icon = 3015741},
    },
    
    -- 暗影国度
    [CF.EXPANSIONS.SHADOWLANDS] = {
        {id = 1813, name = "Reservoir Anima", type = CF.CURRENCY_TYPES.SPECIAL, icon = 3528288},
        {id = 1820, name = "Infused Ruby", type = CF.CURRENCY_TYPES.SPECIAL, icon = 3536182},
        {id = 1828, name = "Soul Ash", type = CF.CURRENCY_TYPES.SPECIAL, icon = 3743738},
        {id = 1877, name = "Stygia", type = CF.CURRENCY_TYPES.SPECIAL, icon = 3743739},
        {id = 1885, name = "Grateful Offering", type = CF.CURRENCY_TYPES.SPECIAL, icon = 3601547},
        {id = 1906, name = "Soul Cinders", type = CF.CURRENCY_TYPES.SPECIAL, icon = 4067362},
        {id = 1931, name = "Cataloged Research", type = CF.CURRENCY_TYPES.SPECIAL, icon = 4038106},
        {id = 1979, name = "Cyphers of the First Ones", type = CF.CURRENCY_TYPES.SPECIAL, icon = 4217721},
        {id = 1977, name = "Stygian Ember", type = CF.CURRENCY_TYPES.SPECIAL, icon = 4217722},
    },
    
    -- 巨龙时代
    [CF.EXPANSIONS.DRAGONFLIGHT] = {
        {id = 2003, name = "Dragon Isles Supplies", type = CF.CURRENCY_TYPES.SPECIAL, icon = 4643977},
        {id = 2009, name = "Cosmic Flux", type = CF.CURRENCY_TYPES.SPECIAL, icon = 4381155},
        {id = 2118, name = "Elemental Overflow", type = CF.CURRENCY_TYPES.SPECIAL, icon = 4643977},
        {id = 2122, name = "Storm Sigil", type = CF.CURRENCY_TYPES.SPECIAL, icon = 4638724},
        {id = 2123, name = "Bloody Token", type = CF.CURRENCY_TYPES.SPECIAL, icon = 4548862},
        {id = 2245, name = "Flightstones", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5172980},
        {id = 2411, name = "Wyrm's Awakened Crest", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5646097},
        {id = 2412, name = "Drake's Awakened Crest", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5646095},
        {id = 2413, name = "Aspect's Awakened Crest", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5646092},
        {id = 2657, name = "Mysterious Fragment", type = CF.CURRENCY_TYPES.SPECIAL, icon = 237282},
        {id = 2706, name = "Whelpling's Awakened Crest", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5646101},
    },
    
    -- 地心之战
    [CF.EXPANSIONS.TWW] = {
        {id = 2806, name = "Undercoin", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5899325},
        {id = 2807, name = "Mereldar Derby Mark", type = CF.CURRENCY_TYPES.SPECIAL, icon = 1064188},
        {id = 2809, name = "Valorstones", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5899330},
        {id = 2813, name = "Radiant Echo", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5899331},
        {id = 2815, name = "Resonance Crystals", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5899328},
        {id = 2817, name = "Carved Harbinger Crest", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5872034},
        {id = 2914, name = "Weathered Harbinger Crest", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5872036},
        {id = 2915, name = "Runed Harbinger Crest", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5872035},
        {id = 2916, name = "Gilded Harbinger Crest", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5872033},
        {id = 3008, name = "Valorbound Medallion", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5899329},
        {id = 3028, name = "Restored Coffer Key", type = CF.CURRENCY_TYPES.SPECIAL, icon = 237446},
    },
}

-- ====================================================================
-- 声望数据表
-- ====================================================================
SD.Reputations = {
    -- 经典旧世 - 联盟
    {id = 72, name = "Stormwind", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 47, name = "Ironforge", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 54, name = "Gnomeregan", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 69, name = "Darnassus", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 930, name = "Exodar", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.CLASSIC},
    
    -- 经典旧世 - 部落
    {id = 76, name = "Orgrimmar", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 68, name = "Undercity", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 81, name = "Thunder Bluff", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 530, name = "Darkspear Trolls", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 911, name = "Silvermoon City", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.CLASSIC},
    
    -- 经典旧世 - 中立
    {id = 21, name = "Booty Bay", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 577, name = "Everlook", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 369, name = "Gadgetzan", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 470, name = "Ratchet", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 909, name = "Darkmoon Faire", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CLASSIC},
    
    -- 燃烧的远征
    {id = 932, name = "The Aldor", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 934, name = "The Scryers", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 935, name = "The Sha'tar", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 942, name = "Cenarion Expedition", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 946, name = "Honor Hold", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.TBC},
    {id = 947, name = "Thrallmar", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.TBC},
    {id = 989, name = "Keepers of Time", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 1011, name = "Lower City", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 1012, name = "Ashtongue Deathsworn", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 1015, name = "Netherwing", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 1031, name = "Sha'tari Skyguard", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 1038, name = "Ogri'la", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 1077, name = "Shattered Sun Offensive", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    
    -- 巫妖王之怒
    {id = 1037, name = "Alliance Vanguard", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1052, name = "Horde Expedition", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1050, name = "Valiance Expedition", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1067, name = "The Hand of Vengeance", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1068, name = "Explorers' League", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1085, name = "Warsong Offensive", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1090, name = "Kirin Tor", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1091, name = "The Wyrmrest Accord", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1098, name = "Knights of the Ebon Blade", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1106, name = "Argent Crusade", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1119, name = "The Sons of Hodir", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1156, name = "The Ashen Verdict", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOTLK},
    
    -- 大地的裂变
    {id = 1135, name = "The Earthen Ring", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CATACLYSM},
    {id = 1158, name = "Guardians of Hyjal", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CATACLYSM},
    {id = 1171, name = "Therazane", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CATACLYSM},
    {id = 1172, name = "Dragonmaw Clan", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.CATACLYSM},
    {id = 1173, name = "Ramkahen", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CATACLYSM},
    {id = 1174, name = "Wildhammer Clan", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.CATACLYSM},
    {id = 1177, name = "Baradin's Wardens", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.CATACLYSM},
    {id = 1178, name = "Hellscream's Reach", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.CATACLYSM},
    {id = 1204, name = "Avengers of Hyjal", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CATACLYSM},
    
    -- 熊猫人之谜
    {id = 1269, name = "Golden Lotus", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1270, name = "Shado-Pan", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1271, name = "Order of the Cloud Serpent", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1272, name = "The Tillers", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1302, name = "The Anglers", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1337, name = "The Klaxxi", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1341, name = "The August Celestials", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1345, name = "The Lorewalkers", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1359, name = "The Black Prince", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1375, name = "Dominance Offensive", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.MOP},
    {id = 1376, name = "Operation: Shieldwall", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.MOP},
    {id = 1387, name = "Kirin Tor Offensive", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.MOP},
    {id = 1388, name = "Sunreaver Onslaught", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.MOP},
    {id = 1435, name = "Shado-Pan Assault", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1492, name = "Emperor Shaohao", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    
    -- 德拉诺之王
    {id = 1445, name = "Frostwolf Orcs", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.WOD},
    {id = 1515, name = "Arakkoa Outcasts", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOD},
    {id = 1520, name = "Shadowmoon Exiles", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.WOD},
    {id = 1681, name = "Vol'jin's Headhunters", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.WOD},
    {id = 1682, name = "Wrynn's Vanguard", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.WOD},
    {id = 1708, name = "Laughing Skull Orcs", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.WOD},
    {id = 1710, name = "Sha'tari Defense", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.WOD},
    {id = 1711, name = "Steamwheedle Preservation Society", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOD},
    {id = 1731, name = "Council of Exarchs", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.WOD},
    {id = 1847, name = "Hand of the Prophet", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.WOD},
    {id = 1848, name = "Vol'jin's Spear", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.WOD},
    {id = 1849, name = "Order of the Awakened", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOD},
    {id = 1850, name = "The Saberstalkers", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOD},
    
    -- 军团再临
    {id = 1883, name = "Dreamweavers", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 1828, name = "Highmountain Tribe", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 1859, name = "The Nightfallen", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 1894, name = "The Wardens", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 1900, name = "Court of Farondis", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 1948, name = "Valarjar", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 2045, name = "Armies of Legionfall", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 2165, name = "Army of the Light", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 2170, name = "Argussian Reach", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    
    -- 争霸艾泽拉斯 - 联盟
    {id = 2159, name = "7th Legion", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.BFA},
    {id = 2160, name = "Proudmoore Admiralty", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.BFA},
    {id = 2161, name = "Order of Embers", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.BFA},
    {id = 2162, name = "Storm's Wake", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.BFA},
    
    -- 争霸艾泽拉斯 - 部落
    {id = 2103, name = "Zandalari Empire", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.BFA},
    {id = 2156, name = "Talanji's Expedition", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.BFA},
    {id = 2157, name = "The Honorbound", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.BFA},
    {id = 2158, name = "Voldunai", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.BFA},
    
    -- 争霸艾泽拉斯 - 中立
    {id = 2163, name = "Tortollan Seekers", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.BFA},
    {id = 2164, name = "Champions of Azeroth", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.BFA},
    {id = 2373, name = "The Unshackled", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.BFA},
    {id = 2391, name = "Rustbolt Resistance", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.BFA},
    {id = 2400, name = "Waveblade Ankoan", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.BFA},
    {id = 2415, name = "Rajani", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.BFA},
    {id = 2417, name = "Uldum Accord", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.BFA},
    
    -- 暗影国度
    {id = 2407, name = "The Ascended", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2410, name = "The Undying Army", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2413, name = "Court of Harvesters", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2432, name = "Ve'nari", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2439, name = "The Avowed", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2465, name = "The Wild Hunt", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2472, name = "The Archivists' Codex", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2478, name = "The Enlightened", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2464, name = "Death's Advance", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    
    -- 巨龙时代
    {id = 2503, name = "Maruuk Centaur", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2507, name = "Dragonscale Expedition", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2510, name = "Valdrakken Accord", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2511, name = "Iskaara Tuskarr", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2523, name = "Dark Talons", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2524, name = "Obsidian Warders", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2526, name = "Wrathion", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2544, name = "Artisan's Consortium - Dragon Isles Branch", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2550, name = "Cobalt Assembly", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2564, name = "Loamm Niffen", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2574, name = "Dream Wardens", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    
    -- 地心之战
    {id = 2570, name = "Council of Dornogal", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TWW},
    {id = 2590, name = "The Assembly of the Deeps", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TWW},
    {id = 2594, name = "Hallowfall Arathi", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TWW},
    {id = 2600, name = "The Severed Threads", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TWW},
    {id = 2601, name = "The General", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TWW},
    {id = 2605, name = "The Vizier", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TWW},
    {id = 2607, name = "The Weaver", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TWW},
}

-- ====================================================================
-- 地图与货币的默认关联关系
-- ====================================================================
SD.MapCurrencyAssociations = {
    -- 巨龙时代区域
    [2022] = {2003, 2245, 2706, 2411, 2412, 2413},  -- The Waking Shores
    [2023] = {2003, 2245, 2706, 2411, 2412, 2413},  -- Ohn'ahran Plains
    [2024] = {2003, 2245, 2706, 2411, 2412, 2413},  -- The Azure Span
    [2025] = {2003, 2245, 2706, 2411, 2412, 2413},  -- Thaldraszus
    [2133] = {2003, 2245, 2118, 2657},              -- Zaralek Cavern
    [2200] = {2003, 2245, 2657},                    -- Emerald Dream
    
    -- 地心之战区域
    [2248] = {2809, 2815, 2914, 2817, 2915, 2916, 3008, 3028},  -- Isle of Dorn
    [2214] = {2809, 2815, 2914, 2817, 2915, 2916, 3008, 3028},  -- The Ringing Deeps
    [2215] = {2809, 2815, 2914, 2817, 2915, 2916, 3008, 3028},  -- Hallowfall
    [2255] = {2809, 2815, 2914, 2817, 2915, 2916, 3008, 3028},  -- Azj-Kahet
}

-- ====================================================================
-- 地图与声望的默认关联关系
-- ====================================================================
SD.MapReputationAssociations = {
    -- 巨龙时代区域
    [2022] = {2507, 2510, 2523},          -- The Waking Shores
    [2023] = {2503, 2507, 2510},          -- Ohn'ahran Plains
    [2024] = {2507, 2510, 2511},          -- The Azure Span
    [2025] = {2507, 2510, 2524},          -- Thaldraszus
    [2133] = {2564},                       -- Zaralek Cavern
    [2200] = {2574},                       -- Emerald Dream
    
    -- 地心之战区域
    [2248] = {2570},                       -- Isle of Dorn
    [2214] = {2590},                       -- The Ringing Deeps
    [2215] = {2594},                       -- Hallowfall
    [2255] = {2600},                       -- Azj-Kahet
}

-- ====================================================================
-- 辅助函数：获取货币信息
-- ====================================================================
function SD:GetCurrencyData(currencyID)
    if type(currencyID) ~= "number" then return nil end
    
    for expansion, currencies in pairs(self.Currencies) do
        if type(currencies) == "table" then
            for _, currency in ipairs(currencies) do
                if type(currency) == "table" and currency.id == currencyID then
                    return currency
                end
            end
        end
    end
    
    return nil
end

-- 获取声望信息
function SD:GetReputationData(factionID)
    if type(factionID) ~= "number" then return nil end
    
    for _, reputation in ipairs(self.Reputations) do
        if type(reputation) == "table" and reputation.id == factionID then
            return reputation
        end
    end
    
    return nil
end

-- 获取扩展版本的所有货币
function SD:GetCurrenciesByExpansion(expansion)
    if type(expansion) ~= "number" then return {} end
    
    return self.Currencies[expansion] or {}
end

-- 获取扩展版本的所有声望
function SD:GetReputationsByExpansion(expansion)
    if type(expansion) ~= "number" then return {} end
    
    local result = {}
    for _, reputation in ipairs(self.Reputations) do
        if type(reputation) == "table" and reputation.expansion == expansion then
            table.insert(result, reputation)
        end
    end
    
    return result
end

-- 获取阵营的所有声望
function SD:GetReputationsByFaction(faction)
    if type(faction) ~= "number" then return {} end
    
    local result = {}
    for _, reputation in ipairs(self.Reputations) do
        if type(reputation) == "table" and 
           (reputation.faction == faction or reputation.faction == CF.FACTIONS.NEUTRAL) then
            table.insert(result, reputation)
        end
    end
    
    return result
end

-- 通过名称搜索货币
function SD:FindCurrencyByName(name)
    if type(name) ~= "string" or name == "" then return nil end
    
    local lowerName = name:lower()
    
    for expansion, currencies in pairs(self.Currencies) do
        if type(currencies) == "table" then
            for _, currency in ipairs(currencies) do
                if type(currency) == "table" and 
                   type(currency.name) == "string" and
                   currency.name:lower():find(lowerName, 1, true) then
                    return currency
                end
            end
        end
    end
    
    return nil
end

-- 通过名称搜索声望
function SD:FindReputationByName(name)
    if type(name) ~= "string" or name == "" then return nil end
    
    local lowerName = name:lower()
    
    for _, reputation in ipairs(self.Reputations) do
        if type(reputation) == "table" and 
           type(reputation.name) == "string" and
           reputation.name:lower():find(lowerName, 1, true) then
            return reputation
        end
    end
    
    return nil
end

-- 获取所有货币ID列表
function SD:GetAllCurrencyIDs()
    local result = {}
    
    for expansion, currencies in pairs(self.Currencies) do
        if type(currencies) == "table" then
            for _, currency in ipairs(currencies) do
                if type(currency) == "table" and currency.id then
                    table.insert(result, currency.id)
                end
            end
        end
    end
    
    return result
end

-- 获取所有声望ID列表
function SD:GetAllReputationIDs()
    local result = {}
    
    for _, reputation in ipairs(self.Reputations) do
        if type(reputation) == "table" and reputation.id then
            table.insert(result, reputation.id)
        end
    end
    
    return result
end

-- 验证数据完整性
function SD:ValidateData()
    CF:LogInfo("验证静态数据完整性...")
    
    local currencyCount = 0
    local reputationCount = 0
    local errors = 0
    
    -- 验证货币数据
    for expansion, currencies in pairs(self.Currencies) do
        if type(currencies) == "table" then
            for _, currency in ipairs(currencies) do
                if type(currency) == "table" then
                    if not currency.id or not currency.name then
                        CF:LogError("货币数据不完整: expansion=%s", tostring(expansion))
                        errors = errors + 1
                    else
                        currencyCount = currencyCount + 1
                    end
                end
            end
        end
    end
    
    -- 验证声望数据
    for _, reputation in ipairs(self.Reputations) do
        if type(reputation) == "table" then
            if not reputation.id or not reputation.name then
                CF:LogError("声望数据不完整")
                errors = errors + 1
            else
                reputationCount = reputationCount + 1
            end
        end
    end
    
    -- 验证地图关联
    local mapCurrencyCount = 0
    local mapReputationCount = 0
    
    for mapID, currencies in pairs(self.MapCurrencyAssociations) do
        if type(currencies) == "table" then
            mapCurrencyCount = mapCurrencyCount + 1
        end
    end
    
    for mapID, reputations in pairs(self.MapReputationAssociations) do
        if type(reputations) == "table" then
            mapReputationCount = mapReputationCount + 1
        end
    end
    
    CF:LogInfo("数据验证完成:")
    CF:LogInfo("  货币: %d", currencyCount)
    CF:LogInfo("  声望: %d", reputationCount)
    CF:LogInfo("  地图货币关联: %d", mapCurrencyCount)
    CF:LogInfo("  地图声望关联: %d", mapReputationCount)
    CF:LogInfo("  错误: %d", errors)
    
    return errors == 0
end

-- 初始化静态数据
function SD:Initialize()
    if self.initialized then
        CF:LogWarning("StaticData 已经初始化过了")
        return
    end
    
    CF:LogInfo("初始化静态数据...")
    
    -- 验证数据完整性
    self:ValidateData()
    
    self.initialized = true
    CF:LogInfo("静态数据初始化完成")
end

-- 获取统计信息
function SD:GetStatistics()
    local stats = {
        totalCurrencies = 0,
        totalReputations = #self.Reputations,
        currenciesByExpansion = {},
        reputationsByExpansion = {},
        reputationsByFaction = {
            [CF.FACTIONS.ALLIANCE] = 0,
            [CF.FACTIONS.HORDE] = 0,
            [CF.FACTIONS.NEUTRAL] = 0,
        },
    }
    
    -- 统计货币
    for expansion, currencies in pairs(self.Currencies) do
        if type(currencies) == "table" then
            local count = #currencies
            stats.totalCurrencies = stats.totalCurrencies + count
            stats.currenciesByExpansion[expansion] = count
        end
    end
    
    -- 统计声望
    for _, reputation in ipairs(self.Reputations) do
        if type(reputation) == "table" then
            local exp = reputation.expansion
            stats.reputationsByExpansion[exp] = (stats.reputationsByExpansion[exp] or 0) + 1
            
            local fac = reputation.faction
            if stats.reputationsByFaction[fac] then
                stats.reputationsByFaction[fac] = stats.reputationsByFaction[fac] + 1
            end
        end
    end
    
    return stats
end

-- 打印统计信息
function SD:PrintStatistics()
    local stats = self:GetStatistics()
    
    CF:LogInfo("=== 静态数据统计 ===")
    CF:LogInfo("总货币数: %d", stats.totalCurrencies)
    CF:LogInfo("总声望数: %d", stats.totalReputations)
    CF:LogInfo("")
    CF:LogInfo("按扩展版本分类:")
    for exp = CF.EXPANSIONS.CLASSIC, CF.EXPANSIONS.TWW do
        local currCount = stats.currenciesByExpansion[exp] or 0
        local repCount = stats.reputationsByExpansion[exp] or 0
        if currCount > 0 or repCount > 0 then
            CF:LogInfo("  %s: %d 货币, %d 声望", 
                      CF:GetExpansionLocalizedName(exp), currCount, repCount)
        end
    end
    CF:LogInfo("")
    CF:LogInfo("按阵营分类:")
    CF:LogInfo("  联盟: %d", stats.reputationsByFaction[CF.FACTIONS.ALLIANCE])
    CF:LogInfo("  部落: %d", stats.reputationsByFaction[CF.FACTIONS.HORDE])
    CF:LogInfo("  中立: %d", stats.reputationsByFaction[CF.FACTIONS.NEUTRAL])
    CF:LogInfo("==================")
end

-- ====================================================================
-- 结束标记
-- ====================================================================