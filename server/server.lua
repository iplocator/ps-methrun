local QBCore = exports['qb-core']:GetCoreObject() 

local Cooldown = false

RegisterServerEvent('ps-methrun:server:startr', function()
    local player = QBCore.Functions.GetPlayer(source)

	if player.PlayerData.money['cash'] >= Config.RunCost then
		player.Functions.RemoveMoney('cash', Config.RunCost)
        Player.Functions.AddItem("casekey", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casekey"], "add")
		TriggerClientEvent("ps-methrun:server:runactivate", source)
	else
		TriggerClientEvent('QBCore:Notify', source, 'You Dont Have Enough Money', 'error')
	end
end)

-- cool down for job
RegisterServerEvent('ps-methrun:server:coolout', function()
    Cooldown = true
    local timer = Config.Cooldown * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            Cooldown = false
        end
    end
end)

QBCore.Functions.CreateCallback("ps-methrun:server:coolc",function(source, cb)
    if Cooldown then
        cb(true)
    else
        cb(false) 
    end
end)

RegisterServerEvent('ps-methrun:server:unlock', function ()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("securitycase", 1)
    Player.Functions.RemoveItem("casekey", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["securitycase"], "add")
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["casekey"], "remove")
end)

RegisterServerEvent('ps-methrun:server:rewardpayout', function ()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem("meth_cured", 20)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["meth_cured"], "remove")

    Player.Functions.AddMoney('cash', Config.Payout)

    if chance >= 85 then
        Player.Functions.AddItem(Config.Item, Config.MethAmount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Item], "add")
    end

    if chance >= 95 then
        Player.Functions.AddItem(Config.SpecialItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.SpecialItem], "add")
    end
end)

RegisterServerEvent('ps-methrun:server:givecaseitems', function ()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("meth_cured", 20)
    Player.Functions.RemoveItem("securitycase", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["meth_cured"], "add")
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["securitycase"], "remove")
end)
