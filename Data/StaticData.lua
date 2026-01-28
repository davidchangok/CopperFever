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
        {id = 3028, name = "Restored Coffer Key", type = CF.CURRENCY_TYPES.SPECIAL, icon = 5899326},
    },
}

-- ====================================================================
-- 地图数据表
-- 包含主要区域的地图ID和名称
-- ====================================================================
SD.Maps = {
    -- 经典旧世 - 东部王国
    [1415] = {name = "Eastern Kingdoms", type = CF.MAP_TYPES.CONTINENT, expansion = CF.EXPANSIONS.CLASSIC, parentID = 0},
    [1453] = {name = "Stormwind City", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.CLASSIC, parentID = 1415},
    [1429] = {name = "Elwynn Forest", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.CLASSIC, parentID = 1415},
    [1431] = {name = "Duskwood", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.CLASSIC, parentID = 1415},
    [1433] = {name = "Redridge Mountains", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.CLASSIC, parentID = 1415},
    [1432] = {name = "Westfall", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.CLASSIC, parentID = 1415},
    
    -- 经典旧世 - 卡利姆多
    [1414] = {name = "Kalimdor", type = CF.MAP_TYPES.CONTINENT, expansion = CF.EXPANSIONS.CLASSIC, parentID = 0},
    [1454] = {name = "Orgrimmar", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.CLASSIC, parentID = 1414},
    [1411] = {name = "Durotar", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.CLASSIC, parentID = 1414},
    [1412] = {name = "Mulgore", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.CLASSIC, parentID = 1414},
    [1413] = {name = "The Barrens", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.CLASSIC, parentID = 1414},
    
    -- 燃烧的远征
    [1944] = {name = "Outland", type = CF.MAP_TYPES.CONTINENT, expansion = CF.EXPANSIONS.TBC, parentID = 0},
    [1955] = {name = "Shattrath City", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.TBC, parentID = 1944},
    [1946] = {name = "Hellfire Peninsula", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.TBC, parentID = 1944},
    [1948] = {name = "Zangarmarsh", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.TBC, parentID = 1944},
    [1949] = {name = "Nagrand", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.TBC, parentID = 1944},
    [1952] = {name = "Netherstorm", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.TBC, parentID = 1944},
    
    -- 巫妖王之怒
    [113] = {name = "Northrend", type = CF.MAP_TYPES.CONTINENT, expansion = CF.EXPANSIONS.WOTLK, parentID = 0},
    [125] = {name = "Dalaran", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.WOTLK, parentID = 113},
    [114] = {name = "Borean Tundra", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.WOTLK, parentID = 113},
    [115] = {name = "Dragonblight", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.WOTLK, parentID = 113},
    [116] = {name = "Grizzly Hills", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.WOTLK, parentID = 113},
    [117] = {name = "Howling Fjord", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.WOTLK, parentID = 113},
    [118] = {name = "Icecrown", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.WOTLK, parentID = 113},
    
    -- 熊猫人之谜
    [424] = {name = "Pandaria", type = CF.MAP_TYPES.CONTINENT, expansion = CF.EXPANSIONS.MOP, parentID = 0},
    [431] = {name = "Vale of Eternal Blossoms", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.MOP, parentID = 424},
    [418] = {name = "Krasarang Wilds", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.MOP, parentID = 424},
    [422] = {name = "Dread Wastes", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.MOP, parentID = 424},
    [554] = {name = "Timeless Isle", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.MOP, parentID = 424},
    
    -- 德拉诺之王
    [572] = {name = "Draenor", type = CF.MAP_TYPES.CONTINENT, expansion = CF.EXPANSIONS.WOD, parentID = 0},
    [588] = {name = "Ashran", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.WOD, parentID = 572},
    [535] = {name = "Frostfire Ridge", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.WOD, parentID = 572},
    [539] = {name = "Shadowmoon Valley", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.WOD, parentID = 572},
    [542] = {name = "Spires of Arak", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.WOD, parentID = 572},
    [550] = {name = "Nagrand", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.WOD, parentID = 572},
    
    -- 军团再临
    [619] = {name = "Broken Isles", type = CF.MAP_TYPES.CONTINENT, expansion = CF.EXPANSIONS.LEGION, parentID = 0},
    [627] = {name = "Dalaran", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.LEGION, parentID = 619},
    [630] = {name = "Azsuna", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.LEGION, parentID = 619},
    [634] = {name = "Stormheim", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.LEGION, parentID = 619},
    [641] = {name = "Val'sharah", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.LEGION, parentID = 619},
    [646] = {name = "Broken Shore", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.LEGION, parentID = 619},
    [650] = {name = "Highmountain", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.LEGION, parentID = 619},
    [830] = {name = "Krokuun", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.LEGION, parentID = 619},
    [885] = {name = "Antoran Wastes", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.LEGION, parentID = 619},
    
    -- 争霸艾泽拉斯 - 库尔提拉斯
    [876] = {name = "Kul Tiras", type = CF.MAP_TYPES.CONTINENT, expansion = CF.EXPANSIONS.BFA, parentID = 0},
    [895] = {name = "Tiragarde Sound", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.BFA, parentID = 876},
    [896] = {name = "Drustvar", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.BFA, parentID = 876},
    [942] = {name = "Stormsong Valley", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.BFA, parentID = 876},
    
    -- 争霸艾泽拉斯 - 赞达拉
    [875] = {name = "Zandalar", type = CF.MAP_TYPES.CONTINENT, expansion = CF.EXPANSIONS.BFA, parentID = 0},
    [862] = {name = "Zuldazar", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.BFA, parentID = 875},
    [863] = {name = "Nazmir", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.BFA, parentID = 875},
    [864] = {name = "Vol'dun", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.BFA, parentID = 875},
    
    -- 争霸艾泽拉斯 - 其他
    [1462] = {name = "Mechagon", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.BFA, parentID = 876},
    [1527] = {name = "Uldum", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.BFA, parentID = 1414},
    [1530] = {name = "Vale of Eternal Blossoms", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.BFA, parentID = 424},
    
    -- 暗影国度
    [1550] = {name = "The Shadowlands", type = CF.MAP_TYPES.CONTINENT, expansion = CF.EXPANSIONS.SHADOWLANDS, parentID = 0},
    [1565] = {name = "Ardenweald", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.SHADOWLANDS, parentID = 1550},
    [1533] = {name = "Bastion", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.SHADOWLANDS, parentID = 1550},
    [1536] = {name = "Maldraxxus", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.SHADOWLANDS, parentID = 1550},
    [1525] = {name = "Revendreth", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.SHADOWLANDS, parentID = 1550},
    [1543] = {name = "The Maw", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.SHADOWLANDS, parentID = 1550},
    [1970] = {name = "Zereth Mortis", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.SHADOWLANDS, parentID = 1550},
    
    -- 巨龙时代
    [1978] = {name = "Dragon Isles", type = CF.MAP_TYPES.CONTINENT, expansion = CF.EXPANSIONS.DRAGONFLIGHT, parentID = 0},
    [2022] = {name = "The Waking Shores", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.DRAGONFLIGHT, parentID = 1978},
    [2023] = {name = "Ohn'ahran Plains", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.DRAGONFLIGHT, parentID = 1978},
    [2024] = {name = "The Azure Span", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.DRAGONFLIGHT, parentID = 1978},
    [2025] = {name = "Thaldraszus", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.DRAGONFLIGHT, parentID = 1978},
    [2133] = {name = "Zaralek Cavern", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.DRAGONFLIGHT, parentID = 1978},
    [2200] = {name = "Emerald Dream", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.DRAGONFLIGHT, parentID = 1978},
    
    -- 地心之战
    [2274] = {name = "Khaz Algar", type = CF.MAP_TYPES.CONTINENT, expansion = CF.EXPANSIONS.TWW, parentID = 0},
    [2248] = {name = "Isle of Dorn", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.TWW, parentID = 2274},
    [2214] = {name = "The Ringing Deeps", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.TWW, parentID = 2274},
    [2215] = {name = "Hallowfall", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.TWW, parentID = 2274},
    [2255] = {name = "Azj-Kahet", type = CF.MAP_TYPES.ZONE, expansion = CF.EXPANSIONS.TWW, parentID = 2274},
}

-- ====================================================================
-- 声望数据表
-- 主要声望阵营ID和基本信息
-- ====================================================================
SD.Reputations = {
    -- 经典旧世 - 联盟
    {id = 72, name = "Stormwind", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 47, name = "Ironforge", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 54, name = "Gnomeregan", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 69, name = "Darnassus", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 930, name = "Exodar", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.TBC},
    
    -- 经典旧世 - 部落
    {id = 76, name = "Orgrimmar", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 81, name = "Thunder Bluff", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 68, name = "Undercity", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.CLASSIC},
    {id = 911, name = "Silvermoon City", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.TBC},
    {id = 530, name = "Darkspear Trolls", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.CLASSIC},
    
    -- 燃烧的远征
    {id = 932, name = "The Aldor", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 934, name = "The Scryers", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 935, name = "The Sha'tar", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 942, name = "Cenarion Expedition", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    {id = 989, name = "Keepers of Time", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TBC},
    
    -- 巫妖王之怒
    {id = 1037, name = "Alliance Vanguard", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1052, name = "Horde Expedition", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1090, name = "Kirin Tor", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1091, name = "The Wyrmrest Accord", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1098, name = "Knights of the Ebon Blade", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOTLK},
    {id = 1106, name = "Argent Crusade", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOTLK},
    
    -- 大地的裂变
    {id = 1133, name = "Earthen Ring", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CATACLYSM},
    {id = 1135, name = "The Earthen Ring", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CATACLYSM},
    {id = 1171, name = "Therazane", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CATACLYSM},
    {id = 1173, name = "Ramkahen", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.CATACLYSM},
    
    -- 熊猫人之谜
    {id = 1269, name = "Golden Lotus", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1270, name = "Shado-Pan", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1271, name = "Order of the Cloud Serpent", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1302, name = "The Anglers", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1337, name = "The Klaxxi", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    {id = 1359, name = "The Black Prince", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.MOP},
    
    -- 德拉诺之王
    {id = 1708, name = "Laughing Skull Orcs", faction = CF.FACTIONS.HORDE, expansion = CF.EXPANSIONS.WOD},
    {id = 1710, name = "Sha'tari Defense", faction = CF.FACTIONS.ALLIANCE, expansion = CF.EXPANSIONS.WOD},
    {id = 1711, name = "Steamwheedle Preservation Society", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.WOD},
    
    -- 军团再临
    {id = 1883, name = "Dreamweavers", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 1828, name = "Highmountain Tribe", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 1859, name = "The Nightfallen", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 1894, name = "The Wardens", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 1900, name = "Court of Farondis", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 2045, name = "Armies of Legionfall", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    {id = 2165, name = "Army of the Light", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.LEGION},
    
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
    {id = 2415, name = "Rajani", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.BFA},
    
    -- 暗影国度
    {id = 2407, name = "The Ascended", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2410, name = "The Undying Army", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2413, name = "Court of Harvesters", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2432, name = "Ve'nari", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2439, name = "The Avowed", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2465, name = "The Wild Hunt", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    {id = 2478, name = "The Enlightened", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.SHADOWLANDS},
    
    -- 巨龙时代
    {id = 2503, name = "Maruuk Centaur", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2507, name = "Dragonscale Expedition", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2510, name = "Valdrakken Accord", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2511, name = "Iskaara Tuskarr", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2523, name = "Dark Talons", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2524, name = "Obsidian Warders", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2564, name = "Loamm Niffen", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    {id = 2574, name = "Dream Wardens", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.DRAGONFLIGHT},
    
    -- 地心之战
    {id = 2570, name = "Council of Dornogal", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TWW},
    {id = 2590, name = "The Assembly of the Deeps", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TWW},
    {id = 2594, name = "Hallowfall Arathi", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TWW},
    {id = 2600, name = "The Severed Threads", faction = CF.FACTIONS.NEUTRAL, expansion = CF.EXPANSIONS.TWW},
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
    [2255] = {2600},                       -- The Severed Threads
}

-- ====================================================================
-- 辅助函数：获取货币信息
-- ====================================================================
function SD:GetCurrencyData(currencyID)
    if type(currencyID) ~= "number" then return nil end
    
    for expansion, currencies in pairs(self.Currencies) do
        for _, currency in ipairs(currencies) do
            if currency.id == currencyID then
                return currency
            end
        end
    end
    
    return nil
end

-- ====================================================================
-- 辅助函数：获取地图信息
-- ====================================================================
function SD:GetMapData(mapID)
    if type(mapID) ~= "number" then return nil end
    return self.Maps[mapID]
end

-- ====================================================================
-- 辅助函数：获取声望信息
-- ====================================================================
function SD:GetReputationData(factionID)
    if type(factionID) ~= "number" then return nil end
    
    for _, reputation in ipairs(self.Reputations) do
        if reputation.id == factionID then
            return reputation
        end
    end
    
    return nil
end

-- ====================================================================
-- 辅助函数：获取地图关联的货币列表
-- ====================================================================
function SD:GetMapCurrencies(mapID)
    if type(mapID) ~= "number" then return {} end
    return self.MapCurrencyAssociations[mapID] or {}
end

-- ====================================================================
-- 辅助函数：获取地图关联的声望列表
-- ====================================================================
function SD:GetMapReputations(mapID)
    if type(mapID) ~= "number" then return {} end
    return self.MapReputationAssociations[mapID] or {}
end

-- ====================================================================
-- 辅助函数：按扩展版本获取货币列表
-- ====================================================================
function SD:GetCurrenciesByExpansion(expansion)
    if type(expansion) ~= "number" then return {} end
    return self.Currencies[expansion] or {}
end

-- ====================================================================
-- 辅助函数：按扩展版本获取声望列表
-- ====================================================================
function SD:GetReputationsByExpansion(expansion)
    if type(expansion) ~= "number" then return {} end
    
    local result = {}
    for _, reputation in ipairs(self.Reputations) do
        if reputation.expansion == expansion then
            table.insert(result, reputation)
        end
    end
    
    return result
end

-- ====================================================================
-- 辅助函数：按阵营获取声望列表
-- ====================================================================
function SD:GetReputationsByFaction(faction)
    if type(faction) ~= "number" then return {} end
    
    local result = {}
    for _, reputation in ipairs(self.Reputations) do
        if reputation.faction == faction or reputation.faction == CF.FACTIONS.NEUTRAL then
            table.insert(result, reputation)
        end
    end
    
    return result
end

-- ====================================================================
-- 辅助函数：获取地图的扩展版本
-- ====================================================================
function SD:GetMapExpansion(mapID)
    local mapData = self:GetMapData(mapID)
    return mapData and mapData.expansion or nil
end