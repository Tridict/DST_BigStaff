local TUNING = GLOBAL.TUNING
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH

-------------------------:Mod Recipes:-------------------------


-- TUNING.ZiioRecipeType = GetModConfigData("recipemethod")

-- if TUNING.ZiioRecipeType == 1

--------------------------------------------------------------------------------------------------------------------------
-- [Custom Recipe]
--------------------

local rcp = RcpN
local tec = GLOBAL.TECH.NONE
local RcpType = TUNING.ZiioRecipeType

local RcpPlus = {Ingredient("purplegem", 1)}

local RcpVC = {Ingredient("twigs", 1), Ingredient("flint", 1)}
local RcpN = {Ingredient("twigs", 2), Ingredient("nightmarefuel", 5), Ingredient("purplegem", 2)}
local RcpVE = {Ingredient("twigs", 2), Ingredient("nightmarefuel", 10), Ingredient("purplegem", 5)}

if RcpType == 1 then
    rcp = RcpVC
    tec = GLOBAL.TECH.NONE
elseif  RcpType == 2 then
    rcp = RcpN
    tec = GLOBAL.TECH.SCIENCE_TWO
elseif  RcpType == 3 then
    rcp = RcpVE
    tec = GLOBAL.TECH.MAGIC_TWO
end

-- if TUNING.ROOMCAR_ziiosword_FRESH and TUNING.ROOMCAR_ziiosword_STACK then
--     for _,v in ipairs(RcpPlus) do
--         table.insert(rcp,v)
--     end
-- end


AddRecipe("ziiosword", -- name
rcp, -- ingredients Add more like so , {Ingredient("boards", 1), Ingredient("rope", 2), Ingredient("twigs", 1), etc}
RECIPETABS.TOOLS, -- tab ( ZIIOWORKS, FARM, WAR, DRESS etc)
TECH.NONE, -- level (GLOBAL.TECH.NONE, GLOBAL.TECH.SCIENCE_ONE, etc)
nil, -- placer
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
nil, -- builder_tag
"images/inventoryimages/ziiosword.xml", -- "images/inventoryimages/bigbag.xml", -- atlas
"ziiosword.tex" -- image

)
-- elseif TUNING.ZiioRecipeType == 2
-- AddRecipe("ziiosword", -- name
-- {Ingredient("cutgrass", 9999)}, -- ingredients Add more like so , {Ingredient("boards", 1), Ingredient("rope", 2), Ingredient("twigs", 1), etc}
-- RECIPETABS.TOOLS, -- tab ( ZIIOWORKS, FARM, WAR, DRESS etc)
-- TECH.NONE, -- level (GLOBAL.TECH.NONE, GLOBAL.TECH.SCIENCE_ONE, etc)
-- nil, -- placer
-- nil, -- min_spacing
-- nil, -- nounlock
-- nil, -- numtogive
-- nil, -- builder_tag
-- "images/inventoryimages/ziiosword.xml", -- "images/inventoryimages/bigbag.xml", -- atlas
-- "ziiosword.tex" -- image
-- )
-- else
-- AddRecipe("ziiosword", -- name
-- {Ingredient("cutgrass", 9999999)}, -- ingredients Add more like so , {Ingredient("boards", 1), Ingredient("rope", 2), Ingredient("twigs", 1), etc}
-- RECIPETABS.TOOLS, -- tab ( ZIIOWORKS, FARM, WAR, DRESS etc)
-- TECH.NONE, -- level (GLOBAL.TECH.NONE, GLOBAL.TECH.SCIENCE_ONE, etc)
-- nil, -- placer
-- nil, -- min_spacing
-- nil, -- nounlock
-- nil, -- numtogive
-- "ziioworker", -- builder_tag
-- "images/inventoryimages/ziiosword.xml", -- "images/inventoryimages/bigbag.xml", -- atlas
-- "ziiosword.tex" -- image
-- )
-- end

