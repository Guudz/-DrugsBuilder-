local PlayersWashing = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function WhiteningMoney(source,percent)
	local source = source
		SetTimeout(10000, function()

		if PlayersWashing[source] == true then
			local xPlayer		= ESX.GetPlayerFromId(source)
			local blackMoney	= xPlayer.getAccount('black_money')
			local _percent		= Config.Percentage
			
			if blackMoney.money < Config.Slice then
				TriggerClientEvent("polo_propertydrugs:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('Nocash') .. Config.Slice)
			else
				local bonus = math.random(Config.Bonus.min, Config.Bonus.max)
				local washedMoney = math.floor(Config.Slice / 100 * (_percent + bonus))

				xPlayer.removeAccountMoney('black_money', Config.Slice)
				xPlayer.addMoney(washedMoney)
				WhiteningMoney(source,_percent)
				
				TriggerClientEvent("polo_propertydrugs:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('cash') .. washedMoney .. _U('cash1'))
			end
		end
	end)
end

RegisterServerEvent('polo_propertydrugs:washMoney')
AddEventHandler('polo_propertydrugs:washMoney', function(amount)
	local xPlayer 		= ESX.GetPlayerFromId(source)
	local account 		= xPlayer.getAccount('black_money')
	local _percent		= Config.Percentage

	if amount > 0 and account.money >= amount then
		
		local bonus = math.random(Config.Bonus.min, Config.Bonus.max)
		local washedMoney = math.floor(amount / 100 * (_percent + bonus))	

		xPlayer.removeAccountMoney('black_money', amount)
		xPlayer.addMoney(washedMoney)
		
		TriggerClientEvent("polo_propertydrugs:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('cash') .. washedMoney .. _U('cash1'))
		
	else
		TriggerClientEvent("polo_propertydrugs:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('invalid_amount'))
	end

end)

RegisterServerEvent('polo_propertydrugs:startWhitening')
AddEventHandler('polo_propertydrugs:startWhitening', function(percent)
	PlayersWashing[source] = true
	TriggerClientEvent("polo_propertydrugs:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('Whitening'))
	WhiteningMoney(source,percent)
end)

RegisterServerEvent('polo_propertydrugs:Nothere')
AddEventHandler('polo_propertydrugs:Nothere', function()
	PlayersWashing[source] = false
	TriggerClientEvent("polo_propertydrugs:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('Nothere'))
end)


RegisterServerEvent('polo_propertydrugs:stopWhitening')
AddEventHandler('polo_propertydrugs:stopWhitening', function()
	PlayersWashing[source] = false
end)