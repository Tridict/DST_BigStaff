-- This information tells other players more about the mod
name = "A Big Staff (大法杖) dev1.0.0"
description = 
[[We currently release the 1.0.0 version. We added many options of the weapon effect, please check the options for more information.
更新到1.0.0版本啦！新增了武器的一些效果（需要手动开启），以及更多自定义选项~

A big all-powerful staff that can be used in many ways, and it is also a very powerful weapon, so you don't need to switch your hand-equipment with this big staff! 
这是一把具备多用途的全能大法杖，同时也是一把很酷炫的武器！有了这把大法杖，你基本上就不需要换你的手持装备啦！它具备砍树、挖矿、锤子、铲子、钓鱼、犁地锄、照明、步行手杖、传送法杖等多种生活功能，同时也有多种武器效果可选（见选项菜单）。（提示：贪心是会有代价的哦！）]]
author = "Roomcar & Cora"
version = "dev-1.0.0"

-- This is the URL name of the mod's thread on the forum; the part after the ? and before the first & in the url
-- Example:
-- http://forums.kleientertainment.com/showthread.php?19505-Modders-Your-new-friend-at-Klei!
-- becomes
-- 19505-Modders-Your-new-friend-at-Klei!
forumthread = ""

dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
porkland_compatible = false
hamlet_compatible = false

--priority = 4

-- This lets other players know if your mod is out of date, update it to match the current version in the game
api_version = 10
api_version_dst = 10

-- Can specify a custom icon for this mod!
icon_atlas = "ziiosword.xml"
icon = "ziiosword.tex"


-- optional (if it's the same mod for DST and single-player)
dst_compatible = true
--This lets clients know if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = true
--This is basically the opposite; it specifies that this mod doesn't affect other players at all, and if set, won't mark your server as modded
client_only_mod = false
--This lets people search for servers with this mod by these tags
server_filter_tags = {"ziio", "item", "roomcar", "powerful sword", "big staff", "weapon"}

local function Header(title)
	return { name = "", label = title, hover = "", options = { {description = "", data = false}, }, default = false, }
end

local function Space()
	return { name = "", label = "", hover = "", options = { {description = "", data = false}, }, default = false, }
end



configuration_options =
{
    -- {
    --     name = "hungermode",
    --     label = "Auto Feeder（自动喂饱）",
    --     options =
    --     {
    --         {description = "On", data = true},
    --         {description = "Off",  data = false},
    --     },
    --     default = false
    -- },
    -- {
    --     name = "tempmode",
    --     label = "Heater/Cooler（体温调节）",
    --     options =
    --     {
    --         {description = "On", data = true},
    --         {description = "Off",  data = false},
    --     },
    --     default = false
    -- },
    -- {
    --     name = "protmode",
    --     label = "Build-in Prototyper",
    --     options =
    --     {
    --         {description = "Off",  data = false},
    --         {description = "On", data = true},
    --     },
    --     default = true
    -- },
    -- {
    --     name = "resmode",
    --     label = "Infinite Resources Supply（资源供给）",
    --     hovers = "Give items if can't build（若无法建造物品，则给与物品。仅无洞穴的服务端有效）",
    --     options =
    --     {
    --         {description = "Off",  data = false},
    --         {description = "On", data = true},
    --     },
    --     default = false
    -- },
    {
        name = "recipemethod",
        label = "Recipe（耗材）",
        options =
        {
            {description = "Easy", data = 1},
            {description = "Normal",  data = 2},
            {description = "Hard",  data = 3},
        },
        default = 2
    },
Header("Tool"),
    {
        name = "hammermode",
        label = "Hammer（锤子）",
        options =
        {
            {description = "Off",  data = false},
            {description = "On", data = true},
        },
        default = true
    },
    {
        name = "digmode",
        label = "Dig（铲子）",
        options =
        {
            {description = "Off",  data = false},
            {description = "On", data = true},
        },
        default = true
    },
    {
		name = "lightmode",
		label = "Light (照明)",
		options = {
            { description = "Off", data = false, },
			{ description = "On", data = true, },
		},
		default = true,
	},
    {
        name = "umbrellamode",
        label = "Umbrella（雨伞）",
        options =
        {
            {description = "Off",  data = false},
            {description = "On", data = true},
        },
        default = true
    },
    {
        name = "telepoofmode",
        label = "Telepoof（传送）",
        hover = "注意：开启传送功能会影响犁地锄功能",
        options =
        {
            {description = "Off",  data = false},
            {description = "On", data = true},
        },
        default = true
    },
    {
		name = "walkspeed",
		label = "Walk Speed (移速)",
        hover = "注意：移速过快可能有BUG",
		options = {
			{ description = "No Change", data = 1, },
			{ description = "x1.25", data = 1.25, },
			{ description = "x1.5", data = 1.5, },
			{ description = "x2", data = 2, },
			{ description = "x2.5", data = 2.5, },
		},
		default = 1.25,
	},



Space(),
Header("Weapon"),
    {
        name = "damage",
        label = "Damage（伤害）",
        options =
        {
            {description = "50", data = 50},
            {description = "500", data = 500},
            {description = "1000", data = 1000},
            {description = "999999", data = 999999},
        },
        default = 1000,
    },
    {
        name = "rangemode",
        label = "Attack Range（攻击范围）",
        options =
        {
            {description = "Short",  data = 1},
            {description = "Long", data = 10},
            {description = "Very Long", data = 30},
        },
        default = 10
    },
    --  攻击效果类
    {
        name = "healthmode",
        label = "Health Recover on Attack（攻击回血）",
        options =
        {
            {description = "Off",  data = false},
            {description = "On", data = true},
        },
        default = false,
    },
    {
        name = "sanitymode",
        label = "Sanity Recover on Attack（攻击回理智）",
        options =
        {
            {description = "Off",  data = false},
            {description = "On", data = true},
        },
        default = false
    },
    {
        name = "icemode",
        label = "Freezing Effect（冰冻效果）",
        options =
        {
            {description = "Off",  data = false},
            {description = "On", data = true},
        },
        default = false
    },
    {
        name = "sleepmode",
        label = "Sleeping Effect（昏睡效果）",
        options =
        {
            {description = "Off",  data = false},
            {description = "On", data = true},
        },
        default = false
    },
    {
        name = "brimstonemode",
        label = "Summon Lightning（召唤雷电）",
        options =
        {
            {description = "Off",  data = false},
            {description = "On", data = true},
        },
        default = false
    },
    {
        name = "tentaclemode",
        label = "Summon Tentacle（召唤触手）",
        options =
        {
            {description = "Off",  data = ""},
            {description = "Normal", data = "normal"},
            {description = "Shadow", data = "shadow"},
        },
        default = "shadow"
    },
}
