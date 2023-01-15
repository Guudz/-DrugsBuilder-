ESX = nil

local PlayerData = {}

--########################################################### CUSTOMISER VOTRE F6 SELON VOS DROGUES ###################################################################

local ShowWeed = true
local ShowCoke = true
local ShowMeth = true
local ShowCannabis = true
local ShowCrack = true
local ShowEcstasy = true
local ShowHeroine = true
local ShowGHB = true
local ShowPsychedeliques = true
local ShowOpium = true
local ShowKetamine = true
local ShowLSD = true
local ShowMorphine = true
local ShowLean = true
local ShowAmphetamines = true
local ShowMarijuana = true
local ShowSpeed = true
local ShowThc = true

local ShowWashMoney = true

--##################################################################### FIN DE CUSTOMISATION ##########################################################################

Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait()

	end



	while ESX.GetPlayerData().job == nil do

		Citizen.Wait(100)

	end



	ESX.PlayerData = ESX.GetPlayerData()

end)



RegisterNetEvent('esx:playerLoaded')

AddEventHandler('esx:playerLoaded', function(xPlayer)

	ESX.PlayerData = xPlayer

end)



RegisterNetEvent('esx:setJob')

AddEventHandler('esx:setJob', function(job)

    ESX.PlayerData.job = job

end)



local name = ''

local exit = ''

local label = ''

local inside = ''

local outside = ''

local ipl = ''

local isRoom = ''

local recolte = ''

local price = ''

local entering = ''

local entrer = ''

local isSingle = ''

local garage = ''

local price = 0 

local Menu = { 



    action = {

        'Weed',

        'Coke',

        'Meth',

        'Money Wash',

        'Bunker',

        'Hangar',

        'Entrepot (grand)',

        'Entrepot (moyen)',

        'Entrepot (petit)'

    },  



    list = 1

}


local MenuWeed = { 

    actionweed = {

        'Récolte de Weed',

        'Traitement de Weed',

        'Vente de Weed'

    },

    list = 1

}

local MenuCoke = { 

    actioncoke = {

        'Récolte de Coke',

        'Traitement de Coke',

        'Vente de Coke'

    },

    list = 1

}

local MenuMeth = { 

    actionmeth = {

        'Récolte de Meth',

        'Traitement de Meth',

        'Vente de Meth'

    },

    list = 1

}

local MenuCannabis = { 

    actioncannabis = {

        'Récolte de Cannabis',

        'Traitement de Cannabis',

        'Vente de Cannabis'

    },

    list = 1

}

local MenuCrack = { 

    actioncrack = {

        'Récolte de Crack',

        'Traitement de Crack',

        'Vente de Crack'

    },

    list = 1

}

local MenuEcstasy = {

    actionecstasy = {

        'Récolte d\' Ecstasy',

        'Traitement d\' Ecstasy',

        'Vente d\' Ecstasy'

    },

    list = 1

}

local MenuHeroine = {

    actionheroine = {

        'Récolte d\' Heroine',

        'Traitement d\' Heroine',

        'Vente d\' Heroine'

    },

    list = 1

}

local MenuGHB = {

    actionghb = {

        'Récolte de GHB',

        'Traitement de GHB',

        'Vente de GHB'

    },

    list = 1

}

local MenuPsychedeliques = {

    actionpsychedeliques = {

        'Récolte de Psychedeliques',

        'Traitement de Psychedeliques',

        'Vente de Psychedeliques'

    },

    list = 1

}

local MenuOpium = {

    actionopium = {

        'Récolte d\' Opium',

        'Traitement d\' Opium',

        'Vente d\' Opium'

    },

    list = 1

}

local MenuKetamine = {

    actionketamine = {

        'Récolte de Ketamine',

        'Traitement de Ketamine',

        'Vente de Ketamine'

    },

    list = 1

}

local MenuLSD = {

    actionlsd = {

        'Récolte de la LSD',

        'Traitement de la LSD',

        'Vente de la LSD'

    },

    list = 1

}

local MenuMorphine = {

    actionmorphine = {

        'Récolte de la Morphine',

        'Traitement de Morphine',

        'Vente de Morphine'

    },

    list = 1

}

local MenuLean = {

    actionlean = {

        'Récolte de la Lean',

        'Traitement de Lean',

        'Vente de Lean'

    },

    list = 1

}

local MenuAmphetamines = {

    actionamphetamines = {

        'Récolte de l\' Amphtamines',

        'Traitement d\' Amphtamines',

        'Vente d\' Amphtamines'

    },

    list = 1

}

local MenuMarijuana = {

    actionmarijuana = {

        'Récolte de la Marijuana',

        'Traitement de Marijuana',

        'Vente de Marijuana'

    },

    list = 1

}

local MenuSpeed = {

    actionspeed = {

        'Récolte de Speed',

        'Traitement de Speed',

        'Vente de Speed'

    },

    list = 1

}

local MenuThc = {

    actionthc = {

        'Récolte de THC',

        'Traitement de THC',

        'Vente de THC'

    },

    list = 1

}

local debug = false -- debug mode

local zones = { 

['AIRP'] = "Los Santos International Airport",

['ALAMO'] = "Alamo Sea", 

['ALTA'] = "Alta", 

['ARMYB'] = "Fort Zancudo", 

['BANHAMC'] = "Banham Canyon Dr", 

['BANNING'] = "Banning", 

['BEACH'] = "Vespucci Beach", 

['BHAMCA'] = "Banham Canyon", 

['BRADP'] = "Braddock Pass", 

['BRADT'] = "Braddock Tunnel", 

['BURTON'] = "Burton", 

['CALAFB'] = "Calafia Bridge", 

['CANNY'] = "Raton Canyon", 

['CCREAK'] = "Cassidy Creek", 

['CHAMH'] = "Chamberlain Hills", 

['CHIL'] = "Vinewood Hills", 

['CHU'] = "Chumash", 

['CMSW'] = "Chiliad Mountain State Wilderness", 

['CYPRE'] = "Cypress Flats", 

['DAVIS'] = "Davis", 

['DELBE'] = "Del Perro Beach", 

['DELPE'] = "Del Perro", 

['DELSOL'] = "La Puerta", 

['DESRT'] = "Grand Senora Desert", 

['DOWNT'] = "Downtown", 

['DTVINE'] = "Downtown Vinewood", 

['EAST_V'] = "East Vinewood", 

['EBURO'] = "El Burro Heights", 

['ELGORL'] = "El Gordo Lighthouse", 

['ELYSIAN'] = "Elysian Island", 

['GALFISH'] = "Galilee", 

['GOLF'] = "GWC and Golfing Society", 

['GRAPES'] = "Grapeseed", 

['GREATC'] = "Great Chaparral", 

['HARMO'] = "Harmony", 

['HAWICK'] = "Hawick", 

['HORS'] = "Vinewood Racetrack", 

['HUMLAB'] = "Humane Labs and Research", 

['JAIL'] = "Bolingbroke Penitentiary", 

['KOREAT'] = "Little Seoul", 

['LACT'] = "Land Act Reservoir", 

['LAGO'] = "Lago Zancudo", 

['LDAM'] = "Land Act Dam", 

['LEGSQU'] = "Legion Square", 

['LMESA'] = "La Mesa", 

['LOSPUER'] = "La Puerta", 

['MIRR'] = "Mirror Park", 

['MORN'] = "Morningwood", 

['MOVIE'] = "Richards Majestic", 

['MTCHIL'] = "Mount Chiliad", 

['MTGORDO'] = "Mount Gordo", 

['MTJOSE'] = "Mount Josiah", 

['MURRI'] = "Murrieta Heights", 

['NCHU'] = "North Chumash", 

['NOOSE'] = "N.O.O.S.E", 

['OCEANA'] = "Pacific Ocean", 

['PALCOV'] = "Paleto Cove", 

['PALETO'] = "Paleto Bay", 

['PALFOR'] = "Paleto Forest", 

['PALHIGH'] = "Palomino Highlands", 

['PALMPOW'] = "Palmer-Taylor Power Station", 

['PBLUFF'] = "Pacific Bluffs", 

['PBOX'] = "Pillbox Hill", 

['PROCOB'] = "Procopio Beach", 

['RANCHO'] = "Rancho", 

['RGLEN'] = "Richman Glen", 

['RICHM'] = "Richman", 

['ROCKF'] = "Rockford Hills", 

['RTRAK'] = "Redwood Lights Track", 

['SANAND'] = "San Andreas", 

['SANCHIA'] = "San Chianski Mountain Range", 

['SANDY'] = "Sandy Shores", 

['SKID'] = "Mission Row", 

['SLAB'] = "Stab City", 

['STAD'] = "Maze Bank Arena", 

['STRAW'] = "Strawberry", 

['TATAMO'] = "Tataviam Mountains", 

['TERMINA'] = "Terminal", 

['TEXTI'] = "Textile City", 

['TONGVAH'] = "Tongva Hills", 

['TONGVAV'] = "Tongva Valley", 

['VCANA'] = "Vespucci Canals", 

['VESP'] = "Vespucci", 

['VINE'] = "Vinewood",

['WINDF'] = "Ron Alternates Wind Farm", 

['WVINE'] = "West Vinewood",

['ZANCUDO'] = "Zancudo River",

['ZP_ORT'] = "Port of South Los Santos", 

['ZQ_UAR'] = "Davis Quartz" 

}





local function PoloDrugs()

    RMenu.Add("Drugs", "create", RageUI.CreateMenu("Propriété"," "))
    RMenu:Get('Drugs', 'create').Closed = function()

        Drugs = false

    end  

    if not Drugs then 

        Drugs = true

        RageUI.Visible(RMenu:Get('Drugs', 'create'), true)



        Citizen.CreateThread(function()

            while Drugs do
 

                RageUI.IsVisible(RMenu:Get("Drugs",'create'),true,true,true,function()

                    RageUI.Separator("↓ ~b~ Gestions de création ~s~↓")



                    local pos = GetEntityCoords(PlayerPedId())

                    local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())

                    local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]



                        RageUI.ButtonWithStyle("Placer l'entrée du Labo ~g~[ Pas Obligatoire]", nil, {RightLabel = ""},true, function(Hovered, Active, Selected)

                            if (Selected) then

                                local PlayerCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}                          

                                local Out = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z+2, 4)}

                                

                                entering = json.encode(PlayerCoord)

                                outside  = json.encode(Out)

                

                                PedPosition = pos

                                DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)

                                ESX.ShowNotification('position du point : ~b~'..PlayerCoord.x..' , '..PlayerCoord.y..' , '..PlayerCoord.z.. '~w~, Adresse : ~b~'..current_zone.. '')

                                ESX.ShowNotification('position du point : ~b~'..PlayerCoord.x..' , '..PlayerCoord.y..' , '..PlayerCoord.z..'')

                            end

                        end)

                    if ShowWashMoney == true then

                        RageUI.ButtonWithStyle("Blanchiment ~g~[ Pas Obligatoire]", nil, {RightLabel = ""},true, function(Hovered, Active, Selected)

                            if (Selected) then

                                local BlanchimentCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                blanchiment = json.encode(BlanchimentCoord)

                                ESX.ShowNotification('position du point :~b~'..BlanchimentCoord.x..' , '..BlanchimentCoord.y..' , '..BlanchimentCoord.z.. '')

                                DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)

                            end

                        end)
                    end

                        if ShowWeed == true then

                        RageUI.List('Points :', MenuWeed.actionweed, MenuWeed.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                	local RecolteWeedCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                	recolteweed = json.encode(RecolteWeedCoord)

                                	ESX.ShowNotification('position du point :~b~'..RecolteWeedCoord.x..' , '..RecolteWeedCoord.y..' , '..RecolteWeedCoord.z.. '')

                                	DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
	

                                elseif Index == 2 then

                                	local TraitementWeedCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                	traitementweed = json.encode(TraitementWeedCoord)

                                	ESX.ShowNotification('position du point :~b~'..TraitementWeedCoord.x..' , '..TraitementWeedCoord.y..' , '..TraitementWeedCoord.z.. '')

                                	DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


		                          

                                elseif Index == 3 then

                                	local VenteWeedCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                	venteweed = json.encode(VenteWeedCoord)

                                	ESX.ShowNotification('position du point :~b~'..VenteWeedCoord.x..' , '..VenteWeedCoord.y..' , '..VenteWeedCoord.z.. '')

                                	DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuWeed.list = Index;

                        end)
                    end

                    if ShowCoke == true then

                        RageUI.List('Points :', MenuCoke.actioncoke, MenuCoke.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteCokeCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recoltecoke = json.encode(RecolteCokeCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteCokeCoord.x..' , '..RecolteCokeCoord.y..' , '..RecolteCokeCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementCokeCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementcoke = json.encode(TraitementCokeCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementCokeCoord.x..' , '..TraitementCokeCoord.y..' , '..TraitementCokeCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteCokeCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    ventecoke = json.encode(VenteCokeCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteCokeCoord.x..' , '..VenteCokeCoord.y..' , '..VenteCokeCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuCoke.list = Index;

                        end)
                    end

                    if ShowMeth == true then

                        RageUI.List('Points :', MenuMeth.actionmeth, MenuMeth.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteMethCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recoltemeth = json.encode(RecolteMethCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteMethCoord.x..' , '..RecolteMethCoord.y..' , '..RecolteMethCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementMethCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementmeth = json.encode(TraitementMethCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementMethCoord.x..' , '..TraitementMethCoord.y..' , '..TraitementMethCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteMethCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    ventemeth = json.encode(VenteMethCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteMethCoord.x..' , '..VenteMethCoord.y..' , '..VenteMethCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuMeth.list = Index;

                        end)
                    end

                    if ShowCannabis == true then

                        RageUI.List('Points :', MenuCannabis.actioncannabis, MenuCannabis.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteCannabisCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recoltecannabis = json.encode(RecolteCannabisCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteCannabisCoord.x..' , '..RecolteCannabisCoord.y..' , '..RecolteCannabisCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementCannabisCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementcannabis = json.encode(TraitementCannabisCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementCannabisCoord.x..' , '..TraitementCannabisCoord.y..' , '..TraitementCannabisCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteCannabisCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    ventecannabis = json.encode(VenteCannabisCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteCannabisCoord.x..' , '..VenteCannabisCoord.y..' , '..VenteCannabisCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuCannabis.list = Index;

                        end)
                    end

                    if ShowCrack == true then

                        RageUI.List('Points :', MenuCrack.actioncrack, MenuCrack.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteCrackCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recoltecrack = json.encode(RecolteCrackCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteCrackCoord.x..' , '..RecolteCrackCoord.y..' , '..RecolteCrackCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementCrackCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementcrack = json.encode(TraitementCrackCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementCrackCoord.x..' , '..TraitementCrackCoord.y..' , '..TraitementCrackCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteCrackCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    ventecrack = json.encode(VenteCrackCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteCrackCoord.x..' , '..VenteCrackCoord.y..' , '..VenteCrackCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuCrack.list = Index;

                        end)
                    end

                    if ShowEcstasy == true then

                        RageUI.List('Points :', MenuEcstasy.actionecstasy, MenuEcstasy.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteEcstasyCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recolteecstasy = json.encode(RecolteEcstasyCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteEcstasyCoord.x..' , '..RecolteEcstasyCoord.y..' , '..RecolteEcstasyCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementEcstasyCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementecstasy = json.encode(TraitementEcstasyCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementEcstasyCoord.x..' , '..TraitementEcstasyCoord.y..' , '..TraitementEcstasyCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteEcstasyCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    venteecstasy = json.encode(VenteEcstasyCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteEcstasyCoord.x..' , '..VenteEcstasyCoord.y..' , '..VenteEcstasyCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuEcstasy.list = Index;

                        end)
                    end

                    if ShowHeroine == true then

                        RageUI.List('Points :', MenuHeroine.actionheroine, MenuHeroine.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteHeroineCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recolteheroine = json.encode(RecolteHeroineCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteHeroineCoord.x..' , '..RecolteHeroineCoord.y..' , '..RecolteHeroineCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementHeroineCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementheroine = json.encode(TraitementHeroineCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementHeroineCoord.x..' , '..TraitementHeroineCoord.y..' , '..TraitementHeroineCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteHeroineCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    venteheroine = json.encode(VenteHeroineCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteHeroineCoord.x..' , '..VenteHeroineCoord.y..' , '..VenteHeroineCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuHeroine.list = Index;

                        end)
                    end

                    if ShowGHB == true then

                        RageUI.List('Points :', MenuGHB.actionghb, MenuGHB.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteGHBCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recolteghb = json.encode(RecolteGHBCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteGHBCoord.x..' , '..RecolteGHBCoord.y..' , '..RecolteGHBCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementGHBCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementghb = json.encode(TraitementGHBCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementGHBCoord.x..' , '..TraitementGHBCoord.y..' , '..TraitementGHBCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteGHBCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    venteghb = json.encode(VenteGHBCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteGHBCoord.x..' , '..VenteGHBCoord.y..' , '..VenteGHBCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuGHB.list = Index;

                        end)
                    end

                    if ShowPsychedeliques == true then

                        RageUI.List('Points :', MenuPsychedeliques.actionpsychedeliques, MenuPsychedeliques.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecoltePsychedeliquesCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recoltepsychedeliques = json.encode(RecoltePsychedeliquesCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecoltePsychedeliquesCoord.x..' , '..RecoltePsychedeliquesCoord.y..' , '..RecoltePsychedeliquesCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementPsychedeliquesCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementpsychedeliques = json.encode(TraitementPsychedeliquesCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementPsychedeliquesCoord.x..' , '..TraitementPsychedeliquesCoord.y..' , '..TraitementPsychedeliquesCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VentePsychedeliquesCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    ventepsychedeliques = json.encode(VentePsychedeliquesCoord)

                                    ESX.ShowNotification('position du point :~b~'..VentePsychedeliquesCoord.x..' , '..VentePsychedeliquesCoord.y..' , '..VentePsychedeliquesCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuPsychedeliques.list = Index;

                        end)
                    end

                    if ShowOpium == true then

                        RageUI.List('Points :', MenuOpium.actionopium, MenuOpium.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteOpiumCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recolteopium = json.encode(RecolteOpiumCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteOpiumCoord.x..' , '..RecolteOpiumCoord.y..' , '..RecolteOpiumCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementOpiumCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementopium = json.encode(TraitementOpiumCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementOpiumCoord.x..' , '..TraitementOpiumCoord.y..' , '..TraitementOpiumCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteOpiumCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    venteopium = json.encode(VenteOpiumCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteOpiumCoord.x..' , '..VenteOpiumCoord.y..' , '..VenteOpiumCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuOpium.list = Index;

                        end)
                    end

                    if ShowKetamine == true then

                        RageUI.List('Points :', MenuKetamine.actionketamine, MenuKetamine.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteKetamineCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recolteketamine = json.encode(RecolteKetamineCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteKetamineCoord.x..' , '..RecolteKetamineCoord.y..' , '..RecolteKetamineCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementKetamineCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementketamine = json.encode(TraitementKetamineCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementKetamineCoord.x..' , '..TraitementKetamineCoord.y..' , '..TraitementKetamineCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteKetamineCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    venteketamine = json.encode(VenteKetamineCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteKetamineCoord.x..' , '..VenteKetamineCoord.y..' , '..VenteKetamineCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuKetamine.list = Index;

                        end)
                    end

                    if ShowLSD == true then

                        RageUI.List('Points :', MenuLSD.actionlsd, MenuLSD.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteLSDCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recoltelsd = json.encode(RecolteLSDCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteLSDCoord.x..' , '..RecolteLSDCoord.y..' , '..RecolteLSDCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementLSDCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementlsd = json.encode(TraitementLSDCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementLSDCoord.x..' , '..TraitementLSDCoord.y..' , '..TraitementLSDCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteLSDCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    ventelsd = json.encode(VenteLSDCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteLSDCoord.x..' , '..VenteLSDCoord.y..' , '..VenteLSDCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuLSD.list = Index;

                        end)
                    end

                    if ShowMorphine == true then

                        RageUI.List('Points :', MenuMorphine.actionmorphine, MenuMorphine.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteMorphineCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recoltemorphine = json.encode(RecolteMorphineCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteMorphineCoord.x..' , '..RecolteMorphineCoord.y..' , '..RecolteMorphineCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementMorphineCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementmorphine = json.encode(TraitementMorphineCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementMorphineCoord.x..' , '..TraitementMorphineCoord.y..' , '..TraitementMorphineCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteMorphineCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    ventemorphine = json.encode(VenteMorphineCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteMorphineCoord.x..' , '..VenteMorphineCoord.y..' , '..VenteMorphineCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuMorphine.list = Index;

                        end)
                    end

                    if ShowLean == true then

                        RageUI.List('Points :', MenuLean.actionlean, MenuLean.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteLeanCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recoltelean = json.encode(RecolteLeanCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteLeanCoord.x..' , '..RecolteLeanCoord.y..' , '..RecolteLeanCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementLeanCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementlean = json.encode(TraitementLeanCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementLeanCoord.x..' , '..TraitementLeanCoord.y..' , '..TraitementLeanCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteLeanCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    ventelean = json.encode(VenteLeanCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteLeanCoord.x..' , '..VenteLeanCoord.y..' , '..VenteLeanCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuLean.list = Index;

                        end)
                    end

                    if ShowAmphetamines == true then

                        RageUI.List('Points :', MenuAmphetamines.actionamphetamines, MenuAmphetamines.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteAmphetaminesCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recolteamphetamines = json.encode(RecolteAmphetaminesCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteAmphetaminesCoord.x..' , '..RecolteAmphetaminesCoord.y..' , '..RecolteAmphetaminesCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementAmphetaminesCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementamphetamines = json.encode(TraitementAmphetaminesCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementAmphetaminesCoord.x..' , '..TraitementAmphetaminesCoord.y..' , '..TraitementAmphetaminesCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteAmphetaminesCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    venteamphetamines = json.encode(VenteAmphetaminesCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteAmphetaminesCoord.x..' , '..VenteAmphetaminesCoord.y..' , '..VenteAmphetaminesCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuAmphetamines.list = Index;

                        end)
                    end

                    if ShowMarijuana == true then

                        RageUI.List('Points :', MenuMarijuana.actionmarijuana, MenuMarijuana.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteMarijuanaCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recoltemarijuana = json.encode(RecolteMarijuanaCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteMarijuanaCoord.x..' , '..RecolteMarijuanaCoord.y..' , '..RecolteMarijuanaCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementMarijuanaCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementmarijuana = json.encode(TraitementMarijuanaCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementMarijuanaCoord.x..' , '..TraitementMarijuanaCoord.y..' , '..TraitementMarijuanaCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteMarijuanaCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    ventemarijuana = json.encode(VenteMarijuanaCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteMarijuanaCoord.x..' , '..VenteMarijuanaCoord.y..' , '..VenteMarijuanaCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuMarijuana.list = Index;

                        end)
                    end

                    if ShowSpeed == true then

                        RageUI.List('Points :', MenuSpeed.actionspeed, MenuSpeed.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteSpeedCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recoltespeed = json.encode(RecolteSpeedCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteSpeedCoord.x..' , '..RecolteSpeedCoord.y..' , '..RecolteSpeedCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementSpeedCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementspeed = json.encode(TraitementSpeedCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementSpeedCoord.x..' , '..TraitementSpeedCoord.y..' , '..TraitementSpeedCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteSpeedCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    ventespeed = json.encode(VenteSpeedCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteSpeedCoord.x..' , '..VenteSpeedCoord.y..' , '..VenteSpeedCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuSpeed.list = Index;

                        end)
                    end

                    if ShowThc == true then

                        RageUI.List('Points :', MenuThc.actionthc, MenuThc.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if (Selected) then

                                if Index == 1 then

                                    local RecolteThcCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    recoltethc = json.encode(RecolteThcCoord)

                                    ESX.ShowNotification('position du point :~b~'..RecolteThcCoord.x..' , '..RecolteThcCoord.y..' , '..RecolteThcCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)
    

                                elseif Index == 2 then

                                    local TraitementThcCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    traitementthc = json.encode(TraitementThcCoord)

                                    ESX.ShowNotification('position du point :~b~'..TraitementThcCoord.x..' , '..TraitementThcCoord.y..' , '..TraitementThcCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                  

                                elseif Index == 3 then

                                    local VenteThcCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 

                                    ventethc = json.encode(VenteThcCoord)

                                    ESX.ShowNotification('position du point :~b~'..VenteThcCoord.x..' , '..VenteThcCoord.y..' , '..VenteThcCoord.z.. '')

                                    DrawMarker(22, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 50, 255, 255, 0, false, true, 2, false, false, false, false)


                                end

                            end

                            MenuThc.list = Index;

                        end)
                    end

                        RageUI.List('Intérieurs : ~g~[ Pas obligatoire ]', Menu.action, Menu.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)

                            if Active then

                                if Index == 1 then             

                                    RenderSprite("RageUI3", "Weed", 0, 486, 432, 250, 80)

                                elseif Index == 2 then

                                    RenderSprite("RageUI3", "Coke", 0, 486, 432, 250, 80)

                                elseif Index == 3 then

                                    RenderSprite("RageUI3", "Meth", 0, 486, 432, 250, 80)

                                elseif Index == 4 then

                                    RenderSprite("RageUI3", "Money Wash",0, 486, 432, 250, 80)

                                elseif Index == 5 then

                                    RenderSprite("RageUI3", "Bunker", 0, 486, 432, 250, 80)

                                elseif Index == 6 then

                                    RenderSprite("RageUI3", "Hangar", 0, 486, 432, 250, 80)

                                elseif Index == 7 then

                                    RenderSprite("RageUI3", "Entrepot_grand", 0, 486, 432, 250, 80)

                                elseif Index == 8 then

                                    RenderSprite("RageUI3", "Entrepot_moyen", 0, 486, 432, 250, 80)

                                elseif Index == 9 then

                                    RenderSprite("RageUI3", "Entrepot_petit", 0, 486, 432, 250, 80)

                                end

                            end                       

                            if (Selected) then

                                if Index == 1 then

                                    ipl = '[]'

                                    inside = '{"x":1066.37,"y":-3183.48,"z":-39.16}'

                                    exit = '{"x":1066.37,"y":-3183.48,"z":-38.16}'

                                    isSingle = 1

                                    isRoom = 1

                                    isGateway = 0

                                    SetEntityCoords(GetPlayerPed(-1), 1066.37, -3183.48, -38.16)   





    

                                elseif Index == 2 then

                                    ipl = '[]'

                                    inside = '{"x":1088.69,"y":-3187.56,"z":-38.99}'

                                    exit = '{"x":1088.69,"y":-3187.56,"z":-37.99}'

                                    isSingle = 1

                                    isRoom = 1

                                    isGateway = 0

                                    SetEntityCoords(GetPlayerPed(-1), 1088.69, -3187.56, -37.99)



                                  

                                elseif Index == 3 then

                                    ipl = '[]'

                                    inside = '{"x":997.05,"y":-3200.77,"z":-36.39}'

                                    exit = '{"x":997.05,"y":-3200.77,"z":-35.39}'

                                    isSingle = 1

                                    isRoom = 1

                                    isGateway = 0

                                    SetEntityCoords(GetPlayerPed(-1), 997.05, -3200.77, -35.39)





                                elseif Index == 4 then

                                    ipl = '[]'

                                    inside = '{"x":1138.11,"y":-3199.1,"z":-39.67}'

                                    exit = '{"x":1138.11,"y":-3199.1,"z":-38.67}'

                                    isSingle = 1

                                    isRoom = 1

                                    isGateway = 0

                                    SetEntityCoords(GetPlayerPed(-1), 1138.11, -3199.1, -38.67)



                               

                                elseif Index == 4 then

                                    ipl = '[]'

                                    inside = '{"x":486.94,"y":4819.92,"z":-58.38}'

                                    exit = '{"x":486.94,"y":4819.92,"z":-57.38}'

                                    isSingle = 1

                                    isRoom = 1

                                    isGateway = 0

                                    SetEntityCoords(GetPlayerPed(-1), 486.94, 4819.92, -57.38)



                                elseif Index == 5 then

                                    ipl = '[]'

                                    inside = '{"x":486.94,"y":4819.92,"z":-58.38}'

                                    exit = '{"x":486.94,"y":4819.92,"z":-57.38}'

                                    isSingle = 1

                                    isRoom = 1

                                    isGateway = 0

                                    SetEntityCoords(GetPlayerPed(-1), 486.94, 4819.92, -57.38)


                                elseif Index == 6 then

                                    ipl = '[]'

                                    inside = '{"x":-1266.01,"y":-3046.58,"z":-48.49}'

                                    exit = '{"x":-1266.01,"y":-3046.58,"z":-47.49}'

                                    isSingle = 1

                                    isRoom = 1

                                    isGateway = 0

                                    SetEntityCoords(GetPlayerPed(-1), -1266.01, -3046.58, -47.49)


                                elseif Index == 7 then

                                    ipl = '[]'

                                    inside = '{"x":1026.5056,"y":-3099.8320,"z":-38.9998}'

                                    exit   = '{"x":998.1795"y":-3091.9169,"z":-39.9999}'

                                    isSingle = 1

                                    isRoom = 1

                                    isGateway = 0

                                    SetEntityCoords(GetPlayerPed(-1), 1026.8707, -3099.8710, -38.9998)  

                                elseif Index == 8 then

                                    ipl = '[]'

                                    inside = '{"x":1048.5067,"y":-3097.0817,"z":-38.9999}'

                                    exit   = '{"x":1072.5505,"y":-3102.5522,"z":-39.9999}'

                                    isSingle = 1

                                    isRoom = 1

                                    isGateway = 0

                                    SetEntityCoords(GetPlayerPed(-1), 1072.8447, -3100.0390, -38.9999)  

                                elseif Index == 9 then

                                    ipl = '[]'

                                    inside = '{"x":1088.1834,"y":-3099.3547,"z":-38.9999}'

                                    exit   = '{"x":1088.1834,"y":-3099.3547,"z":-39.9999}'

                                    isSingle = 1

                                    isRoom = 1

                                    isGateway = 0

                                    SetEntityCoords(GetPlayerPed(-1), 1104.7231, -3100.0690, -38.9999)  



                                end

                            end

                            Menu.list = Index;

                        end)


                        RageUI.ButtonWithStyle("Nom pour la Base de Donnée :~b~", nil, {RightLabel = name},true, function(Hovered, Active, Selected)

                            if (Selected) then

                                name  =  OpenKeyboard('name', 'Entrer un nom sans éspace !')

                            end

                        end)



                        RageUI.ButtonWithStyle("Label pour la Base de Donnée :~b~", nil, {RightLabel = label},true, function(Hovered, Active, Selected)

                            if (Selected) then

                                label = OpenKeyboard('label', 'Entrer un label !')

                            end

                        end)

                        

                        RageUI.ButtonWithStyle('Annuler la création' , nil, {Color = { BackgroundColor = { 234, 0, 0, 25 } }}, true, function(Hovered, Active, Selected) 

                            if (Selected) then

                                if name == '' then 

                                    ESX.ShowNotification('~r~Vous n\'avez aucun nom assigné !')

                                else

                            SetEntityCoords(PlayerPedId(), PedPosition.x, PedPosition.y, PedPosition.z)                           

                            RageUI.CloseAll()

                            ESX.ShowNotification('~r~Annulation de la création !')

                            end

                        end

                        end)



                        RageUI.ButtonWithStyle('Validé et créer la propriété ~r~avec Intérieur' , nil, {Color = { BackgroundColor = { 5, 3, 3, 25 } }}, true, function(Hovered, Active, Selected) 

                            if (Selected) then

                                    if name == '' then 

                                        ESX.ShowNotification('~r~Vous n\'avez aucun nom assigné !')

                                    else     

                                       TriggerServerEvent('mrw_prop:Save', name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, recolteweed, traitementweed, venteweed, recoltecoke, traitementcoke, ventecoke, recoltemeth, traitementmeth, ventemeth, recoltecannabis, traitementcannabis, ventecannabis, recoltecrack, traitementcrack, ventecrack, recolteecstasy, traitementecstasy, venteecstasy, recolteheroine, traitementheroine, venteheroine, recolteghb, traitementghb, venteghb, recoltepsychedeliques, traitementpsychedeliques, ventepsychedeliques, recolteopium, traitementopium, venteopium, recolteketamine, traitementketamine, venteketamine, recoltelsd, traitementlsd, ventelsd, recoltemorphine, traitementmorphine, ventemorphine, recoltelean, traitementlean, ventelean, recolteamphetamines, traitementamphetamines, venteamphetamines, recoltemarijuana, traitementmarijuana, ventemarijuana, recoltespeed, traitementspeed, ventespeed, recoltethc, traitementthc, ventethc, blanchiment)

                                       Citizen.Wait(15)

                                       SetEntityCoords(PlayerPedId(), PedPosition.x, PedPosition.y, PedPosition.z)

                                    end

                            end

                        end)

                        RageUI.ButtonWithStyle('Validé et créer la propriété ~r~sans Intérieur' , nil, {Color = { BackgroundColor = { 5, 3, 3, 25 } }}, true, function(Hovered, Active, Selected) 

                            if (Selected) then

                                    if name == '' then 

                                        ESX.ShowNotification('~r~Vous n\'avez aucun nom assigné !')

                                    else     

                                       TriggerServerEvent('mrw_prop:SaveSansInterieur', name, label, recolteweed, traitementweed, venteweed, recoltecoke, traitementcoke, ventecoke, recoltemeth, traitementmeth, ventemeth, recoltecannabis, traitementcannabis, ventecannabis, recoltecrack, traitementcrack, ventecrack, recolteecstasy, traitementecstasy, venteecstasy, recolteheroine, traitementheroine, venteheroine, recolteghb, traitementghb, venteghb, recoltepsychedeliques, traitementpsychedeliques, ventepsychedeliques, recolteopium, traitementopium, venteopium, recolteketamine, traitementketamine, venteketamine, recoltelsd, traitementlsd, ventelsd, recoltemorphine, traitementmorphine, ventemorphine, recoltelean, traitementlean, ventelean, recolteamphetamines, traitementamphetamines, venteamphetamines, recoltemarijuana, traitementmarijuana, ventemarijuana, recoltespeed, traitementspeed, ventespeed, recoltethc, traitementthc, ventethc, blanchiment)

                                    end 

                            end

                        end)



            end, function()    

            end, 1)

            Wait(1)

        end

    Wait(0)

    Drugs = false

    end)

end

end

local function noSpace(str)

    local normalisedString = string.gsub(str, "%s+", "")

    return normalisedString

 end



function OpenKeyboard(type, labelText)

    AddTextEntry('FMMC_KEY_TIP1', labelText)

	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", 25)

	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do

		Citizen.Wait(0)

	end

	if UpdateOnscreenKeyboard() ~= 2 then

		local result = GetOnscreenKeyboardResult() 

		Citizen.Wait(500) 

		blockinput = false 

		if type == "name" then 

			ESX.ShowNotification("Nom assigné : ~b~"..noSpace(result))

		    return noSpace(result) 

		elseif type == "label" then 

			ESX.ShowNotification("Label assigné : ~b~"..result)

			return result
        else 

            --if tonumber(result) == nil then 

               --ESX.ShowNotification("Vous devez entré un ~r~prix")

               --return

            --end 

            --ESX.ShowNotification("Prix assigné : ~b~"..tonumber(result).."~w~ $")

            --return tonumber(result)

        end
	else

		Citizen.Wait(500)

		blockinput = false 

		return nil

	end

end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)
        if IsControlJustPressed(1,Config.KeyOpenMenuBuilder) then
                ESX.TriggerServerCallback('polo_drugsbuildermenu:getUsergroup', function(group)
                    playergroup = group
                    if playergroup == Config.Group then
                      superadmin = true
                       PoloDrugs()
                    else
                        superadmin = false
                
                    end
                end)
            end 
        end
    end) 