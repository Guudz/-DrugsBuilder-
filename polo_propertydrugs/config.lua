Config = {}

Config.DrawDistance = 10
Config.MarkerSize = {x = 1.01, y = 1.01, z = 0.5}
Config.MarkerColor = {r = 102, g = 102, b = 204}
Config.RoomMenuMarkerColor = {r = 102, g = 204, b = 102}
Config.roomMenuGarageMarkerColor = {r = 102, g = 204, b = 102}
Config.MarkerType = 20
Config.MarkerTypeGarage = 23
Config.MarkerText = true

Config.RentModifier = 200 -- rent price: <property price> / <rent modifier> (rounded)
Config.SellModifier = 2   -- sell price: <property price> / <sell modifier> (rounded)

Config.PropertiesDrugs = {}

Config.EnablePlayerManagement = false
Config.Locale = 'fr'

-- Prix Vente de Drogues

Config.PriceWeedSell = math.random(200,450)
Config.PriceCokeSell = math.random(200,450)
Config.PriceMethSell = math.random(200,450)
Config.PriceCannabisSell = math.random(200,450)
Config.PriceCrackSell = math.random(200,450)
Config.PriceEcstasySell = math.random(200,450)
Config.PriceHeroineSell = math.random(200,450)
Config.PriceGHBSell = math.random(200,450)
Config.PricePsychedeliquesSell = math.random(200,450)
Config.PriceOpiumSell = math.random(200,450)
Config.PriceKetamineSell = math.random(200,450)
Config.PriceLSDSell = math.random(200,450)
Config.PriceMorphineSell = math.random(200,450)
Config.PriceLeanSell = math.random(200,450)
Config.PriceAmphetaminesSell = math.random(200,450)
Config.PriceMarijuanaSell = math.random(200,450)
Config.PriceSpeedSell = math.random(200,450)
Config.PriceTHCSell = math.random(200,450)

-- Wash Money

Config.Slice = 10000
Config.Percentage = 80
Config.Bonus = {min = 0, max = 05}