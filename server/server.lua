local QBCore = exports['qb-core']:GetCoreObject() 

local Cooldown = false

RegisterServerEvent('ps-methrun:server:startr', function()
    local player = QBCore.Functions.GetPlayer(source)

	if player.PlayerData.money['cash'] >= Config.RunCost then
		player.Functions.RemoveMoney('cash', Config.RunCost)
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

RegisterServerEvent('ps-meth:server:giveitemreward', function()
	local player = QBCore.Functions.GetPlayer(source)
	player.PlayerData.AddItem(Config.SpecialItem, 1)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.SpecialItem], "add")
end)

RegisterServerEvent('ps-methrun:server:givemeth', function()
	local player = QBCore.Functions.GetPlayer(source)
	player.Functions.AddMoney('cash', Config.Payout)
	player.Functions.AddItem(Config.Item, Config.MethAmount)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.Item], "add")
end)

RegisterServerEvent('ps-methrun:server:givemoney', function()
	local player = QBCore.Functions.GetPlayer(source)
	player.Functions.AddMoney('cash', Config.Payout)
end)
