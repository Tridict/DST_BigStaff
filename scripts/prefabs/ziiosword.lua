require "prefabutil"
require "recipe"
require "modutil"

local assets=
{
    Asset("ANIM", "anim/all_staff.zip"),
    Asset("ANIM", "anim/swap_all_staff.zip"),
    Asset("IMAGE", "images/inventoryimages/ziiosword.tex"),
    Asset("ATLAS", "images/inventoryimages/ziiosword.xml"),
}

-- local hungermode   = TUNING.ZIIOSWORDFUNCTION.HUNGER
local hungermode      = false
-- local tempmode     = TUNING.ZIIOSWORDFUNCTION.TEMP
local tempmode        = false
-- local protmode     = TUNING.ZIIOSWORDFUNCTION.PROT

-- 制造模式
-- local resmode      = TUNING.ZIIOSWORDFUNCTION.RES
local resmode         = true


-- 正式启用的
local RcpType         = TUNING.ZiioRecipeType
local sideeffect      = TUNING.ZIIOSWORDFUNCTION.PUNISH
-- TOOL SETTINGS
local hammermode      = TUNING.ZIIOSWORDFUNCTION.HAMMER
local digmode         = TUNING.ZIIOSWORDFUNCTION.DIG
local netmode         = TUNING.ZIIOSWORDFUNCTION.NET
local oarmode         = TUNING.ZIIOSWORDFUNCTION.OAR
local fishmode       = true
-- TUNING.ZIIOSWORDFUNCTION.OCEANFISH
local oceanfishmode   = false
if not fishmode then
    oceanfishmode   = false
end
local lightmode       = TUNING.ZIIOSWORDFUNCTION.LIGHT
local umbrellamode    = TUNING.ZIIOSWORDFUNCTION.UMBRELLA
local telepoofmode    = TUNING.ZIIOSWORDFUNCTION.TELEPOOF
local walkspeed       = TUNING.ZIIOSWORDFUNCTION.WALKSPEED

-- WAEPON SETTINGS
local damage          = TUNING.ZIIOSWORDFUNCTION.DAMAGE
local rangemode       = TUNING.ZIIOSWORDFUNCTION.RANGE
local healthmode      = TUNING.ZIIOSWORDFUNCTION.HEALTH
local sanitymode      = TUNING.ZIIOSWORDFUNCTION.SANITY
-- local sanitymode   = false
local icemode         = TUNING.ZIIOSWORDFUNCTION.ICE
local sleepmode       = TUNING.ZIIOSWORDFUNCTION.SLEEP
local brimstonemode   = TUNING.ZIIOSWORDFUNCTION.BRIMSTONE
local tentaclemode    = TUNING.ZIIOSWORDFUNCTION.TENTACLE


local TENTACLES_BLOCKED_CANT_TAGS = { "INLIMBO", "FX" }

local function giveitems(inst, data)
    if data.recipe then
        for ik, iv in pairs(data.recipe.ingredients) do
            if data.owner.components.inventory and not data.owner.components.inventory:Has(iv.type, iv.amount) then
                data.owner.components.talker:Say('2')
                for i = 1, iv.amount do
                    local item = SpawnPrefab(iv.type)
                    data.owner.components.inventory:GiveItem(item)
                    -- inventory_replica没有GiveItem这个函数，因此客户端不生效
                    -- 兼容方案：把需要的材料生成到地上
                    -- if not TheWorld.ismastersim then
                    --     data.owner.components.talker:Say('3')
                    --     item.Transform:SetPosition(data.owner:GetPosition())
                    -- end
                    
                    -- Replica是component的副件，与component不同，不管是主机还客机，replica都是必定会存在的，replica的主要用途就是帮助客机玩家流畅地完成原本component要完成的操作，但这些操作通常都只是游戏界面的变化，比如说播放动画，显示文字之类的，较少涉及到与主机的数据交换（数据交换的工作，主要由classified完成)。在主机中调用component的函数，如果在replica中存在同名函数，也会被同时调用。利用这个特性，可以在同名函数的方法体中。对主机，执行更新客机数据的代码，对客机，执行动画之类的操作（如果有必要的话）。（对主客机执行不同的代码，可以用上面提到的TheWorld.ismastersim这个变量来区分，或者用TheNet:IsServer()这个函数。）

                    -- 如果你想为自己自定义的新组件设置replica的话，只需要两步便可完成。
                    -- 1、在components文件夹下，新建一个文件，文件名为"组件名_replica.lua"，文件里的定义格式同一般的组件，内容则自行决定。
                    -- 2、在modmain中，添加一行代码AddReplicableComponent("组件名")
                    -- 这样一来，你便有了一个自定义的replica。
                    -- 具体的实例，请参看我的联机版samansha，里面有一个sa_car的replica。如果觉得看不懂，可以在评论区回复，我会考虑专门写一个教学用的实例mod。

                    -- 作者：LongFei_aot
                    -- 链接：https://www.jianshu.com/p/529c75ca18ee
                    -- 来源：简书
                    -- 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
                end
            end
        end
    end
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "swap_all_staff", "swap_all_staff")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    if lightmode then
        inst.Light:Enable(true)
    end
    inst.task = inst:DoPeriodicTask(5, function() 
        -- if owner.components.health and healthmode then
        --     owner.components.health:DoDelta(250)
        -- end
        if owner.components.hunger and hungermode then
            owner.components.hunger:DoDelta(5)
        end
        -- if owner.components.sanity and sanitymode then
        --     owner.components.sanity:DoDelta(10)
        -- end
        if owner.components.temperature and tempmode then
            owner.components.temperature:SetTemperature(25)
        end
        if owner.components.moisture and tempmode then
            owner.components.moisture:SetPercent(0)
        end
    end)
    -- 官方代码（widgets/widgetutil.lua）：
    -- if not can_build and TheWorld.ismastersim then
    --     owner:PushEvent("cantbuild", { owner = owner, recipe = recipe })
    if resmode then owner:ListenForEvent("cantbuild", giveitems) end
end

-- local knows = owner.replica.builder:KnowsRecipe(recipe.name)
-- local can_build = owner.replica.builder:CanBuild(recipe.name)

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    if lightmode then
        inst.Light:Enable(false)
    end
    if inst.task then
        inst.task:Cancel()
        inst.task = nil
    end
    if resmode then owner:RemoveEventCallback("cantbuild", giveitems) end
    -- 副作用：卸下惩罚（越便宜+伤害高，惩罚力度越大）
    if sideeffect then
        if RcpType == 1 and damage > 999 then
            owner.components.hunger:DoDelta(- owner.components.hunger.max * 0.8)
            owner.components.sanity:DoDelta(- owner.components.sanity.max * 0.8)
            owner.components.health:DoDelta(- owner.components.health.maxhealth * 0.8)
        elseif  RcpType == 1 or damage > 999 then
            owner.components.hunger:DoDelta(- owner.components.hunger.max * 0.5)
            owner.components.sanity:DoDelta(- owner.components.sanity.max * 0.5)
            -- owner.components.health:DoDelta(- owner.components.health.maxhealth * 0.5)
            owner.components.health:SetPercent(0.5)
        elseif RcpType == 2 then
            owner.components.hunger:DoDelta(- owner.components.hunger.max * 0.2)
            owner.components.sanity:DoDelta(- owner.components.sanity.max * 0.2)
            -- owner.components.health:DoDelta(- owner.components.health.maxhealth * 0.2)
            owner.components.health:SetPercent(0.2)
        end
    end    
end

local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end

local function onattack(inst, owner, target)
    owner.components.hunger:DoDelta(-1)
    owner.components.sanity:DoDelta(-1)
    owner.components.health:DoDelta(-1)
    -- 攻击回血
    if owner.components.health and healthmode then
        owner.components.health:DoDelta(25)
    end
    -- 攻击回精神
    if owner.components.sanity and sanitymode then
        owner.components.sanity:DoDelta(10)
    end
    -- 冰冻效果（2下才冰住）
    if icemode then
        if target.components.freezable ~= nil then
            target.components.freezable:AddColdness(10)
            target.components.freezable:SpawnShatterFX()
        end
    end
    -- 睡眠效果（1~2下才睡着）
    if sleepmode then
        if target.components.sleeper ~= nil then
            target.components.sleeper:AddSleepiness(8, 60, inst)
        elseif target.components.grogginess ~= nil then
            target.components.grogginess:AddGrogginess(8, 60)
            -- target.components.grogginess:MaximizeGrogginess()
        end
    end
    -- 召唤雷电
    if brimstonemode then
        local pt = target:GetPosition()
        local num_lightnings = 4
        owner:StartThread(function()
            for k = 0, num_lightnings do
                local rad = 1
                local angle = k * 1 * PI / num_lightnings
                local pos = pt + Vector3(rad * math.cos(angle), 0, rad * math.sin(angle))
                TheWorld:PushEvent("ms_sendlightningstrike", pos)
                owner.components.sanity:DoDelta(1)
                owner.components.health:DoDelta(2)
                Sleep(.3 + math.random() * .2)
            end
        end)
    end
    -- 召唤触手
    if tentaclemode then
        local pt = target:GetPosition()
        local numtentacles = 3

        -- owner.components.sanity:DoDelta(-TUNING.SANITY_HUGE)

        owner:StartThread(function()
            if tentaclemode == 'normal' then
                for k = 1, numtentacles do
                    local theta = math.random() * 2 * PI
                    local radius = math.random(3, 8)

                    local result_offset = FindValidPositionByFan(theta, radius, 12, function(offset)
                        local pos = pt + offset
                        --NOTE: The first search includes invisible entities
                        return #TheSim:FindEntities(pos.x, 0, pos.z, 1, nil, TENTACLES_BLOCKED_CANT_TAGS) <= 0
                            and TheWorld.Map:IsPassableAtPoint(pos:Get())
                            and TheWorld.Map:IsDeployPointClear(pos, nil, 1)
                    end)
                    
                    
                    if result_offset ~= nil then
                        local x, z = pt.x + result_offset.x, pt.z + result_offset.z
                        local tentacle = SpawnPrefab("tentacle")
                        tentacle.Transform:SetPosition(x, 0, z)
                        tentacle.sg:GoToState("attack_pre")
                        tentacle.components.combat:SetTarget(target)
                        -- tentacle.components.replica.combat:SetTarget(target)
                        tentacle.components.health:SetMaxHealth(100)
                        -- tentacle.components.lootdropper.numrandomloot = 0
                        -- tentacle:RemoveComponent("lootdropper")
                        tentacle:StartThread(function()
                            while tentacle.components.health.currenthealth > 0 do
                                tentacle.components.health:DoDelta(-10)
                                Sleep(1)
                            end
                        end)

                        --need a better effect
                        SpawnPrefab("splash_ocean").Transform:SetPosition(x, 0, z)
                        ShakeAllCameras(CAMERASHAKE.FULL, .2, .02, .25, target, 40)
                    end

                    Sleep(.33)
                end
            
            elseif tentaclemode == 'shadow' then
                for k = 1, numtentacles do
                    local pt = target:GetPosition()
                    local offset = FindWalkableOffset(pt, math.random() * 2 * PI, 2, 3, false, true, NoHoles)
                    if offset ~= nil then
                        inst.SoundEmitter:PlaySound("dontstarve/common/shadowTentacleAttack_1")
                        inst.SoundEmitter:PlaySound("dontstarve/common/shadowTentacleAttack_2")
                        local tentacle = SpawnPrefab("shadowtentacle")
                        if tentacle ~= nil then
                            tentacle.Transform:SetPosition(pt.x + offset.x, 0, pt.z + offset.z)
                            tentacle.components.combat:SetTarget(target)
                        end
                    end
                end
            end
        end)
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()
    
    MakeInventoryPhysics(inst)
    
    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "ziiosword.tex" )
    
    -- local light = inst.entity:AddLight()
    if lightmode then
        inst.entity:AddLight()
        inst.Light:SetRadius(10)
        inst.Light:SetFalloff(0.5)
        inst.Light:SetIntensity(0.95)
        inst.Light:SetColour(255/255,255/255,255/255)
    end
    
    inst.AnimState:SetBank("all_staff")
    inst.AnimState:SetBuild("all_staff")
    inst.AnimState:PlayAnimation("idle")
    -- inst.AnimState:SetMultColour(1, 1, 1, 0.6)
    
    inst:AddTag("ziio")
    inst:AddTag("ziiosword")
    inst:AddTag("sharp")
    if lightmode then
        inst:AddTag("light")
    end
    
    if umbrellamode then
        inst:AddTag("umbrella")
        inst:AddTag("waterproofer")
    end

    if oarmode or fishmode then
        inst:AddTag("allow_action_on_impassable")
    end

    if fishmode then
        inst:AddTag("fishingrod")
    end

    if oceanfishmode then
        inst:AddTag("accepts_oceanfishingtackle")
    end
    
    -- if protmode then
    --     inst:AddTag("prototyper")
    -- end
    
    -- if protmode then
    --     inst:AddComponent("prototyper")
    --     inst.components.prototyper.trees = {SCIENCE = 9, MAGIC = 9, ANCIENT = 9, SHADOW = 9, CARTOGRAPHY = 0, SCULPTING = 9, ORPHANAGE = 0,}
    -- end

    local floater_swap_data =
    {
        sym_build = "swap_all_staff",
        bank = "all_staff",
    }
    -- MakeInventoryFloatable(inst, "med", 0.1, {0.9, 0.4, 0.9}, true, -13, floater_swap_data)
    MakeInventoryFloatable(inst, "med", 0.05, {1.0, 0.4, 1.0}, true, -17.5, floater_swap_data)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    -- if sanitymode then
    --     inst:AddComponent("dapperness")
    --     inst.components.equippable.dapperness = math.huge
    --     inst.components.dapperness.dapperness = math.huge
    --     inst.components.dapperness.mitigates_rain = true
    -- end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ziiosword.xml"

    inst:AddComponent("equippable")
    inst.components.equippable.walkspeedmult = walkspeed,
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(damage)
    -- if rangemode then inst.components.weapon:SetRange(10,20) end
    if rangemode then inst.components.weapon:SetRange(rangemode, rangemode) end
    inst.components.weapon:SetOnAttack(onattack)
    -- inst.components.weapon:SetProjectile("monkey_projectile")
    inst.components.weapon:SetProjectile("ziio_projectile")

    inst:AddComponent("tool")
    -- inst.components.tool:SetAction(ACTIONS.PICK,   100)
    inst.components.tool:SetAction(ACTIONS.CHOP,   100)
    inst.components.tool:SetAction(ACTIONS.MINE,   100)
    if hammermode then
        inst.components.tool:SetAction(ACTIONS.HAMMER, 100)
    end
    if digmode then
        inst.components.tool:SetAction(ACTIONS.DIG,    100)
    end
    if netmode then
        inst.components.tool:SetAction(ACTIONS.NET,    100)
    end

    if telepoofmode then
        inst:AddComponent("blinkstaff")
        inst.components.blinkstaff:SetFX("sand_puff_large_front", "sand_puff_large_back")
    end

    inst:AddInherentAction(ACTIONS.TILL)
    inst:AddComponent("farmtiller")


    if oarmode then
        inst:AddComponent("oar")
        inst.components.oar.force = 1
        inst.components.oar.max_velocity = 1
    end

    if fishmode then
        inst:AddComponent("fishingrod")
        inst.components.fishingrod:SetWaitTimes(1,3)
        inst.components.fishingrod:SetStrainTimes(0,10)
    end

    -- 海钓竿
    if oceanfishmode then
        inst:AddComponent("oceanfishingrod")
        inst.components.oceanfishingrod:SetDefaults("oceanfishingbobber_none_projectile", TUNING.OCEANFISHING_TACKLE.BASE, TUNING.OCEANFISHING_LURE.HOOK, {build = "oceanfishing_hook", symbol = "hook"})
        -- OnStartedFishing
        inst.components.oceanfishingrod.oncastfn = function(inst, fisher, target)
            if inst.components.container ~= nil then
                inst.components.container:Close()
            end
        end
        -- OnDoneFishing
        inst.components.oceanfishingrod.ondonefishing = function(inst, reason, lose_tackle, fisher, target)
            if inst.components.container ~= nil and lose_tackle then
                inst.components.container:DestroyContents()
            end
        
            if inst.components.container ~= nil and fisher ~= nil and inst.components.equippable ~= nil and inst.components.equippable.isequipped then
                inst.components.container:Open(fisher)
            end
        end
        -- OnHookedSomething
        inst.components.oceanfishingrod.onnewtargetfn = function (inst, target)
            if target ~= nil and inst.components.container then
                if target.components.oceanfishinghook ~= nil then
                    if TheWorld.Map:IsOceanAtPoint(target.Transform:GetWorldPosition()) then
                        for slot, item in pairs(inst.components.container.slots) do
                            if item ~= nil and item.components.inventoryitem ~= nil then
                                item.components.inventoryitem:AddMoisture(TUNING.OCEAN_WETNESS)
                            end
                        end
                    end
                elseif not target:HasTag("projectile") then
                    for slot, item in pairs(inst.components.container.slots) do
                        if item ~= nil and item.components.oceanfishingtackle ~= nil and item.components.oceanfishingtackle:IsSingleUse() then
                            inst.components.container:RemoveItemBySlot(slot):Remove()
                        end
                    end
                end
            end
        end
        -- GetTackle
        inst.components.oceanfishingrod.gettackledatafn = function(inst)
            return (inst.components.oceanfishingrod ~= nil and inst.components.container ~= nil) and
                {
                    bobber = inst.components.container.slots[1],
                    lure = inst.components.container.slots[2]
                }
                or {}
        end

        inst:AddComponent("container")
        inst.components.container:WidgetSetup("oceanfishingrod")
        inst.components.container.canbeopened = false
        local function OnTackleChanged(inst, data)
            if inst.components.oceanfishingrod ~= nil then
                inst.components.oceanfishingrod:UpdateClientMaxCastDistance()
            end
        end
        inst:ListenForEvent("itemget", OnTackleChanged)
        inst:ListenForEvent("itemlose", OnTackleChanged)
    end
    -- 海钓竿 END

    if umbrellamode then
        inst:AddComponent("waterproofer")
        inst.components.waterproofer:SetEffectiveness(1)
    end

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = 100 --TUNING.SANITYAURA_HUGE

    MakeHauntableWork(inst)
    
    return inst
end

return Prefab( "common/inventory/ziiosword", fn, assets) 
