local TUNING = GLOBAL.TUNING

local require = GLOBAL.require
local Ingredient = GLOBAL.Ingredient
local STRINGS = GLOBAL.STRINGS
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH

PrefabFiles = {
    "ziiosword", "ziio_projectile",
}

TUNING.ZIIOSWORDFUNCTION = {}
TUNING.ZIIOSWORDFUNCTION.RES    = GetModConfigData("resmode")

-- TOOL SETTINGS
TUNING.ZiioRecipeType              = GetModConfigData("recipemethod")
TUNING.ZIIOSWORDFUNCTION.WALKSPEED = GetModConfigData("walkspeed")
TUNING.ZIIOSWORDFUNCTION.LIGHT     = GetModConfigData("lightmode")
TUNING.ZIIOSWORDFUNCTION.UMBRELLA  = GetModConfigData("umbrellamode")
TUNING.ZIIOSWORDFUNCTION.TELEPOOF  = GetModConfigData("telepoofmode")
TUNING.ZIIOSWORDFUNCTION.HAMMER    = GetModConfigData("hammermode")
TUNING.ZIIOSWORDFUNCTION.DIG       = GetModConfigData("digmode")

-- WAEPON SETTINGS
TUNING.ZIIOSWORDFUNCTION.DAMAGE    = GetModConfigData("damage")
TUNING.ZIIOSWORDFUNCTION.RANGE     = GetModConfigData("rangemode")
TUNING.ZIIOSWORDFUNCTION.HEALTH    = GetModConfigData("healthmode")
TUNING.ZIIOSWORDFUNCTION.SANITY    = GetModConfigData("sanitymode")
TUNING.ZIIOSWORDFUNCTION.ICE       = GetModConfigData("icemode")
TUNING.ZIIOSWORDFUNCTION.SLEEP     = GetModConfigData("sleepmode")
TUNING.ZIIOSWORDFUNCTION.BRIMSTONE = GetModConfigData("brimstonemode")
TUNING.ZIIOSWORDFUNCTION.TENTACLE  = GetModConfigData("tentaclemode")


Assets = {
    Asset("ANIM", "anim/all_staff.zip"),
    Asset("ANIM", "anim/monkey_projectile.zip"),
    Asset("ANIM", "anim/swap_all_staff.zip"),

    Asset("IMAGE", "images/inventoryimages/ziiosword.tex"),
    Asset("ATLAS", "images/inventoryimages/ziiosword.xml"),
    Asset("IMAGE", "images/ziiotab.tex"),
    Asset("ATLAS", "images/ziiotab.xml"),
}

modimport("strings.lua")
modimport("recipes.lua")
-- modimport("postinits.lua")

AddMinimapAtlas("images/inventoryimages/ziiosword.xml")
