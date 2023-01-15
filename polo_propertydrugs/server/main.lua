local isSingle = 1

function GetPropertyDrugs(name)
	for i=1, #Config.PropertiesDrugs, 1 do
		if Config.PropertiesDrugs[i].name == name then
			return Config.PropertiesDrugs[i]
		end
	end
end

MySQL.ready(function()
	Citizen.Wait(1500)

	MySQL.Async.fetchAll('SELECT * FROM `polo_drugsinterior`', {}, function(propertiesdrugs)

		for i=1, #propertiesdrugs, 1 do
			local entering  = nil
			local exit      = nil
			local inside    = nil
			local outside   = nil
			local isSingle  = nil
			local isRoom    = nil
			local isGateway = nil
			local recolteWeedMenu  = nil
			local traitementWeedMenu  = nil
			local venteWeedMenu  = nil
			local recolteCokeMenu  = nil
			local traitementCokeMenu  = nil
			local venteCokeMenu  = nil
			local recolteMethMenu  = nil
			local traitementMethMenu  = nil
			local venteMethMenu  = nil
			local recolteCannabisMenu  = nil
			local traitementCannabisMenu  = nil
			local venteCannabisMenu  = nil
			local recolteCrackMenu  = nil
			local traitementCrackMenu  = nil
			local venteCrackMenu  = nil
			local recolteEcstasyMenu  = nil
			local traitementEcstasyMenu  = nil
			local venteEcstasyMenu  = nil
			local recolteHeroineMenu  = nil
			local traitementHeroineMenu  = nil
			local venteHeroineMenu  = nil
			local recolteGHBMenu  = nil
			local traitementGHBMenu  = nil
			local venteGHBMenu  = nil
			local recoltePsychedeliquesMenu  = nil
			local traitementPsychedeliquesMenu  = nil
			local ventePsychedeliquesMenu  = nil
			local recolteOpiumMenu  = nil
			local traitementOpiumMenu  = nil
			local venteOpiumMenu  = nil
			local recolteKetamineMenu  = nil
			local traitementKetamineMenu  = nil
			local venteKetamineMenu  = nil
			local recolteLSDMenu  = nil
			local traitementLSDMenu  = nil
			local venteLSDMenu  = nil
			local recolteMorphineMenu  = nil
			local traitementMorphineMenu  = nil
			local venteMorphineMenu  = nil
			local recolteLeanMenu  = nil
			local traitementLeanMenu  = nil
			local venteLeanMenu  = nil
			local recolteAmphetaminesMenu  = nil
			local traitementAmphetaminesMenu  = nil
			local venteAmphetaminesMenu  = nil
			local recolteMarijuanaMenu  = nil
			local traitementMarijuanaMenu  = nil
			local venteMarijuanaMenu  = nil
			local recolteSpeedMenu  = nil
			local traitementSpeedMenu  = nil
			local venteSpeedMenu  = nil
			local BlanchimentMenu  = nil

			if propertiesdrugs[i].entering then
				entering = json.decode(propertiesdrugs[i].entering)
			end

			if propertiesdrugs[i].exit then
				exit = json.decode(propertiesdrugs[i].exit)
			end

			if propertiesdrugs[i].inside then
				inside = json.decode(propertiesdrugs[i].inside)
			end

			if propertiesdrugs[i].outside then
				outside = json.decode(propertiesdrugs[i].outside)
			end

			if propertiesdrugs[i].is_single == 0 then
				isSingle = false
			else
				isSingle = true
			end

			if propertiesdrugs[i].is_room == 0 then
				isRoom = false
			else
				isRoom = true
			end

			if propertiesdrugs[i].is_gateway == 0 then
				isGateway = false
			else
				isGateway = true
			end

			if propertiesdrugs[i].recolteweed_menu then
				recolteWeedMenu = json.decode(propertiesdrugs[i].recolteweed_menu)
			end

			if propertiesdrugs[i].traitementweed_menu then
				traitementWeedMenu = json.decode(propertiesdrugs[i].traitementweed_menu)
			end

			if propertiesdrugs[i].venteweed_menu then
				venteWeedMenu = json.decode(propertiesdrugs[i].venteweed_menu)
			end

			if propertiesdrugs[i].recoltecoke_menu then
				recolteCokeMenu = json.decode(propertiesdrugs[i].recoltecoke_menu)
			end

			if propertiesdrugs[i].traitementcoke_menu then
				traitementCokeMenu = json.decode(propertiesdrugs[i].traitementcoke_menu)
			end

			if propertiesdrugs[i].ventecoke_menu then
				venteCokeMenu = json.decode(propertiesdrugs[i].ventecoke_menu)
			end

			if propertiesdrugs[i].recoltemeth_menu then
				recolteMethMenu = json.decode(propertiesdrugs[i].recoltemeth_menu)
			end

			if propertiesdrugs[i].traitementmeth_menu then
				traitementMethMenu = json.decode(propertiesdrugs[i].traitementmeth_menu)
			end

			if propertiesdrugs[i].ventemeth_menu then
				venteMethMenu = json.decode(propertiesdrugs[i].ventemeth_menu)
			end

			if propertiesdrugs[i].recoltecannabis_menu then
				recolteCannabisMenu = json.decode(propertiesdrugs[i].recoltecannabis_menu)
			end

			if propertiesdrugs[i].traitementcannabis_menu then
				traitementCannabisMenu = json.decode(propertiesdrugs[i].traitementcannabis_menu)
			end

			if propertiesdrugs[i].ventecannabis_menu then
				venteCannabisMenu = json.decode(propertiesdrugs[i].ventecannabis_menu)
			end

			if propertiesdrugs[i].recoltecrack_menu then
				recolteCrackMenu = json.decode(propertiesdrugs[i].recoltecrack_menu)
			end

			if propertiesdrugs[i].traitementcrack_menu then
				traitementCrackMenu = json.decode(propertiesdrugs[i].traitementcrack_menu)
			end

			if propertiesdrugs[i].ventecrack_menu then
				venteCrackMenu = json.decode(propertiesdrugs[i].ventecrack_menu)
			end

			if propertiesdrugs[i].recolteecstasy_menu then
				recolteEcstasyMenu = json.decode(propertiesdrugs[i].recolteecstasy_menu)
			end

			if propertiesdrugs[i].traitementecstasy_menu then
				traitementEcstasyMenu = json.decode(propertiesdrugs[i].traitementecstasy_menu)
			end

			if propertiesdrugs[i].venteecstasy_menu then
				venteEcstasyMenu = json.decode(propertiesdrugs[i].venteecstasy_menu)
			end

			if propertiesdrugs[i].recolteheroine_menu then
				recolteHeroineMenu = json.decode(propertiesdrugs[i].recolteheroine_menu)
			end

			if propertiesdrugs[i].traitementheroine_menu then
				traitementHeroineMenu = json.decode(propertiesdrugs[i].traitementheroine_menu)
			end

			if propertiesdrugs[i].venteheroine_menu then
				venteHeroineMenu = json.decode(propertiesdrugs[i].venteheroine_menu)
			end

			if propertiesdrugs[i].recolteghb_menu then
				recolteGHBMenu = json.decode(propertiesdrugs[i].recolteghb_menu)
			end

			if propertiesdrugs[i].traitementghb_menu then
				traitementGHBMenu = json.decode(propertiesdrugs[i].traitementghb_menu)
			end

			if propertiesdrugs[i].venteghb_menu then
				venteGHBMenu = json.decode(propertiesdrugs[i].venteghb_menu)
			end

			if propertiesdrugs[i].recoltepsychedeliques_menu then
				recoltePsychedeliquesMenu = json.decode(propertiesdrugs[i].recoltepsychedeliques_menu)
			end

			if propertiesdrugs[i].traitementpsychedeliques_menu then
				traitementPsychedeliquesMenu = json.decode(propertiesdrugs[i].traitementpsychedeliques_menu)
			end

			if propertiesdrugs[i].ventepsychedeliques_menu then
				ventePsychedeliquesMenu = json.decode(propertiesdrugs[i].ventepsychedeliques_menu)
			end

			if propertiesdrugs[i].recolteopium_menu then
				recolteOpiumMenu = json.decode(propertiesdrugs[i].recolteopium_menu)
			end

			if propertiesdrugs[i].traitementopium_menu then
				traitementOpiumMenu = json.decode(propertiesdrugs[i].traitementopium_menu)
			end

			if propertiesdrugs[i].venteopium_menu then
				venteOpiumMenu = json.decode(propertiesdrugs[i].venteopium_menu)
			end

			if propertiesdrugs[i].recolteketamine_menu then
				recolteKetamineMenu = json.decode(propertiesdrugs[i].recolteketamine_menu)
			end

			if propertiesdrugs[i].traitementketamine_menu then
				traitementKetamineMenu = json.decode(propertiesdrugs[i].traitementketamine_menu)
			end

			if propertiesdrugs[i].venteketamine_menu then
				venteKetamineMenu = json.decode(propertiesdrugs[i].venteketamine_menu)
			end

			if propertiesdrugs[i].recoltelsd_menu then
				recolteLSDMenu = json.decode(propertiesdrugs[i].recoltelsd_menu)
			end

			if propertiesdrugs[i].traitementlsd_menu then
				traitementLSDMenu = json.decode(propertiesdrugs[i].traitementlsd_menu)
			end

			if propertiesdrugs[i].ventelsd_menu then
				venteLSDMenu = json.decode(propertiesdrugs[i].ventelsd_menu)
			end

			if propertiesdrugs[i].recoltemorphine_menu then
				recolteMorphineMenu = json.decode(propertiesdrugs[i].recoltemorphine_menu)
			end

			if propertiesdrugs[i].traitementmorphine_menu then
				traitementMorphineMenu = json.decode(propertiesdrugs[i].traitementmorphine_menu)
			end

			if propertiesdrugs[i].ventemorphine_menu then
				venteMorphineMenu = json.decode(propertiesdrugs[i].ventemorphine_menu)
			end

			if propertiesdrugs[i].recoltelean_menu then
				recolteLeanMenu = json.decode(propertiesdrugs[i].recoltelean_menu)
			end

			if propertiesdrugs[i].traitementlean_menu then
				traitementLeanMenu = json.decode(propertiesdrugs[i].traitementlean_menu)
			end

			if propertiesdrugs[i].ventelean_menu then
				venteLeanMenu = json.decode(propertiesdrugs[i].ventelean_menu)
			end

			if propertiesdrugs[i].recolteamphetamines_menu then
				recolteAmphetaminesMenu = json.decode(propertiesdrugs[i].recolteamphetamines_menu)
			end

			if propertiesdrugs[i].traitementamphetamines_menu then
				traitementAmphetaminesMenu = json.decode(propertiesdrugs[i].traitementamphetamines_menu)
			end

			if propertiesdrugs[i].venteamphetamines_menu then
				venteAmphetaminesMenu = json.decode(propertiesdrugs[i].venteamphetamines_menu)
			end

			if propertiesdrugs[i].recoltemarijuana_menu then
				recolteMarijuanaMenu = json.decode(propertiesdrugs[i].recoltemarijuana_menu)
			end

			if propertiesdrugs[i].traitementmarijuana_menu then
				traitementMarijuanaMenu = json.decode(propertiesdrugs[i].traitementmarijuana_menu)
			end

			if propertiesdrugs[i].ventemarijuana_menu then
				venteMarijuanaMenu = json.decode(propertiesdrugs[i].ventemarijuana_menu)
			end

			if propertiesdrugs[i].recoltespeed_menu then
				recolteSpeedMenu = json.decode(propertiesdrugs[i].recoltespeed_menu)
			end

			if propertiesdrugs[i].traitementspeed_menu then
				traitementSpeedMenu = json.decode(propertiesdrugs[i].traitementspeed_menu)
			end

			if propertiesdrugs[i].ventespeed_menu then
				venteSpeedMenu = json.decode(propertiesdrugs[i].ventespeed_menu)
			end

			if propertiesdrugs[i].blanchiment_menu then
				BlanchimentMenu = json.decode(propertiesdrugs[i].blanchiment_menu)
			end
		
			table.insert(Config.PropertiesDrugs, {
				name      = propertiesdrugs[i].name,
				label     = propertiesdrugs[i].label,
				entering  = entering,
				exit      = exit,
				inside    = inside,
				outside   = outside,
				ipls      = json.decode(propertiesdrugs[i].ipls),
				gateway   = propertiesdrugs[i].gateway,
				isSingle  = isSingle,
				isRoom    = isRoom,
				isGateway = isGateway,
				recolteWeedMenu  = recolteWeedMenu,
				traitementWeedMenu  = traitementWeedMenu,
				venteWeedMenu  = venteWeedMenu,
				recolteCokeMenu  = recolteCokeMenu,
				traitementCokeMenu  = traitementCokeMenu,
				venteCokeMenu  = venteCokeMenu,
				recolteMethMenu  = recolteMethMenu,
				traitementMethMenu  = traitementMethMenu,
				venteMethMenu  = venteMethMenu,
				recolteCannabisMenu  = recolteCannabisMenu,
				traitementCannabisMenu  = traitementCannabisMenu,
				venteCannabisMenu  = venteCannabisMenu,
				recolteCrackMenu  = recolteCrackMenu,
				traitementCrackMenu  = traitementCrackMenu,
				venteCrackMenu  = venteCrackMenu,
				recolteEcstasyMenu  = recolteEcstasyMenu,
				traitementEcstasyMenu  = traitementEcstasyMenu,
				venteEcstasyMenu  = venteEcstasyMenu,
				recolteHeroineMenu  = recolteHeroineMenu,
				traitementHeroineMenu  = traitementHeroineMenu,
				venteHeroineMenu  = venteHeroineMenu,
				recolteGHBMenu  = recolteGHBMenu,
				traitementGHBMenu  = traitementGHBMenu,
				venteGHBMenu  = venteGHBMenu,	
				recoltePsychedeliquesMenu  = recoltePsychedeliquesMenu,
				traitementPsychedeliquesMenu  = traitementPsychedeliquesMenu,
				ventePsychedeliquesMenu  = ventePsychedeliquesMenu,	
				recolteOpiumMenu  = recolteOpiumMenu,
				traitementOpiumMenu  = traitementOpiumMenu,
				venteOpiumMenu  = venteOpiumMenu,	
				recolteKetamineMenu  = recolteKetamineMenu,
				traitementKetamineMenu  = traitementKetamineMenu,
				venteKetamineMenu  = venteKetamineMenu,
				recolteLSDMenu  = recolteLSDMenu,
				traitementLSDMenu  = traitementLSDMenu,
				venteLSDMenu  = venteLSDMenu,
				recolteMorphineMenu  = recolteMorphineMenu,
				traitementMorphineMenu  = traitementMorphineMenu,
				venteMorphineMenu  = venteMorphineMenu,
				recolteLeanMenu  = recolteLeanMenu,
				traitementLeanMenu  = traitementLeanMenu,
				venteLeanMenu  = venteLeanMenu,
				recolteAmphetaminesMenu  = recolteAmphetaminesMenu,
				traitementAmphetaminesMenu  = traitementAmphetaminesMenu,
				venteAmphetaminesMenu  = venteAmphetaminesMenu,
				recolteMarijuanaMenu  = recolteMarijuanaMenu,
				traitementMarijuanaMenu  = traitementMarijuanaMenu,
				venteMarijuanaMenu  = venteMarijuanaMenu,
				recolteSpeedMenu  = recolteSpeedMenu,
				traitementSpeedMenu  = traitementSpeedMenu,
				venteSpeedMenu  = venteSpeedMenu,
				BlanchimentMenu  = BlanchimentMenu,
			})
		end

		TriggerClientEvent('polo_propertydrugs:sendPropertiesDrugs', -1, Config.PropertiesDrugs)
	end)
end)

MySQL.ready(function()
	Citizen.Wait(1500)

	MySQL.Async.fetchAll('SELECT * FROM `polo_drugswithouinterior`', {}, function(propertiesdrugs)

		for i=1, #propertiesdrugs, 1 do
			local recolteWeedMenu  = nil
			local traitementWeedMenu  = nil
			local venteWeedMenu  = nil
			local recolteCokeMenu  = nil
			local traitementCokeMenu  = nil
			local venteCokeMenu  = nil
			local recolteMethMenu  = nil
			local traitementMethMenu  = nil
			local venteMethMenu  = nil
			local recolteCannabisMenu  = nil
			local traitementCannabisMenu  = nil
			local venteCannabisMenu  = nil
			local recolteCrackMenu  = nil
			local traitementCrackMenu  = nil
			local venteCrackMenu  = nil
			local recolteEcstasyMenu  = nil
			local traitementEcstasyMenu  = nil
			local venteEcstasyMenu  = nil
			local recolteHeroineMenu  = nil
			local traitementHeroineMenu  = nil
			local venteHeroineMenu  = nil
			local recolteGHBMenu  = nil
			local traitementGHBMenu  = nil
			local venteGHBMenu  = nil
			local recoltePsychedeliquesMenu  = nil
			local traitementPsychedeliquesMenu  = nil
			local ventePsychedeliquesMenu  = nil
			local recolteOpiumMenu  = nil
			local traitementOpiumMenu  = nil
			local venteOpiumMenu  = nil
			local recolteKetamineMenu  = nil
			local traitementKetamineMenu  = nil
			local venteKetamineMenu  = nil
			local recolteLSDMenu  = nil
			local traitementLSDMenu  = nil
			local venteLSDMenu  = nil
			local recolteMorphineMenu  = nil
			local traitementMorphineMenu  = nil
			local venteMorphineMenu  = nil
			local recolteLeanMenu  = nil
			local traitementLeanMenu  = nil
			local venteLeanMenu  = nil
			local recolteAmphetaminesMenu  = nil
			local traitementAmphetaminesMenu  = nil
			local venteAmphetaminesMenu  = nil
			local recolteMarijuanaMenu  = nil
			local traitementMarijuanaMenu  = nil
			local venteMarijuanaMenu  = nil
			local recolteSpeedMenu  = nil
			local traitementSpeedMenu  = nil
			local venteSpeedMenu  = nil
			local BlanchimentMenu  = nil

			if propertiesdrugs[i].recolteweed_menu then
				recolteWeedMenu = json.decode(propertiesdrugs[i].recolteweed_menu)
			end

			if propertiesdrugs[i].traitementweed_menu then
				traitementWeedMenu = json.decode(propertiesdrugs[i].traitementweed_menu)
			end

			if propertiesdrugs[i].venteweed_menu then
				venteWeedMenu = json.decode(propertiesdrugs[i].venteweed_menu)
			end

			if propertiesdrugs[i].recoltecoke_menu then
				recolteCokeMenu = json.decode(propertiesdrugs[i].recoltecoke_menu)
			end

			if propertiesdrugs[i].traitementcoke_menu then
				traitementCokeMenu = json.decode(propertiesdrugs[i].traitementcoke_menu)
			end

			if propertiesdrugs[i].ventecoke_menu then
				venteCokeMenu = json.decode(propertiesdrugs[i].ventecoke_menu)
			end

			if propertiesdrugs[i].recoltemeth_menu then
				recolteMethMenu = json.decode(propertiesdrugs[i].recoltemeth_menu)
			end

			if propertiesdrugs[i].traitementmeth_menu then
				traitementMethMenu = json.decode(propertiesdrugs[i].traitementmeth_menu)
			end

			if propertiesdrugs[i].ventemeth_menu then
				venteMethMenu = json.decode(propertiesdrugs[i].ventemeth_menu)
			end

			if propertiesdrugs[i].recoltecannabis_menu then
				recolteCannabisMenu = json.decode(propertiesdrugs[i].recoltecannabis_menu)
			end

			if propertiesdrugs[i].traitementcannabis_menu then
				traitementCannabisMenu = json.decode(propertiesdrugs[i].traitementcannabis_menu)
			end

			if propertiesdrugs[i].ventecannabis_menu then
				venteCannabisMenu = json.decode(propertiesdrugs[i].ventecannabis_menu)
			end

			if propertiesdrugs[i].recoltecrack_menu then
				recolteCrackMenu = json.decode(propertiesdrugs[i].recoltecrack_menu)
			end

			if propertiesdrugs[i].traitementcrack_menu then
				traitementCrackMenu = json.decode(propertiesdrugs[i].traitementcrack_menu)
			end

			if propertiesdrugs[i].ventecrack_menu then
				venteCrackMenu = json.decode(propertiesdrugs[i].ventecrack_menu)
			end

			if propertiesdrugs[i].recolteecstasy_menu then
				recolteEcstasyMenu = json.decode(propertiesdrugs[i].recolteecstasy_menu)
			end

			if propertiesdrugs[i].traitementecstasy_menu then
				traitementEcstasyMenu = json.decode(propertiesdrugs[i].traitementecstasy_menu)
			end

			if propertiesdrugs[i].venteecstasy_menu then
				venteEcstasyMenu = json.decode(propertiesdrugs[i].venteecstasy_menu)
			end

			if propertiesdrugs[i].recolteheroine_menu then
				recolteHeroineMenu = json.decode(propertiesdrugs[i].recolteheroine_menu)
			end

			if propertiesdrugs[i].traitementheroine_menu then
				traitementHeroineMenu = json.decode(propertiesdrugs[i].traitementheroine_menu)
			end

			if propertiesdrugs[i].venteheroine_menu then
				venteHeroineMenu = json.decode(propertiesdrugs[i].venteheroine_menu)
			end

			if propertiesdrugs[i].recolteghb_menu then
				recolteGHBMenu = json.decode(propertiesdrugs[i].recolteghb_menu)
			end

			if propertiesdrugs[i].traitementghb_menu then
				traitementGHBMenu = json.decode(propertiesdrugs[i].traitementghb_menu)
			end

			if propertiesdrugs[i].venteghb_menu then
				venteGHBMenu = json.decode(propertiesdrugs[i].venteghb_menu)
			end

			if propertiesdrugs[i].recoltepsychedeliques_menu then
				recoltePsychedeliquesMenu = json.decode(propertiesdrugs[i].recoltepsychedeliques_menu)
			end

			if propertiesdrugs[i].traitementpsychedeliques_menu then
				traitementPsychedeliquesMenu = json.decode(propertiesdrugs[i].traitementpsychedeliques_menu)
			end

			if propertiesdrugs[i].ventepsychedeliques_menu then
				ventePsychedeliquesMenu = json.decode(propertiesdrugs[i].ventepsychedeliques_menu)
			end

			if propertiesdrugs[i].recolteopium_menu then
				recolteOpiumMenu = json.decode(propertiesdrugs[i].recolteopium_menu)
			end

			if propertiesdrugs[i].traitementopium_menu then
				traitementOpiumMenu = json.decode(propertiesdrugs[i].traitementopium_menu)
			end

			if propertiesdrugs[i].venteopium_menu then
				venteOpiumMenu = json.decode(propertiesdrugs[i].venteopium_menu)
			end

			if propertiesdrugs[i].recolteketamine_menu then
				recolteKetamineMenu = json.decode(propertiesdrugs[i].recolteketamine_menu)
			end

			if propertiesdrugs[i].traitementketamine_menu then
				traitementKetamineMenu = json.decode(propertiesdrugs[i].traitementketamine_menu)
			end

			if propertiesdrugs[i].venteketamine_menu then
				venteKetamineMenu = json.decode(propertiesdrugs[i].venteketamine_menu)
			end

			if propertiesdrugs[i].recoltelsd_menu then
				recolteLSDMenu = json.decode(propertiesdrugs[i].recoltelsd_menu)
			end

			if propertiesdrugs[i].traitementlsd_menu then
				traitementLSDMenu = json.decode(propertiesdrugs[i].traitementlsd_menu)
			end

			if propertiesdrugs[i].ventelsd_menu then
				venteLSDMenu = json.decode(propertiesdrugs[i].ventelsd_menu)
			end

			if propertiesdrugs[i].recoltemorphine_menu then
				recolteMorphineMenu = json.decode(propertiesdrugs[i].recoltemorphine_menu)
			end

			if propertiesdrugs[i].traitementmorphine_menu then
				traitementMorphineMenu = json.decode(propertiesdrugs[i].traitementmorphine_menu)
			end

			if propertiesdrugs[i].ventemorphine_menu then
				venteMorphineMenu = json.decode(propertiesdrugs[i].ventemorphine_menu)
			end

			if propertiesdrugs[i].recoltelean_menu then
				recolteLeanMenu = json.decode(propertiesdrugs[i].recoltelean_menu)
			end

			if propertiesdrugs[i].traitementlean_menu then
				traitementLeanMenu = json.decode(propertiesdrugs[i].traitementlean_menu)
			end

			if propertiesdrugs[i].ventelean_menu then
				venteLeanMenu = json.decode(propertiesdrugs[i].ventelean_menu)
			end

			if propertiesdrugs[i].recolteamphetamines_menu then
				recolteAmphetaminesMenu = json.decode(propertiesdrugs[i].recolteamphetamines_menu)
			end

			if propertiesdrugs[i].traitementamphetamines_menu then
				traitementAmphetaminesMenu = json.decode(propertiesdrugs[i].traitementamphetamines_menu)
			end

			if propertiesdrugs[i].venteamphetamines_menu then
				venteAmphetaminesMenu = json.decode(propertiesdrugs[i].venteamphetamines_menu)
			end

			if propertiesdrugs[i].recoltemarijuana_menu then
				recolteMarijuanaMenu = json.decode(propertiesdrugs[i].recoltemarijuana_menu)
			end

			if propertiesdrugs[i].traitementmarijuana_menu then
				traitementMarijuanaMenu = json.decode(propertiesdrugs[i].traitementmarijuana_menu)
			end

			if propertiesdrugs[i].ventemarijuana_menu then
				venteMarijuanaMenu = json.decode(propertiesdrugs[i].ventemarijuana_menu)
			end

			if propertiesdrugs[i].recoltespeed_menu then
				recolteSpeedMenu = json.decode(propertiesdrugs[i].recoltespeed_menu)
			end

			if propertiesdrugs[i].traitementspeed_menu then
				traitementSpeedMenu = json.decode(propertiesdrugs[i].traitementspeed_menu)
			end

			if propertiesdrugs[i].ventespeed_menu then
				venteSpeedMenu = json.decode(propertiesdrugs[i].ventespeed_menu)
			end

			if propertiesdrugs[i].blanchiment_menu then
				BlanchimentMenu = json.decode(propertiesdrugs[i].blanchiment_menu)
			end
		
			table.insert(Config.PropertiesDrugs, {
				name      = propertiesdrugs[i].name,
				label     = propertiesdrugs[i].label,
				recolteWeedMenu  = recolteWeedMenu,
				traitementWeedMenu  = traitementWeedMenu,
				venteWeedMenu  = venteWeedMenu,
				recolteCokeMenu  = recolteCokeMenu,
				traitementCokeMenu  = traitementCokeMenu,
				venteCokeMenu  = venteCokeMenu,
				recolteMethMenu  = recolteMethMenu,
				traitementMethMenu  = traitementMethMenu,
				venteMethMenu  = venteMethMenu,
				recolteCannabisMenu  = recolteCannabisMenu,
				traitementCannabisMenu  = traitementCannabisMenu,
				venteCannabisMenu  = venteCannabisMenu,
				recolteCrackMenu  = recolteCrackMenu,
				traitementCrackMenu  = traitementCrackMenu,
				venteCrackMenu  = venteCrackMenu,
				recolteEcstasyMenu  = recolteEcstasyMenu,
				traitementEcstasyMenu  = traitementEcstasyMenu,
				venteEcstasyMenu  = venteEcstasyMenu,
				recolteHeroineMenu  = recolteHeroineMenu,
				traitementHeroineMenu  = traitementHeroineMenu,
				venteHeroineMenu  = venteHeroineMenu,
				recolteGHBMenu  = recolteGHBMenu,
				traitementGHBMenu  = traitementGHBMenu,
				venteGHBMenu  = venteGHBMenu,	
				recoltePsychedeliquesMenu  = recoltePsychedeliquesMenu,
				traitementPsychedeliquesMenu  = traitementPsychedeliquesMenu,
				ventePsychedeliquesMenu  = ventePsychedeliquesMenu,
				recolteOpiumMenu  = recolteOpiumMenu,
				traitementOpiumMenu  = traitementOpiumMenu,
				venteOpiumMenu  = venteOpiumMenu,
				recolteKetamineMenu  = recolteKetamineMenu,
				traitementKetamineMenu  = traitementKetamineMenu,
				venteKetamineMenu  = venteKetamineMenu,
				recolteLSDMenu  = recolteLSDMenu,
				traitementLSDMenu  = traitementLSDMenu,
				venteLSDMenu  = venteLSDMenu,
				recolteMorphineMenu  = recolteMorphineMenu,
				traitementMorphineMenu  = traitementMorphineMenu,
				venteMorphineMenu  = venteMorphineMenu,
				recolteLeanMenu  = recolteLeanMenu,
				traitementLeanMenu  = traitementLeanMenu,
				venteLeanMenu  = venteLeanMenu,
				recolteAmphetaminesMenu  = recolteAmphetaminesMenu,
				traitementAmphetaminesMenu  = traitementAmphetaminesMenu,
				venteAmphetaminesMenu  = venteAmphetaminesMenu,
				recolteMarijuanaMenu  = recolteMarijuanaMenu,
				traitementMarijuanaMenu  = traitementMarijuanaMenu,
				venteMarijuanaMenu  = venteMarijuanaMenu,
				recolteSpeedMenu  = recolteSpeedMenu,
				traitementSpeedMenu  = traitementSpeedMenu,
				venteSpeedMenu  = venteSpeedMenu,
				BlanchimentMenu  = BlanchimentMenu,
			})
		end

		TriggerClientEvent('polo_propertydrugs:sendPropertiesDrugs', -1, Config.PropertiesDrugs)
	end)
end)

ESX.RegisterServerCallback('polo_propertydrugs:getPropertiesDrugs', function(source, cb)
	cb(Config.PropertiesDrugs)
end)

RegisterNetEvent('polo_propertydrugs:rentPropertyDrugs')
AddEventHandler('polo_propertydrugs:rentPropertyDrugs', function(propertydrugsName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local propertydrugs = GetPropertyDrugs(propertydrugsName)
	local rent     = ESX.Math.Round(propertydrugs.price / Config.RentModifier)

	SetPropertyDrugsOwned(propertydrugsName, rent, true, xPlayer.identifier)
end)

RegisterNetEvent('polo_propertydrugs:buyPropertyDrugs')
AddEventHandler('polo_propertydrugs:buyPropertyDrugs', function(propertydrugsName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local propertydrugs = GetPropertyDrugs(propertydrugsName)

	if propertydrugs.price <= xPlayer.getMoney() then
		xPlayer.removeMoney(propertydrugs.price)
		SetPropertyDrugsOwned(propertydrugsName, propertydrugs.price, false, xPlayer.identifier)
	else
		xPlayer.showNotification(_U('not_enough'))
	end
end)

RegisterNetEvent('polo_propertydrugs:removeOwnedPropertyDrugs')
AddEventHandler('polo_propertydrugs:removeOwnedPropertyDrugs', function(propertydrugsName)
	local xPlayer = ESX.GetPlayerFromId(source)
	RemoveOwnedPropertyDrugs(propertydrugsName, xPlayer.identifier)
end)

AddEventHandler('polo_propertydrugs:removeOwnedPropertyDrugsIdentifier', function(propertydrugsName, identifier)
	RemoveOwnedPropertyDrugs(propertydrugsName, identifier)
end)

RegisterNetEvent('polo_propertydrugs:saveLastPropertyDrugs')
AddEventHandler('polo_propertydrugs:saveLastPropertyDrugs', function(propertydrugs)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property_drugs = @last_property_drugs WHERE identifier = @identifier', {
		['@last_property_drugs'] = propertydrugs,
		['@identifier']    = xPlayer.identifier
	})
end)

RegisterNetEvent('polo_propertydrugs:deleteLastPropertyDrugs')
AddEventHandler('polo_propertydrugs:deleteLastPropertyDrugs', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property_drugs = NULL WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
end)

ESX.RegisterServerCallback('polo_propertydrugs:getLastPropertyDrugs', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT last_property_drugs FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		cb(users[1].last_property_drugs)
	end)
end)

RegisterServerEvent('weed:recolte')
AddEventHandler('weed:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('weed', 5)
    end
end)

RegisterServerEvent('weed:traitement')
AddEventHandler('weed:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('weed').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('weed_pooch', 1)
        xPlayer.removeInventoryItem('weed', 5)
	end
end)

RegisterServerEvent('weed:vente')
AddEventHandler('weed:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('weed_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceWeedSell)
        xPlayer.removeInventoryItem('weed_pooch', 5)
	end
end
end)

RegisterServerEvent('coke:recolte')
AddEventHandler('coke:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('coke', 5)
    end
end)

RegisterServerEvent('coke:traitement')
AddEventHandler('coke:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('coke').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('coke_pooch', 1)
        xPlayer.removeInventoryItem('coke', 5)
	end
end)

RegisterServerEvent('coke:vente')
AddEventHandler('coke:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('coke_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceCokeSell)
        xPlayer.removeInventoryItem('coke_pooch', 5)
	end
end
end)

RegisterServerEvent('meth:recolte')
AddEventHandler('meth:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('meth', 5)
    end
end)

RegisterServerEvent('meth:traitement')
AddEventHandler('meth:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('meth').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('meth_pooch', 1)
        xPlayer.removeInventoryItem('meth', 5)
	end
end)

RegisterServerEvent('meth:vente')
AddEventHandler('meth:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('meth_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceMethSell)
        xPlayer.removeInventoryItem('meth_pooch', 5)
	end
end
end)

RegisterServerEvent('cannabis:recolte')
AddEventHandler('cannabis:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('cannabis', 5)
    end
end)

RegisterServerEvent('cannabis:traitement')
AddEventHandler('cannabis:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('cannabis').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('cannabis_pooch', 1)
        xPlayer.removeInventoryItem('cannabis', 5)
	end
end)

RegisterServerEvent('cannabis:vente')
AddEventHandler('cannabis:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('cannabis_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceCannabisSell)
        xPlayer.removeInventoryItem('cannabis_pooch', 5)
	end
end
end)

RegisterServerEvent('crack:recolte')
AddEventHandler('crack:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('crack', 5)
    end
end)

RegisterServerEvent('crack:traitement')
AddEventHandler('crack:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('crack').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('crack_pooch', 1)
        xPlayer.removeInventoryItem('crack', 5)
	end
end)

RegisterServerEvent('crack:vente')
AddEventHandler('crack:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('crack_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceCrackSell)
        xPlayer.removeInventoryItem('crack_pooch', 5)
	end
end
end)

RegisterServerEvent('ecstasy:recolte')
AddEventHandler('ecstasy:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('ecstasy', 5)
    end
end)

RegisterServerEvent('ecstasy:traitement')
AddEventHandler('ecstasy:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('ecstasy').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('ecstasy_pooch', 1)
        xPlayer.removeInventoryItem('ecstasy', 5)
	end
end)

RegisterServerEvent('ecstasy:vente')
AddEventHandler('ecstasy:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('ecstasy_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceEcstasySell)
        xPlayer.removeInventoryItem('ecstasy_pooch', 5)
	end
end
end)

RegisterServerEvent('heroine:recolte')
AddEventHandler('heroine:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('heroine', 5)
    end
end)

RegisterServerEvent('heroine:traitement')
AddEventHandler('heroine:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('heroine').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('heroine_pooch', 1)
        xPlayer.removeInventoryItem('heroine', 5)
	end
end)

RegisterServerEvent('heroine:vente')
AddEventHandler('heroine:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('heroine_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceHeroineSell)
        xPlayer.removeInventoryItem('heroine_pooch', 5)
	end
end
end)

RegisterServerEvent('ghb:recolte')
AddEventHandler('ghb:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('ghb', 5)
    end
end)

RegisterServerEvent('ghb:traitement')
AddEventHandler('ghb:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('ghb').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('ghb_pooch', 1)
        xPlayer.removeInventoryItem('ghb', 5)
	end
end)

RegisterServerEvent('ghb:vente')
AddEventHandler('ghb:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('ghb_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceGHBSell)
        xPlayer.removeInventoryItem('ghb_pooch', 5)
	end
end
end)

RegisterServerEvent('psychedeliques:recolte')
AddEventHandler('psychedeliques:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('psychedeliques', 5)
    end
end)

RegisterServerEvent('psychedeliques:traitement')
AddEventHandler('psychedeliques:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('psychedeliques').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('psychedeliques_pooch', 1)
        xPlayer.removeInventoryItem('psychedeliques', 5)
	end
end)

RegisterServerEvent('psychedeliques:vente')
AddEventHandler('psychedeliques:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('psychedeliques_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PricePsychedeliquesSell)
        xPlayer.removeInventoryItem('psychedeliques_pooch', 5)
	end
end
end)

RegisterServerEvent('opium:recolte')
AddEventHandler('opium:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('opium', 5)
    end
end)

RegisterServerEvent('opium:traitement')
AddEventHandler('opium:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('opium').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('opium_pooch', 1)
        xPlayer.removeInventoryItem('opium', 5)
	end
end)

RegisterServerEvent('opium:vente')
AddEventHandler('opium:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('opium_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceOpiumSell)
        xPlayer.removeInventoryItem('opium_pooch', 5)
	end
end
end)

RegisterServerEvent('ketamine:recolte')
AddEventHandler('ketamine:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('ketamine', 5)
    end
end)

RegisterServerEvent('ketamine:traitement')
AddEventHandler('ketamine:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('ketamine').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('ketamine_pooch', 1)
        xPlayer.removeInventoryItem('ketamine', 5)
	end
end)

RegisterServerEvent('ketamine:vente')
AddEventHandler('ketamine:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('ketamine_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceKetamineSell)
        xPlayer.removeInventoryItem('ketamine_pooch', 5)
	end
end
end)

RegisterServerEvent('lsd:recolte')
AddEventHandler('lsd:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('lsd', 5)
    end
end)

RegisterServerEvent('lsd:traitement')
AddEventHandler('lsd:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('lsd').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('lsd_pooch', 1)
        xPlayer.removeInventoryItem('lsd', 5)
	end
end)

RegisterServerEvent('lsd:vente')
AddEventHandler('lsd:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('lsd_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceLSDSell)
        xPlayer.removeInventoryItem('lsd_pooch', 5)
	end
end
end)

RegisterServerEvent('morphine:recolte')
AddEventHandler('morphine:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('morphine', 5)
    end
end)

RegisterServerEvent('morphine:traitement')
AddEventHandler('morphine:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('morphine').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('morphine_pooch', 1)
        xPlayer.removeInventoryItem('morphine', 5)
	end
end)

RegisterServerEvent('morphine:vente')
AddEventHandler('morphine:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('morphine_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceMorphineSell)
        xPlayer.removeInventoryItem('morphine_pooch', 5)
	end
end
end)

RegisterServerEvent('lean:recolte')
AddEventHandler('lean:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('lean', 5)
    end
end)

RegisterServerEvent('lean:traitement')
AddEventHandler('lean:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('lean').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('lean_pooch', 1)
        xPlayer.removeInventoryItem('lean', 5)
	end
end)

RegisterServerEvent('lean:vente')
AddEventHandler('lean:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('lean_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceLeanSell)
        xPlayer.removeInventoryItem('lean_pooch', 5)
	end
end
end)

RegisterServerEvent('amphetamines:recolte')
AddEventHandler('amphetamines:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('amphetamines', 5)
    end
end)

RegisterServerEvent('amphetamines:traitement')
AddEventHandler('amphetamines:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('amphetamines').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('amphetamines_pooch', 1)
        xPlayer.removeInventoryItem('amphetamines', 5)
	end
end)

RegisterServerEvent('amphetamines:vente')
AddEventHandler('amphetamines:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('amphetamines_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceAmphetaminesSell)
        xPlayer.removeInventoryItem('amphetamines_pooch', 5)
	end
end
end)

RegisterServerEvent('marijuana:recolte')
AddEventHandler('marijuana:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('marijuana', 5)
    end
end)

RegisterServerEvent('marijuana:traitement')
AddEventHandler('marijuana:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('marijuana').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('marijuana_pooch', 1)
        xPlayer.removeInventoryItem('marijuana', 5)
	end
end)

RegisterServerEvent('marijuana:vente')
AddEventHandler('marijuana:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('marijuana_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceMarijuanaSell)
        xPlayer.removeInventoryItem('marijuana_pooch', 5)
	end
end
end)

RegisterServerEvent('speed:recolte')
AddEventHandler('speed:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('speed', 5)
    end
end)

RegisterServerEvent('speed:traitement')
AddEventHandler('speed:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('speed').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('speed_pooch', 1)
        xPlayer.removeInventoryItem('speed', 5)
	end
end)

RegisterServerEvent('speed:vente')
AddEventHandler('speed:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('speed_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceSpeedSell)
        xPlayer.removeInventoryItem('speed_pooch', 5)
	end
end
end)

RegisterServerEvent('thc:recolte')
AddEventHandler('thc:recolte', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('shovel').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('thc', 5)
    end
end)

RegisterServerEvent('thc:traitement')
AddEventHandler('thc:traitement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('thc').count

    if xItem1 > 0 then
        TriggerClientEvent('drug1:animation' , source)
        Citizen.Wait(10000)
        xPlayer.addInventoryItem('thc_pooch', 1)
        xPlayer.removeInventoryItem('thc', 5)
	end
end)

RegisterServerEvent('thc:vente')
AddEventHandler('thc:vente', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem1 = xPlayer.getInventoryItem('thc_pooch').count

if xPlayer ~= nil then 
    if xItem1 >= 5 then
    	TriggerClientEvent('drug1:animation' , source)
    	Citizen.Wait(10000)
        xPlayer.addMoney(Config.PriceTHCSell)
        xPlayer.removeInventoryItem('thc_pooch', 5)
	end
end
end)

RegisterServerEvent('polo_propertydrugs:washMoney')
AddEventHandler('polo_propertydrugs:washMoney', function(amount)
    local xPlayer 		= ESX.GetPlayerFromId(source)
    local account 		= xPlayer.getAccount('dirtycash')
    local _percent		= Config.Percentage

    if amount > 0 and account.money >= amount then

        local bonus = math.random(Config.Bonus.min, Config.Bonus.max)
        local washedMoney = math.floor(amount / 100 * (_percent + bonus))

        xPlayer.removeAccountMoney('dirtycash', amount)
        xPlayer.addAccountMoney('cash', washedMoney)

        TriggerClientEvent("polo_propertydrugs:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('cash') .. washedMoney .. _U('cash1'))

    else
        TriggerClientEvent("polo_propertydrugs:notify", source, "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('invalid_amount'))
    end

end)