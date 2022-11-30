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
TUNING.ZiioRecipeType              = GetModConfigData("recipemethod")
TUNING.ZIIOSWORDFUNCTION.PUNISH    = GetModConfigData("sideeffect")

-- TOOL SETTINGS
TUNING.ZIIOSWORDFUNCTION.HAMMER    = GetModConfigData("hammermode")
TUNING.ZIIOSWORDFUNCTION.DIG       = GetModConfigData("digmode")
TUNING.ZIIOSWORDFUNCTION.NET       = GetModConfigData("netmode")
TUNING.ZIIOSWORDFUNCTION.OAR       = GetModConfigData("oarmode")
TUNING.ZIIOSWORDFUNCTION.LIGHT     = GetModConfigData("lightmode")
TUNING.ZIIOSWORDFUNCTION.UMBRELLA  = GetModConfigData("umbrellamode")
TUNING.ZIIOSWORDFUNCTION.TELEPOOF  = GetModConfigData("telepoofmode")
TUNING.ZIIOSWORDFUNCTION.WALKSPEED = GetModConfigData("walkspeed")

-- WAEPON SETTINGS
TUNING.ZIIOSWORDFUNCTION.DAMAGE    = GetModConfigData("damage")
TUNING.ZIIOSWORDFUNCTION.RANGE     = GetModConfigData("rangemode")
TUNING.ZIIOSWORDFUNCTION.PROJECTILE    = GetModConfigData("projectile")
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

AddMinimapAtlas("images/inventoryimages/ziiosword.xml")
