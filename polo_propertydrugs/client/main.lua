local OwnedPropertiesDrugs, Blips, CurrentActionData = {}, {}, {}
local CurrentPropertyDrugs, LastPropertyDrugs, LastPart, CurrentAction, CurrentActionMsg
local firstSpawn, hasChest, hasAlreadyEnteredMarker = true, false, false
local isSingle = 1
local propertydrugsName = nil
local isOwned  = true

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.TriggerServerCallback('polo_propertydrugs:getPropertiesDrugs', function(propertiesdrugs)
		Config.PropertiesDrugs = propertiesdrugs
		
	end)
end)

function DrawSub(text, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandPrint(time, 1)
end



function GetPropertiesDrugs()
	return Config.PropertiesDrugs
end

function GetPropertyDrugs(name)
	for i=1, #Config.PropertiesDrugs, 1 do
		if Config.PropertiesDrugs[i].name == name then
			return Config.PropertiesDrugs[i]
		end
	end
end

function GetGateway(propertydrugs)
	for i=1, #Config.PropertiesDrugs, 1 do
		local propertydrugs2 = Config.PropertiesDrugs[i]

		if propertydrugs2.isGateway and propertydrugs2.name == propertydrugs.gateway then
			return propertydrugs2
		end
	end
end

function GetGatewayPropertiesDrugs(propertydrugs)
	local propertiesdrugs = {}

	for i=1, #Config.PropertiesDrugs, 1 do
		if Config.PropertiesDrugs[i].gateway == propertydrugs.name then
			table.insert(propertiesdrugs, Config.PropertiesDrugs[i])
		end
	end

	return propertiesdrugs
end

function EnterPropertyDrugs(name)
	local propertydrugs       = GetPropertyDrugs(name)
	local playerPed      = PlayerPedId()
	CurrentPropertyDrugs      = propertydrugs

	for i=1, #Config.PropertiesDrugs, 1 do
		if Config.PropertiesDrugs[i].name ~= name then
			Config.PropertiesDrugs[i].disabled = true
		end
	end

	TriggerServerEvent('polo_propertydrugs:saveLastPropertyDrugs', name)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		for i=1, #propertydrugs.ipls, 1 do
			RequestIpl(propertydrugs.ipls[i])

			while not IsIplActive(propertydrugs.ipls[i]) do
				Citizen.Wait(0)
			end
		end

		SetEntityCoords(playerPed, propertydrugs.inside.x, propertydrugs.inside.y, propertydrugs.inside.z)
		DoScreenFadeIn(800)
		DrawSub(propertydrugs.label, 5000)
	end)

end

function ExitPropertyDrugs(name)
	local propertydrugs  = GetPropertyDrugs(name)
	local playerPed = PlayerPedId()
	local outside   = nil
	CurrentPropertyDrugs = nil

	if propertydrugs.isSingle then
		outside = propertydrugs.outside
	else
		outside = GetGateway(propertydrugs).outside
	end

	TriggerServerEvent('polo_propertydrugs:deleteLastPropertyDrugs')

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		SetEntityCoords(playerPed, outside.x, outside.y, outside.z)

		for i=1, #propertydrugs.ipls, 1 do
			RemoveIpl(propertydrugs.ipls[i])
		end

		for i=1, #Config.PropertiesDrugs, 1 do
			Config.PropertiesDrugs[i].disabled = false
		end

		DoScreenFadeIn(800)
	end)
end

function PropertyDrugsIsOwned(propertydrugs)
	return OwnedPropertiesDrugs[propertydrugs.name] ~= nil
end

function OpenPropertyDrugsMenuDrugs(propertydrugs)
	local elements = {}
		table.insert(elements, {label = _U('enter'), value = 'enter'})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'propertydrugs', {
		title    = propertydrugs.label,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		if data.current.value == 'enter' then
			TriggerEvent('instance:create', 'propertydrugs', {propertydrugs = propertydrugs.name})
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'propertydrugs_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenGatewayOwnedPropertiesDrugsMenu(propertydrugs)
	local gatewayPropertiesDrugs = GetGatewayPropertiesDrugs(propertydrugs)
	local elements = {}

	for i=1, #gatewayPropertiesDrugs, 1 do
		if PropertyDrugsIsOwned(gatewayPropertiesDrugs[i]) then
			table.insert(elements, {
				label = gatewayPropertiesDrugs[i].label,
				value = gatewayPropertiesDrugs[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties', {
		title    = propertydrugs.name .. ' - ' .. _U('owned_properties'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()
		local elements = {{label = _U('enter'), value = 'enter'}}

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties_actions', {
			title    = data.current.label,
			align    = 'top-left',
			elements = elements
		}, function(data2, menu2)
			menu2.close()

			if data2.current.value == 'enter' then
				TriggerEvent('instance:create', 'propertydrugs', {propertydrugs = data.current.value})
				ESX.UI.Menu.CloseAll()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
	end)
end


function OpenRecolteWeedMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter de la Weed', value = 'recolte_weed'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter de la Weed',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_weed' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('weed:recolte')
			ESX.ShowHelpNotification('~g~Vous collectez de la Weed')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recolteweed_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementWeedMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter de la Weed', value = 'traitement_weed'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter de la Weed',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_weed' then

			ESX.UI.Menu.CloseAll()

			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('weed:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez de la Weed')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementweed_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteWeedMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre de la Weed', value = 'vente_weed'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes de Weed',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_weed' then

			ESX.UI.Menu.CloseAll()

			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('weed:vente')
			ESX.ShowHelpNotification('~g~Vous vendez de la Weed')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'venteweed_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenRecolteCokeMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter de la Coke', value = 'recolte_coke'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter de la Coke',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_coke' then

			ESX.UI.Menu.CloseAll()

			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('coke:recolte')
			ESX.ShowHelpNotification('~g~Vous collectez de la Coke')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recoltecoke_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementCokeMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter de la Coke', value = 'traitement_coke'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter de la Coke',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_coke' then

			ESX.UI.Menu.CloseAll()

			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('coke:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez de la Coke')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementcoke_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteCokeMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre de la Coke', value = 'vente_coke'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes de Coke',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_coke' then

			ESX.UI.Menu.CloseAll()

			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('coke:vente')
			ESX.ShowHelpNotification('~g~Vous vendez de la Coke')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'ventecoke_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenRecolteMethMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter de la Meth', value = 'recolte_meth'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter de la Meth',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_meth' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('meth:recolte')
			ESX.ShowHelpNotification('~g~Vous collectez de la Meth')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recoltemeth_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementMethMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter de la Meth', value = 'traitement_meth'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter de la Meth',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_meth' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('meth:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez de la Meth')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementmeth_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteMethMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre de la Meth', value = 'vente_meth'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes de Meth',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_meth' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('meth:vente')
			ESX.ShowHelpNotification('~g~Vous vendez de la Meth')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'ventemeth_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenRecolteCannabisMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter du Cannabis', value = 'recolte_cannabis'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter du Cannabis',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_cannabis' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('cannabis:recolte')
			ESX.ShowHelpNotification('~g~Vous récoltez du Cannabis')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recoltecannabis_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementCannabisMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter du Cannabis', value = 'traitement_cannabis'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter du Cannabis',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_cannabis' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('cannabis:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez du Cannabis')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementcannabis_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteCannabisMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre du Cannabis', value = 'vente_cannabis'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes de Cannabis',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_cannabis' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('cannabis:vente')
			ESX.ShowHelpNotification('~g~Vous vendez du Cannabis')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'ventecannabis_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenRecolteCrackMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter du Crack', value = 'recolte_crack'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter du Crack',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_crack' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('crack:recolte')
			ESX.ShowHelpNotification('~g~Vous récoltez du Crack')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recoltecrack_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementCrackMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter du Crack', value = 'traitement_crack'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter du Crack',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_crack' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('crack:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez du Crack')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementcrack_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteCrackMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre du Crack', value = 'vente_crack'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes de Crack',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_crack' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('crack:vente')
			ESX.ShowHelpNotification('~g~Vous vendez du Crack')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'ventecrack_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenRecolteEcstasyMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter de l\' Ecstasy', value = 'recolte_ecstasy'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter de l\' Ecstasy',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_ecstasy' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('ecstasy:recolte')
			ESX.ShowHelpNotification('~g~You Récolter de l\' Ecstasy')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recolteecstasy_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementEcstasyMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traitez de l\' Ecstasy', value = 'traitement_ecstasy'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter de l\' Ecstasy',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_ecstasy' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('ecstasy:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez de l\' Ecstasy')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementecstasy_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteEcstasyMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre de l\' Ecstasy', value = 'vente_ecstasy'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Vente d\' Ecstasy',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_ecstasy' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('ecstasy:vente')
			ESX.ShowHelpNotification('~g~Vous vendez de l\' Ecstasy')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'venteecstasy_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenRecolteHeroineMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter de l\' Heroine', value = 'recolte_heroine'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter de l\' Heroine',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_heroine' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('heroine:recolte')
			ESX.ShowHelpNotification('~g~You Récolter de l\' Heroine')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recolteheroine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementHeroineMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traitez de l\' Heroine', value = 'traitement_heroine'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter de l\' Heroine',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_heroine' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('heroine:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez de l\' Heroine')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementheroine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteHeroineMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre de l\' Heroine', value = 'vente_heroine'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Vente d\' Heroine',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_heroine' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('heroine:vente')
			ESX.ShowHelpNotification('~g~Vous vendez de l\' Heroine')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'venteheroine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenRecolteGHBMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter du GHB', value = 'recolte_ghb'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter du GHB',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_ghb' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('ghb:recolte')
			ESX.ShowHelpNotification('~g~Vous récoltez du GHB')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recolteghb_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementGHBMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter du GHB', value = 'traitement_ghb'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter du GHB',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_ghb' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('ghb:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez du GHB')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementghb_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteGHBMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre du GHB', value = 'vente_ghb'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes de GHB',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_ghb' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('ghb:vente')
			ESX.ShowHelpNotification('~g~Vous vendez du GHB')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'venteghb_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenRecoltePsychedeliquesMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter de la Psychedeliques', value = 'recolte_psychedeliques'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter de la Psychedeliques',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_psychedeliques' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('psychedeliques:recolte')
			ESX.ShowHelpNotification('~g~Vous collectez de la Psychedeliques')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recoltepsychedeliques_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementPsychedeliquesMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter de la Psychedeliques', value = 'traitement_psychedeliques'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter de la Psychedeliques',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_psychedeliques' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('psychedeliques:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez de la Psychedeliques')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementpsychedeliques_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVentePsychedeliquesMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre de la Psychedeliques', value = 'vente_psychedeliques'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes de Psychedeliques',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_psychedeliques' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('psychedeliques:vente')
			ESX.ShowHelpNotification('~g~Vous vendez de la Psychedeliques')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'ventepsychedeliques_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenRecolteOpiumMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter de l\' Opium', value = 'recolte_opium'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter de l\' Opium',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_opium' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('opium:recolte')
			ESX.ShowHelpNotification('~g~You Récolter de l\' Opium')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recolteopium_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementOpiumMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traitez de l\' Opium', value = 'traitement_opium'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter de l\' Opium',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_opium' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('opium:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez de l\' Opium')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementopium_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteOpiumMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre de l\' Opium', value = 'vente_opium'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Vente d\' Opium',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_opium' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('opium:vente')
			ESX.ShowHelpNotification('~g~Vous vendez de l\' Opium')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'venteopium_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenRecolteKetamineMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter de la Ketamine', value = 'recolte_ketamine'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter de la Ketamine',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_ketamine' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('ketamine:recolte')
			ESX.ShowHelpNotification('~g~Vous collectez de la Ketamine')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recolteketamine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementKetamineMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter de la Ketamine', value = 'traitement_ketamine'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter de la Ketamine',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_ketamine' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('ketamine:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez de la Ketamine')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementketamine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteKetamineMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre de la Ketamine', value = 'vente_ketamine'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes de Ketamine',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_ketamine' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('ketamine:vente')
			ESX.ShowHelpNotification('~g~Vous vendez de la Ketamine')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'venteketamine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenRecolteLSDMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter de la LSD', value = 'recolte_lsd'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter de la LSD',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_lsd' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('lsd:recolte')
			ESX.ShowHelpNotification('~g~Vous collectez de la LSD')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recoltelsd_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementLSDMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter de la LSD', value = 'traitement_lsd'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter de la LSD',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_lsd' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('lsd:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez de la LSD')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementlsd_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteLSDMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre de la LSD', value = 'vente_lsd'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes de LSD',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_lsd' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('lsd:vente')
			ESX.ShowHelpNotification('~g~Vous vendez de la LSD')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'ventelsd_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenRecolteMorphineMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter de la Morphine', value = 'recolte_morphine'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter de la Morphine',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_morphine' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('morphine:recolte')
			ESX.ShowHelpNotification('~g~Vous collectez de la Morphine')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recoltemorphine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementMorphineMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter de la Morphine', value = 'traitement_morphine'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter de la Morphine',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_morphine' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('morphine:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez de la Morphine')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementmorphine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteMorphineMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre de la Morphine', value = 'vente_morphine'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes de Morphine',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_morphine' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('morphine:vente')
			ESX.ShowHelpNotification('~g~Vous vendez de la Morphine')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'ventemorphine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenRecolteLeanMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter de la Lean', value = 'recolte_lean'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter Lean',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_lean' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('lean:recolte')
			ESX.ShowHelpNotification('~g~Vous collectez de la Lean')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recoltelean_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementLeanMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter de la Lean', value = 'traitement_lean'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter de la Lean',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_lean' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('lean:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez de la Lean')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementlean_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteLeanMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre de la Lean', value = 'vente_lean'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes de Lean',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_lean' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('lean:vente')
			ESX.ShowHelpNotification('~g~Vous vendez de la Lean')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'ventelean_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenRecolteAmphetaminesMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter de l\' Amphetamines', value = 'recolte_amphetamines'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter de l\' Amphetamines',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_amphetamines' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('amphetamines:recolte')
			ESX.ShowHelpNotification('~g~You Récolter de l\' Amphetamines')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recolteamphetamines_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementAmphetaminesMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traitez de l\' Amphetamines', value = 'traitement_amphetamines'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter de l\' Amphetamines',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_amphetamines' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('amphetamines:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez de l\' Amphetamines')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementamphetamines_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteAmphetaminesMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre de l\' Amphetamines', value = 'vente_amphetamines'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Vente d\' Amphetamines',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_amphetamines' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('amphetamines:vente')
			ESX.ShowHelpNotification('~g~Vous vendez de l\' Amphetamines')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'venteamphetamines_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenRecolteMarijuanaMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter de la Marijuana', value = 'recolte_marijuana'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter de la Marijuana',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_marijuana' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('marijuana:recolte')
			ESX.ShowHelpNotification('~g~Vous collectez de la Marijuana')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recoltemarijuana_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementMarijuanaMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter de la Marijuana', value = 'traitement_marijuana'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter de la Marijuana',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_marijuana' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('marijuana:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez de la Marijuana')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementmarijuana_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteMarijuanaMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre de la Marijuana', value = 'vente_marijuana'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes de Marijuana',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_marijuana' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('marijuana:vente')
			ESX.ShowHelpNotification('~g~Vous vendez de la Marijuana')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'ventemarijuana_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenRecolteSpeedMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter du Speed', value = 'recolte_speed'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter du Speed',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_speed' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('speed:recolte')
			ESX.ShowHelpNotification('~g~Vous collectez du Speed')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recoltespeed_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementSpeedMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter du Speed', value = 'traitement_speed'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter the Speed',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_speed' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('speed:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez du Speed')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementspeed_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteSpeedMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre du Speed', value = 'vente_speed'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes de Speed',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_speed' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('speed:vente')
			ESX.ShowHelpNotification('~g~Vous vendez du Speed')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'ventespeed_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenRecolteThcMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Récolter du THC', value = 'recolte_thc'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Récolter du THC',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'recolte_thc' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('thc:recolte')
			ESX.ShowHelpNotification('~g~Vous collectez du THC')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'recoltethc_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenTraitementThcMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Traiter du THC', value = 'traitement_thc'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Traiter du THC',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'traitement_thc' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('thc:traitement')
			ESX.ShowHelpNotification('~g~Vous traitez du THC')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'traitementthc_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end
function OpenVenteThcMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Vendre du THC', value = 'vente_thc'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Ventes du THC',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'vente_thc' then

			ESX.UI.Menu.CloseAll()
			FreezeEntityPosition(PlayerPedId(), true)
			TriggerServerEvent('thc:vente')
			ESX.ShowHelpNotification('~g~Vous vendez du THC')
			Wait(10000)
			FreezeEntityPosition(PlayerPedId(), false)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'ventethc_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

function OpenBlanchimentMenu(propertydrugs)
	local entering = nil
	local elements = {}

	table.insert(elements, {label = 'Blanchir de l\'argent sale', value = 'wash_money'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'blanchiment_menu', {
		title    = 'Blanchis ton argent sale',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'wash_money' then
			TriggerServerEvent('polo_propertydrugs:startWhitening', percent)	
		end
    end, function(data, menu)


		menu.close()

		CurrentAction     = 'blanchiment_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {propertydrugs = propertydrugs}
	end)
end

RegisterNetEvent("polo_propertydrugs:notify")
AddEventHandler("polo_propertydrugs:notify", function(icon, type, sender, title, text)
    Citizen.CreateThread(function()
        Wait(1)
        SetNotificationTextEntry("STRING");
        AddTextComponentString(text);
        SetNotificationMessage(icon, icon, true, type, sender, title, text);
        DrawNotification(false, true);
    end)
end)

RegisterNetEvent('drug1:animation')
AddEventHandler('drug1:animation', function()
	TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, true)
	Citizen.Wait(10000)
	ClearPedTasksImmediately(PlayerPedId())
end)

AddEventHandler('instance:loaded', function()
	TriggerEvent('instance:registerType', 'propertydrugs', function(instance)
		EnterPropertyDrugs(instance.data.propertydrugs)
	end, function(instance)
		ExitPropertyDrugs(instance.data.propertydrugs)
	end)
end)

AddEventHandler('esx:onPlayerSpawn', function()
	if firstSpawn then
		Citizen.CreateThread(function()
			while not ESX.IsPlayerLoaded() do
				Citizen.Wait(0)
			end

			ESX.TriggerServerCallback('polo_propertydrugs:getLastPropertyDrugs', function(propertydrugsName)
				if propertydrugsName then
					if propertydrugsName ~= ''  then
						local propertydrugs = GetPropertyDrugs(propertydrugsName)

						for i=1, #propertydrugs.ipls, 1 do
							RequestIpl(propertydrugs.ipls[i])

							while not IsIplActive(propertydrugs.ipls[i]) do
								Citizen.Wait(0)
							end
						end

						TriggerEvent('instance:create', 'propertydrugs', {propertydrugs = propertydrugsName})
					end
				end
			end)
		end)

		firstSpawn = false
	end
end)



AddEventHandler('polo_propertydrugs:getPropertiesDrugs', function(cb)
	cb(GetPropertiesDrugs())
end)

AddEventHandler('polo_propertydrugs:getPropertyDrugs', function(name, cb)
	cb(GetPropertyDrugs(name))
end)

AddEventHandler('polo_propertydrugs:getGateway', function(propertydrugs, cb)
	cb(GetGateway(propertydrugs))
end)

RegisterNetEvent('polo_propertydrugs:update')
AddEventHandler('polo_propertydrugs:update', function()

end)

RegisterNetEvent('polo_propertydrugs:setPropertyDrugsOwned')
AddEventHandler('polo_propertydrugs:setPropertyDrugsOwned', function(name, owned, rented)
	SetPropertyDrugsOwned(name, owned, rented)
end)

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'propertydrugs' then
		TriggerEvent('instance:enter', instance)
	end
end)

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(instance)
	if instance.type == 'propertydrugs' then
		local propertydrugs = GetPropertyDrugs(instance.data.propertydrugs)
		local isHost   = GetPlayerFromServerId(instance.host) == PlayerId()
		local isOwned  = true

		if PropertyDrugsIsOwned(propertydrugs) == true then
			isOwned = true
		end

		if isOwned or not isHost then
			hasChest = true
		else
			hasChest = false
		end
	end
end)

RegisterNetEvent('instance:onPlayerLeft')
AddEventHandler('instance:onPlayerLeft', function(instance)
	if player == instance.host then
		TriggerEvent('instance:leave')
	end
end)

AddEventHandler('polo_propertydrugs:hasEnteredMarker', function(name, part)
	local propertydrugs = GetPropertyDrugs(name)

	if part == 'entering' then
		if propertydrugs.isSingle then
			CurrentAction     = 'propertydrugs_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {propertydrugs = propertydrugs}
		else
			CurrentAction     = 'gateway_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {propertydrugs = propertydrugs}
		end
	elseif part == 'exit' then
		CurrentAction     = 'room_exit'
		CurrentActionMsg  = _U('press_to_exit')
		CurrentActionData = {propertydrugsName = name}
	elseif part == 'recolteWeedMenu' then
		CurrentAction     = 'recolteweed_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementWeedMenu' then
		CurrentAction     = 'traitementweed_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteWeedMenu' then
		CurrentAction     = 'venteweed_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteCokeMenu' then
		CurrentAction     = 'recoltecoke_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementCokeMenu' then
		CurrentAction     = 'traitementcoke_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteCokeMenu' then
		CurrentAction     = 'ventecoke_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteMethMenu' then
		CurrentAction     = 'recoltemeth_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementMethMenu' then
		CurrentAction     = 'traitementmeth_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteMethMenu' then
		CurrentAction     = 'ventemeth_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteCannabisMenu' then
		CurrentAction     = 'recoltecannabis_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementCannabisMenu' then
		CurrentAction     = 'traitementcannabis_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteCannabisMenu' then
		CurrentAction     = 'ventecannabis_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteCrackMenu' then
		CurrentAction     = 'recoltecrack_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementCrackMenu' then
		CurrentAction     = 'traitementcrack_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteCrackMenu' then
		CurrentAction     = 'ventecrack_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteEcstasyMenu' then
		CurrentAction     = 'recolteecstasy_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementEcstasyMenu' then
		CurrentAction     = 'traitementecstasy_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteEcstasyMenu' then
		CurrentAction     = 'venteecstasy_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteHeroineMenu' then
		CurrentAction     = 'recolteheroine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementHeroineMenu' then
		CurrentAction     = 'traitementheroine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteHeroineMenu' then
		CurrentAction     = 'venteheroine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteGHBMenu' then
		CurrentAction     = 'recolteghb_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementGHBMenu' then
		CurrentAction     = 'traitementghb_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteGHBMenu' then
		CurrentAction     = 'venteghb_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recoltePsychedeliquesMenu' then
		CurrentAction     = 'recoltepsychedeliques_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementPsychedeliquesMenu' then
		CurrentAction     = 'traitementpsychedeliques_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'ventePsychedeliquesMenu' then
		CurrentAction     = 'ventepsychedeliques_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteOpiumMenu' then
		CurrentAction     = 'recolteopium_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementOpiumMenu' then
		CurrentAction     = 'traitementopium_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteOpiumMenu' then
		CurrentAction     = 'venteopium_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteKetamineMenu' then
		CurrentAction     = 'recolteketamine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementKetamineMenu' then
		CurrentAction     = 'traitementketamine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteKetamineMenu' then
		CurrentAction     = 'venteketamine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteLSDMenu' then
		CurrentAction     = 'recoltelsd_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementLSDMenu' then
		CurrentAction     = 'traitementlsd_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteLSDMenu' then
		CurrentAction     = 'ventelsd_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteMorphineMenu' then
		CurrentAction     = 'recoltemorphine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementMorphineMenu' then
		CurrentAction     = 'traitementmorphine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteMorphineMenu' then
		CurrentAction     = 'ventemorphine_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteLeanMenu' then
		CurrentAction     = 'recoltelean_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementLeanMenu' then
		CurrentAction     = 'traitementlean_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteLeanMenu' then
		CurrentAction     = 'ventelean_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteAmphetaminesMenu' then
		CurrentAction     = 'recolteamphetamines_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementAmphetaminesMenu' then
		CurrentAction     = 'traitementamphetamines_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteAmphetaminesMenu' then
		CurrentAction     = 'venteamphetamines_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteMarijuanaMenu' then
		CurrentAction     = 'recoltemarijuana_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementMarijuanaMenu' then
		CurrentAction     = 'traitementmarijuana_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteMarijuanaMenu' then
		CurrentAction     = 'ventemarijuana_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteSpeedMenu' then
		CurrentAction     = 'recoltespeed_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementSpeedMenu' then
		CurrentAction     = 'traitementspeed_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteSpeedMenu' then
		CurrentAction     = 'ventespeed_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'recolteThcMenu' then
		CurrentAction     = 'recoltethc_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'traitementThcMenu' then
		CurrentAction     = 'traitementthc_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'venteThcMenu' then
		CurrentAction     = 'ventethc_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {}
	elseif part == 'BlanchimentMenu' then
		CurrentAction     = 'blanchiment_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {zone = zone}
		
	end
end)

AddEventHandler('polo_propertydrugs:hasExitedMarker', function(name, part)
	local playerPed      = PlayerPedId()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
	ClearPedTasks(playerPed)
	TriggerServerEvent('esx_blanchisseur:stopWhitening')
end)

-- Enter / Exit marker events & Draw markers
Citizen.CreateThread(function(owned)
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep = false, true
		local currentPropertyDrugs, currentPart

		for i=1, #Config.PropertiesDrugs, 1 do
			local propertydrugs = Config.PropertiesDrugs[i]

			-- Entering
			if propertydrugs.entering and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.entering.x, propertydrugs.entering.y, propertydrugs.entering.z, true)

				if distance < Config.DrawDistance then
				
						DrawMarker(Config.MarkerType, propertydrugs.entering.x, propertydrugs.entering.y, propertydrugs.entering.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
				
						if Config.MarkerText == true then
						ESX.Game.Utils.DrawText3D(propertydrugs.entering, "", 2)
					end
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'entering'
				end
			end

			-- Exit
			if propertydrugs.exit and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.exit.x, propertydrugs.exit.y, propertydrugs.exit.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.exit.x, propertydrugs.exit.y, propertydrugs.exit.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'exit'
				end
			end

			-- Weed Recolte menu
			if propertydrugs.recolteWeedMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteWeedMenu.x, propertydrugs.recolteWeedMenu.y, propertydrugs.recolteWeedMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteWeedMenu.x, propertydrugs.recolteWeedMenu.y, propertydrugs.recolteWeedMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteWeedMenu'
				end
			end
			-- Traitement Weed menu
			if propertydrugs.traitementWeedMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementWeedMenu.x, propertydrugs.traitementWeedMenu.y, propertydrugs.traitementWeedMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementWeedMenu.x, propertydrugs.traitementWeedMenu.y, propertydrugs.traitementWeedMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementWeedMenu'
				end
			end
			-- Vente Weed menu
			if propertydrugs.venteWeedMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteWeedMenu.x, propertydrugs.venteWeedMenu.y, propertydrugs.venteWeedMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteWeedMenu.x, propertydrugs.venteWeedMenu.y, propertydrugs.venteWeedMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteWeedMenu'
				end
			end
			-- Coke Recolte menu
			if propertydrugs.recolteCokeMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteCokeMenu.x, propertydrugs.recolteCokeMenu.y, propertydrugs.recolteCokeMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteCokeMenu.x, propertydrugs.recolteCokeMenu.y, propertydrugs.recolteCokeMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteCokeMenu'
				end
			end
			-- Traitement Coke menu
			if propertydrugs.traitementCokeMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementCokeMenu.x, propertydrugs.traitementCokeMenu.y, propertydrugs.traitementCokeMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementCokeMenu.x, propertydrugs.traitementCokeMenu.y, propertydrugs.traitementCokeMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementCokeMenu'
				end
			end
			-- Vente Coke menu
			if propertydrugs.venteCokeMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteCokeMenu.x, propertydrugs.venteCokeMenu.y, propertydrugs.venteCokeMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteCokeMenu.x, propertydrugs.venteCokeMenu.y, propertydrugs.venteCokeMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteCokeMenu'
				end
			end
			-- Meth Recolte menu
			if propertydrugs.recolteMethMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteMethMenu.x, propertydrugs.recolteMethMenu.y, propertydrugs.recolteMethMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteMethMenu.x, propertydrugs.recolteMethMenu.y, propertydrugs.recolteMethMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteMethMenu'
				end
			end
			-- Traitement Meth menu
			if propertydrugs.traitementMethMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementMethMenu.x, propertydrugs.traitementMethMenu.y, propertydrugs.traitementMethMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementMethMenu.x, propertydrugs.traitementMethMenu.y, propertydrugs.traitementMethMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementMethMenu'
				end
			end
			-- Vente Meth menu
			if propertydrugs.venteMethMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteMethMenu.x, propertydrugs.venteMethMenu.y, propertydrugs.venteMethMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteMethMenu.x, propertydrugs.venteMethMenu.y, propertydrugs.venteMethMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteMethMenu'
				end
			end
			-- Cannabis Recolte menu
			if propertydrugs.recolteCannabisMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteCannabisMenu.x, propertydrugs.recolteCannabisMenu.y, propertydrugs.recolteCannabisMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteCannabisMenu.x, propertydrugs.recolteCannabisMenu.y, propertydrugs.recolteCannabisMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteCannabisMenu'
				end
			end
			-- Traitement Cannabis menu
			if propertydrugs.traitementCannabisMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementCannabisMenu.x, propertydrugs.traitementCannabisMenu.y, propertydrugs.traitementCannabisMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementCannabisMenu.x, propertydrugs.traitementCannabisMenu.y, propertydrugs.traitementCannabisMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementCannabisMenu'
				end
			end
			-- Vente Cannabis menu
			if propertydrugs.venteCannabisMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteCannabisMenu.x, propertydrugs.venteCannabisMenu.y, propertydrugs.venteCannabisMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteCannabisMenu.x, propertydrugs.venteCannabisMenu.y, propertydrugs.venteCannabisMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteCannabisMenu'
				end
			end

			-- Crack Recolte menu
			if propertydrugs.recolteCrackMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteCrackMenu.x, propertydrugs.recolteCrackMenu.y, propertydrugs.recolteCrackMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteCrackMenu.x, propertydrugs.recolteCrackMenu.y, propertydrugs.recolteCrackMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteCrackMenu'
				end
			end
			-- Traitement Crack menu
			if propertydrugs.traitementCrackMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementCrackMenu.x, propertydrugs.traitementCrackMenu.y, propertydrugs.traitementCrackMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementCrackMenu.x, propertydrugs.traitementCrackMenu.y, propertydrugs.traitementCrackMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementCrackMenu'
				end
			end
			-- Vente Crack menu
			if propertydrugs.venteCrackMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteCrackMenu.x, propertydrugs.venteCrackMenu.y, propertydrugs.venteCrackMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteCrackMenu.x, propertydrugs.venteCrackMenu.y, propertydrugs.venteCrackMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteCrackMenu'
				end
			end
			-- Ecstasy Recolte menu
			if propertydrugs.recolteEcstasyMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteEcstasyMenu.x, propertydrugs.recolteEcstasyMenu.y, propertydrugs.recolteEcstasyMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteEcstasyMenu.x, propertydrugs.recolteEcstasyMenu.y, propertydrugs.recolteEcstasyMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteEcstasyMenu'
				end
			end
			-- Traitement Ecstasy menu
			if propertydrugs.traitementEcstasyMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementEcstasyMenu.x, propertydrugs.traitementEcstasyMenu.y, propertydrugs.traitementEcstasyMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementEcstasyMenu.x, propertydrugs.traitementEcstasyMenu.y, propertydrugs.traitementEcstasyMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementEcstasyMenu'
				end
			end
			-- Vente Ecstasy menu
			if propertydrugs.venteEcstasyMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteEcstasyMenu.x, propertydrugs.venteEcstasyMenu.y, propertydrugs.venteEcstasyMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteEcstasyMenu.x, propertydrugs.venteEcstasyMenu.y, propertydrugs.venteEcstasyMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteEcstasyMenu'
				end
			end
			-- Heroine Recolte menu
			if propertydrugs.recolteHeroineMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteHeroineMenu.x, propertydrugs.recolteHeroineMenu.y, propertydrugs.recolteHeroineMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteHeroineMenu.x, propertydrugs.recolteHeroineMenu.y, propertydrugs.recolteHeroineMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteHeroineMenu'
				end
			end
			-- Traitement Heroine menu
			if propertydrugs.traitementHeroineMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementHeroineMenu.x, propertydrugs.traitementHeroineMenu.y, propertydrugs.traitementHeroineMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementHeroineMenu.x, propertydrugs.traitementHeroineMenu.y, propertydrugs.traitementHeroineMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementHeroineMenu'
				end
			end
			-- Vente Heroine menu
			if propertydrugs.venteHeroineMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteHeroineMenu.x, propertydrugs.venteHeroineMenu.y, propertydrugs.venteHeroineMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteHeroineMenu.x, propertydrugs.venteHeroineMenu.y, propertydrugs.venteHeroineMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteHeroineMenu'
				end
			end
			-- GHB Recolte menu
			if propertydrugs.recolteGHBMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteGHBMenu.x, propertydrugs.recolteGHBMenu.y, propertydrugs.recolteGHBMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteGHBMenu.x, propertydrugs.recolteGHBMenu.y, propertydrugs.recolteGHBMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteGHBMenu'
				end
			end
			-- Traitement GHB menu
			if propertydrugs.traitementGHBMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementGHBMenu.x, propertydrugs.traitementGHBMenu.y, propertydrugs.traitementGHBMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementGHBMenu.x, propertydrugs.traitementGHBMenu.y, propertydrugs.traitementGHBMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementGHBMenu'
				end
			end
			-- Vente GHB menu
			if propertydrugs.venteGHBMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteGHBMenu.x, propertydrugs.venteGHBMenu.y, propertydrugs.venteGHBMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteGHBMenu.x, propertydrugs.venteGHBMenu.y, propertydrugs.venteGHBMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteGHBMenu'
				end
			end
			-- Psychedeliques Recolte menu
			if propertydrugs.recoltePsychedeliquesMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recoltePsychedeliquesMenu.x, propertydrugs.recoltePsychedeliquesMenu.y, propertydrugs.recoltePsychedeliquesMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recoltePsychedeliquesMenu.x, propertydrugs.recoltePsychedeliquesMenu.y, propertydrugs.recoltePsychedeliquesMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recoltePsychedeliquesMenu'
				end
			end
			-- Traitement Psychedeliques menu
			if propertydrugs.traitementPsychedeliquesMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementPsychedeliquesMenu.x, propertydrugs.traitementPsychedeliquesMenu.y, propertydrugs.traitementPsychedeliquesMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementPsychedeliquesMenu.x, propertydrugs.traitementPsychedeliquesMenu.y, propertydrugs.traitementPsychedeliquesMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementPsychedeliquesMenu'
				end
			end
			-- Vente Psychedeliques menu
			if propertydrugs.ventePsychedeliquesMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.ventePsychedeliquesMenu.x, propertydrugs.ventePsychedeliquesMenu.y, propertydrugs.ventePsychedeliquesMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.ventePsychedeliquesMenu.x, propertydrugs.ventePsychedeliquesMenu.y, propertydrugs.ventePsychedeliquesMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'ventePsychedeliquesMenu'
				end
			end
			-- Opium Recolte menu
			if propertydrugs.recolteOpiumMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteOpiumMenu.x, propertydrugs.recolteOpiumMenu.y, propertydrugs.recolteOpiumMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteOpiumMenu.x, propertydrugs.recolteOpiumMenu.y, propertydrugs.recolteOpiumMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteOpiumMenu'
				end
			end
			-- Traitement Opium menu
			if propertydrugs.traitementOpiumMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementOpiumMenu.x, propertydrugs.traitementOpiumMenu.y, propertydrugs.traitementOpiumMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementOpiumMenu.x, propertydrugs.traitementOpiumMenu.y, propertydrugs.traitementOpiumMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementOpiumMenu'
				end
			end
			-- Vente Opium menu
			if propertydrugs.venteOpiumMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteOpiumMenu.x, propertydrugs.venteOpiumMenu.y, propertydrugs.venteOpiumMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteOpiumMenu.x, propertydrugs.venteOpiumMenu.y, propertydrugs.venteOpiumMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteOpiumMenu'
				end
			end
			-- Ketamine Recolte menu
			if propertydrugs.recolteKetamineMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteKetamineMenu.x, propertydrugs.recolteKetamineMenu.y, propertydrugs.recolteKetamineMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteKetamineMenu.x, propertydrugs.recolteKetamineMenu.y, propertydrugs.recolteKetamineMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteKetamineMenu'
				end
			end
			-- Traitement Ketamine menu
			if propertydrugs.traitementKetamineMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementKetamineMenu.x, propertydrugs.traitementKetamineMenu.y, propertydrugs.traitementKetamineMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementKetamineMenu.x, propertydrugs.traitementKetamineMenu.y, propertydrugs.traitementKetamineMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementKetamineMenu'
				end
			end
			-- Vente Ketamine menu
			if propertydrugs.venteKetamineMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteKetamineMenu.x, propertydrugs.venteKetamineMenu.y, propertydrugs.venteKetamineMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteKetamineMenu.x, propertydrugs.venteKetamineMenu.y, propertydrugs.venteKetamineMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteKetamineMenu'
				end
			end
			-- LSD Recolte menu
			if propertydrugs.recolteLSDMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteLSDMenu.x, propertydrugs.recolteLSDMenu.y, propertydrugs.recolteLSDMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteLSDMenu.x, propertydrugs.recolteLSDMenu.y, propertydrugs.recolteLSDMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteLSDMenu'
				end
			end
			-- Traitement LSD menu
			if propertydrugs.traitementLSDMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementLSDMenu.x, propertydrugs.traitementLSDMenu.y, propertydrugs.traitementLSDMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementLSDMenu.x, propertydrugs.traitementLSDMenu.y, propertydrugs.traitementLSDMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementLSDMenu'
				end
			end
			-- Vente LSD menu
			if propertydrugs.venteLSDMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteLSDMenu.x, propertydrugs.venteLSDMenu.y, propertydrugs.venteLSDMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteLSDMenu.x, propertydrugs.venteLSDMenu.y, propertydrugs.venteLSDMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteLSDMenu'
				end
			end
			-- Morphine Recolte menu
			if propertydrugs.recolteMorphineMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteMorphineMenu.x, propertydrugs.recolteMorphineMenu.y, propertydrugs.recolteMorphineMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteMorphineMenu.x, propertydrugs.recolteMorphineMenu.y, propertydrugs.recolteMorphineMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteMorphineMenu'
				end
			end
			-- Traitement Morphine menu
			if propertydrugs.traitementMorphineMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementMorphineMenu.x, propertydrugs.traitementMorphineMenu.y, propertydrugs.traitementMorphineMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementMorphineMenu.x, propertydrugs.traitementMorphineMenu.y, propertydrugs.traitementMorphineMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementMorphineMenu'
				end
			end
			-- Vente Morphine menu
			if propertydrugs.venteMorphineMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteMorphineMenu.x, propertydrugs.venteMorphineMenu.y, propertydrugs.venteMorphineMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteMorphineMenu.x, propertydrugs.venteMorphineMenu.y, propertydrugs.venteMorphineMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteMorphineMenu'
				end
			end
			-- Lean Recolte menu
			if propertydrugs.recolteLeanMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteLeanMenu.x, propertydrugs.recolteLeanMenu.y, propertydrugs.recolteLeanMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteLeanMenu.x, propertydrugs.recolteLeanMenu.y, propertydrugs.recolteLeanMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteLeanMenu'
				end
			end
			-- Traitement Lean menu
			if propertydrugs.traitementLeanMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementLeanMenu.x, propertydrugs.traitementLeanMenu.y, propertydrugs.traitementLeanMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementLeanMenu.x, propertydrugs.traitementLeanMenu.y, propertydrugs.traitementLeanMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementLeanMenu'
				end
			end
			-- Vente Lean menu
			if propertydrugs.venteLeanMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteLeanMenu.x, propertydrugs.venteLeanMenu.y, propertydrugs.venteLeanMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteLeanMenu.x, propertydrugs.venteLeanMenu.y, propertydrugs.venteLeanMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteLeanMenu'
				end
			end
			-- Amphetamines Recolte menu
			if propertydrugs.recolteAmphetaminesMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteAmphetaminesMenu.x, propertydrugs.recolteAmphetaminesMenu.y, propertydrugs.recolteAmphetaminesMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteAmphetaminesMenu.x, propertydrugs.recolteAmphetaminesMenu.y, propertydrugs.recolteAmphetaminesMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteAmphetaminesMenu'
				end
			end
			-- Traitement Amphetamines menu
			if propertydrugs.traitementAmphetaminesMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementAmphetaminesMenu.x, propertydrugs.traitementAmphetaminesMenu.y, propertydrugs.traitementAmphetaminesMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementAmphetaminesMenu.x, propertydrugs.traitementAmphetaminesMenu.y, propertydrugs.traitementAmphetaminesMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementAmphetaminesMenu'
				end
			end
			-- Vente Amphetamines menu
			if propertydrugs.venteAmphetaminesMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteAmphetaminesMenu.x, propertydrugs.venteAmphetaminesMenu.y, propertydrugs.venteAmphetaminesMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteAmphetaminesMenu.x, propertydrugs.venteAmphetaminesMenu.y, propertydrugs.venteAmphetaminesMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteAmphetaminesMenu'
				end
			end
			-- Marijuana Recolte menu
			if propertydrugs.recolteMarijuanaMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteMarijuanaMenu.x, propertydrugs.recolteMarijuanaMenu.y, propertydrugs.recolteMarijuanaMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteMarijuanaMenu.x, propertydrugs.recolteMarijuanaMenu.y, propertydrugs.recolteMarijuanaMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteMarijuanaMenu'
				end
			end
			-- Traitement Marijuana menu
			if propertydrugs.traitementMarijuanaMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementMarijuanaMenu.x, propertydrugs.traitementMarijuanaMenu.y, propertydrugs.traitementMarijuanaMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementMarijuanaMenu.x, propertydrugs.traitementMarijuanaMenu.y, propertydrugs.traitementMarijuanaMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementMarijuanaMenu'
				end
			end
			-- Vente Marijuana menu
			if propertydrugs.venteMarijuanaMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteMarijuanaMenu.x, propertydrugs.venteMarijuanaMenu.y, propertydrugs.venteMarijuanaMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteMarijuanaMenu.x, propertydrugs.venteMarijuanaMenu.y, propertydrugs.venteMarijuanaMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteMarijuanaMenu'
				end
			end
			-- Speed Recolte menu
			if propertydrugs.recolteSpeedMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteSpeedMenu.x, propertydrugs.recolteSpeedMenu.y, propertydrugs.recolteSpeedMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteSpeedMenu.x, propertydrugs.recolteSpeedMenu.y, propertydrugs.recolteSpeedMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteSpeedMenu'
				end
			end
			-- Traitement Speed menu
			if propertydrugs.traitementSpeedMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementSpeedMenu.x, propertydrugs.traitementSpeedMenu.y, propertydrugs.traitementSpeedMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementSpeedMenu.x, propertydrugs.traitementSpeedMenu.y, propertydrugs.traitementSpeedMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementSpeedMenu'
				end
			end
			-- Vente Speed menu
			if propertydrugs.venteSpeedMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteSpeedMenu.x, propertydrugs.venteSpeedMenu.y, propertydrugs.venteSpeedMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteSpeedMenu.x, propertydrugs.venteSpeedMenu.y, propertydrugs.venteSpeedMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteSpeedMenu'
				end
			end
			-- Thc Recolte menu
			if propertydrugs.recolteThcMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.recolteThcMenu.x, propertydrugs.recolteThcMenu.y, propertydrugs.recolteThcMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.recolteThcMenu.x, propertydrugs.recolteThcMenu.y, propertydrugs.recolteThcMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'recolteThcMenu'
				end
			end
			-- Traitement Thc menu
			if propertydrugs.traitementThcMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.traitementThcMenu.x, propertydrugs.traitementThcMenu.y, propertydrugs.traitementThcMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.traitementThcMenu.x, propertydrugs.traitementThcMenu.y, propertydrugs.traitementThcMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'traitementThcMenu'
				end
			end
			-- Vente Thc menu
			if propertydrugs.venteThcMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.venteThcMenu.x, propertydrugs.venteThcMenu.y, propertydrugs.venteThcMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.venteThcMenu.x, propertydrugs.venteThcMenu.y, propertydrugs.venteThcMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'venteThcMenu'
				end
			end
			if propertydrugs.BlanchimentMenu and not propertydrugs.disabled then
				local distance = GetDistanceBetweenCoords(coords, propertydrugs.BlanchimentMenu.x, propertydrugs.BlanchimentMenu.y, propertydrugs.BlanchimentMenu.z, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.MarkerType, propertydrugs.BlanchimentMenu.x, propertydrugs.BlanchimentMenu.y, propertydrugs.BlanchimentMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end

				if distance < Config.MarkerSize.x then
					isInMarker      = true
					currentPropertyDrugs = propertydrugs.name
					currentPart     = 'BlanchimentMenu'
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker or (isInMarker and (LastPropertyDrugs ~= currentPropertyDrugs or LastPart ~= currentPart) ) then
			hasAlreadyEnteredMarker = true
			LastPropertyDrugs            = currentPropertyDrugs
			LastPart                = currentPart

			TriggerEvent('polo_propertydrugs:hasEnteredMarker', currentPropertyDrugs, currentPart)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('polo_propertydrugs:hasExitedMarker', LastPropertyDrugs, LastPart)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'propertydrugs_menu' then
					OpenPropertyDrugsMenuDrugs(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'gateway_menu' then
					OpenGatewayMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recolteweed_menu' then
					OpenRecolteWeedMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementweed_menu' then
					OpenTraitementWeedMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'venteweed_menu' then
					OpenVenteWeedMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recoltecoke_menu' then
					OpenRecolteCokeMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementcoke_menu' then
					OpenTraitementCokeMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'ventecoke_menu' then
					OpenVenteCokeMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recoltemeth_menu' then
					OpenRecolteMethMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementmeth_menu' then
					OpenTraitementMethMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'ventemeth_menu' then
					OpenVenteMethMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recoltecannabis_menu' then
					OpenRecolteCannabisMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementcannabis_menu' then
					OpenTraitementCannabisMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'ventecannabis_menu' then
					OpenVenteCannabisMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recoltecrack_menu' then
					OpenRecolteCrackMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementcrack_menu' then
					OpenTraitementCrackMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'ventecrack_menu' then
					OpenVenteCrackMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recolteecstasy_menu' then
					OpenRecolteEcstasyMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementecstasy_menu' then
					OpenTraitementEcstasyMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'venteecstasy_menu' then
					OpenVenteEcstasyMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recolteheroine_menu' then
					OpenRecolteHeroineMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementheroine_menu' then
					OpenTraitementHeroineMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'venteheroine_menu' then
					OpenVenteHeroineMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recolteghb_menu' then
					OpenRecolteGHBMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementghb_menu' then
					OpenTraitementGHBMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'venteghb_menu' then
					OpenVenteGHBMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recoltepsychedeliques_menu' then
					OpenRecoltePsychedeliquesMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementpsychedeliques_menu' then
					OpenTraitementPsychedeliquesMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'ventepsychedeliques_menu' then
					OpenVentePsychedeliquesMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recolteopium_menu' then
					OpenRecolteOpiumMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementopium_menu' then
					OpenTraitementOpiumMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'venteopium_menu' then
					OpenVenteOpiumMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recolteketamine_menu' then
					OpenRecolteKetamineMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementketamine_menu' then
					OpenTraitementKetamineMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'venteketamine_menu' then
					OpenVenteKetamineMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recoltelsd_menu' then
					OpenRecolteLSDMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementlsd_menu' then
					OpenTraitementLSDMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'ventelsd_menu' then
					OpenVenteLSDMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recoltemorphine_menu' then
					OpenRecolteMorphineMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementmorphine_menu' then
					OpenTraitementMorphineMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'ventemorphine_menu' then
					OpenVenteMorphineMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recoltelean_menu' then
					OpenRecolteLeanMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementlean_menu' then
					OpenTraitementLeanMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'ventelean_menu' then
					OpenVenteLeanMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recolteamphetamines_menu' then
					OpenRecolteAmphetaminesMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementamphetamines_menu' then
					OpenTraitementAmphetaminesMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'venteamphetamines_menu' then
					OpenVenteAmphetaminesMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recoltemarijuana_menu' then
					OpenRecolteMarijuanaMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementmarijuana_menu' then
					OpenTraitementMarijuanaMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'ventemarijuana_menu' then
					OpenVenteMarijuanaMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recoltespeed_menu' then
					OpenRecolteSpeedMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementspeed_menu' then
					OpenTraitementSpeedMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'ventespeed_menu' then
					OpenVenteSpeedMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'recoltethc_menu' then
					OpenRecolteThcMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'traitementthc_menu' then
					OpenTraitementThcMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'ventethc_menu' then
					OpenVenteThcMenu(CurrentActionData.propertydrugs)
				elseif CurrentAction == 'blanchiment_menu' then
					OpenBlanchimentMenu(CurrentActionData.propertydrugs)

				elseif CurrentAction == 'room_exit' then
					TriggerEvent('instance:leave')
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)