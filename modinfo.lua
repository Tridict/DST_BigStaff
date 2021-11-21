-- This information tells other players more about the mod
name = "A Big Staff (大法杖) 1.1"
description = 
[[We currently release the 1.1 version. You can turn off the side effect (negative effects while removing) now.
更新到1.1版本啦！现在可以把副作用（卸下时的负面效果，默认开启，耗材越低、攻击力越强，副作用越明显）关闭了~还新增了划船桨的功能，可在设置中开启。

A big all-powerful staff that can be used in many ways, and it is also a very powerful weapon, so you don't need to switch your hand-equipment with this big staff! 
这是一把具备多用途的全能大法杖，同时也是一把很酷炫的武器！有了这把大法杖，你基本上就不需要换你的手持装备啦！它具备砍树、挖矿、锤子、铲子、捕虫网、犁地锄、钓鱼、照明、步行手杖、传送法杖等多种生活功能，同时也有多种武器效果可选（见选项菜单）。（提示：贪心是会有代价的哦！）]]
author = "Roomcar & Cora"
version = "dev1.1"

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
	return { name = "", label = title, hover = "", options = { {description = "", data = false}}, default = false, }
end

local function Space()
	return { name = "", label = "", hover = "", options = { {description = "", data = false}}, default = false, }
end


configuration_options =
{
    {
        name = "recipemethod",
        label = "Recipe（耗材）",
        options =
        {
            { description = "Easy", data = 1 },
            { description = "Normal",  data = 2 },
            { description = "Hard",  data = 3 },
        },
        default = 2
    },
    {
        name = "sideeffect",
        label = "Side Effect（副作用）",
        options =
        {
            { description = "Off",  data = false },
            { description = "On", data = true },
        },
        default = true
    },
    
Space(),
Header("Tool"),
    {
        name = "hammermode",
        label = "Hammer（锤子）",
        options =
        {
            { description = "Off",  data = false },
            { description = "On", data = true },
        },
        default = true
    },
    {
        name = "digmode",
        label = "Dig（铲子）",
        options =
        {
            { description = "Off",  data = false },
            { description = "On", data = true },
        },
        default = true
    },
    {
        name = "netmode",
        label = "Net（捕虫网）",
        options =
        {
            { description = "Off",  data = false },
            { description = "On", data = true },
        },
        default = true
    },
    {
        name = "oarmode",
        label = "Oar（桨）",
        options =
        {
            { description = "Off",  data = false },
            { description = "On", data = true },
        },
        default = false
    },
    {
        name = "fishmode",
        label = "Fishing Grod（钓竿）",
        options =
        {
            { description = "Off",  data = false },
            { description = "On", data = true },
        },
        default = true
    },
    {
		name = "lightmode",
		label = "Light（照明）",
		options = {
            { description = "Off", data = false },
			{ description = "On", data = true },
		},
		default = true,
	},
    {
        name = "umbrellamode",
        label = "Umbrella（雨伞）",
        options =
        {
            { description = "Off",  data = false },
            { description = "On", data = true },
        },
        default = true
    },
    {
        name = "telepoofmode",
        label = "Telepoof（传送）",
        hover = "注意：开启传送功能会影响犁地锄功能",
        options =
        {
            { description = "Off",  data = false },
            { description = "On", data = true },
        },
        default = true
    },
    {
		name = "walkspeed",
		label = "Walk Speed（移速）",
        hover = "注意：移速过快可能有BUG",
		options = {
			{ description = "No Change", data = 1 },
			{ description = "x1.25", data = 1.25 },
			{ description = "x1.5", data = 1.5 },
			{ description = "x2", data = 2 },
			{ description = "x2.5", data = 2.5 },
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
            { description = "50", data = 50 },
            { description = "500", data = 500 },
            { description = "1000", data = 1000 },
            { description = "999999", data = 999999 },
        },
        default = 1000,
    },
    {
        name = "rangemode",
        label = "Attack Range（攻击范围）",
        options =
        {
            { description = "Short",  data = 3 },
            { description = "Long", data = 20 },
            { description = "Very Long", data = 30 },
        },
        default = 20
    },
    --  攻击效果类
    {
        name = "healthmode",
        label = "Health Recover（攻击回血）",
        hover = "Health Recover on Attack（攻击回血）",
        options =
        {
            { description = "Off",  data = false },
            { description = "On", data = true },
        },
        default = false,
    },
    {
        name = "sanitymode",
        label = "Sanity Recover（攻击回理智）",
        hover = "Sanity Recover on Attack（攻击回理智）",
        options =
        {
            { description = "Off",  data = false },
            { description = "On", data = true },
        },
        default = false
    },
    {
        name = "icemode",
        label = "Freezing（冰冻）",
        options =
        {
            { description = "Off",  data = false },
            { description = "On", data = true },
        },
        default = false
    },
    {
        name = "sleepmode",
        label = "Sleeping（昏睡）",
        options =
        {
            { description = "Off",  data = false },
            { description = "On", data = true },
        },
        default = false
    },
    {
        name = "brimstonemode",
        label = "Lightning（召唤雷电）",
        options =
        {
            { description = "Off",  data = false },
            { description = "On", data = true },
        },
        default = false
    },
    {
        name = "tentaclemode",
        label = "Tentacle（召唤触手）",
        options =
        {
            { description = "Off",  data = ""}, 
            { description = "Normal", data = "normal" },
            { description = "Shadow", data = "shadow" },
        },
        default = "shadow"
    },
}
