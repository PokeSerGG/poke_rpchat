local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

-- LOCAL OOC
AddEventHandler('chatMessage', function(source, name, message)
    if string.sub(message, 1, string.len("/")) ~= "/" then
        local name = GetPlayerName(source)
        TriggerClientEvent('poke_rpchat:sendProximityMessage', -1, source, '[OOC] '..name, message, {128, 128, 128})
        if Config.WebHooks['ooc'].enable then
            DiscordWeb(Config.WebHooks['ooc'].color, "Nombre OOC: "..name, message, "OOC", Config.WebHooks['ooc'].url)
        end
    end
    CancelEvent()
end)

-- CHAT COMMANDS
RegisterCommand('ayuda', function(source, args, rawCommand)
    local source = source
    local msg = rawCommand:sub(6)
    if player ~= false then
        if args[1] ~= nil then
            local user = GetPlayerName(source)
            TriggerClientEvent("chatMessage", -1, "[Ayuda] [ID:"..source.."] ["..user.."]", {135, 105, 105}, msg)
            if Config.WebHooks['help'].enable then
                DiscordWeb(Config.WebHooks['help'].color, "Nombre OOC: "..user, msg, "Help", Config.WebHooks['help'].url)
            end
        end
    end
end, false)

-- PROXIMITY CHAT
RegisterCommand('me', function(source, args, rawCommand)
    local source = source
    args = table.concat(args, ' ')
    local User = VorpCore.getUser(source)
    local oocName = GetPlayerName(source)
    local Character = User.getUsedCharacter
    local playerName = Character.firstname..' '..Character.lastname
    TriggerClientEvent('poke_rpchat:sendProximityMessage', -1, source, playerName, args, {255, 0, 0})
    if Config.WebHooks['me'].enable then
        DiscordWeb(Config.WebHooks['me'].color, "Nombre OOC: "..oocName.." / Nombre IC: "..playerName, args, "Me", Config.WebHooks['me'].url)
    end
end, false)

RegisterCommand('do', function(source, args, rawCommand)
    local source = source
    args = table.concat(args, ' ')
    local User = VorpCore.getUser(source)
    local oocName = GetPlayerName(source)
    local Character = User.getUsedCharacter
    local playerName = Character.firstname..' '..Character.lastname
    TriggerClientEvent('poke_rpchat:sendProximityMessage', -1, source, playerName, args, {0, 0, 255})
    if Config.WebHooks['do'].enable then
        DiscordWeb(Config.WebHooks['do'].color, "Nombre OOC: "..oocName.." / Nombre IC: "..playerName, args, "Do", Config.WebHooks['do'].url)
    end
end, false)

-- COMMERCE COMMAND
RegisterCommand('anuncio', function(source, args, rawCommand)
    local source = source
    args = table.concat(args, ' ')
    local User = VorpCore.getUser(source)
    local oocName = GetPlayerName(source)
    local Character = User.getUsedCharacter
    local playerName = Character.firstname..' '..Character.lastname
    TriggerClientEvent("chatMessage", -1, "[Comercio] ["..playerName.."]", {9, 81, 3}, args)
    if Config.WebHooks['commerce'].enable then
        DiscordWeb(Config.WebHooks['commerce'].color, "Nombre OOC: "..oocName.." / Nombre IC: "..playerName, args, "Commerce", Config.WebHooks['commerce'].url)
    end
end, false)

-- PRIVATE MESSAGE
RegisterCommand('pm', function(source, args, user)
    local player = tonumber(args[1])
    local message = args[2]
    table.remove(args, 1)
    if player then
        local playerName = GetPlayerName(player)
        if message then
            TriggerClientEvent("chatMessage", player, "[PM] ["..source.."] ["..GetPlayerName(source).."]", {158, 65, 0}, table.concat(args," "))
            TriggerClientEvent("chatMessage", source, "[Sistema]", {255, 0, 0}, "Tu mensaje privado ha sido enviado")
            if Config.WebHooks['pm'].enable then
                DiscordWeb(Config.WebHooks['pm'].color, "Enviado por: "..GetPlayerName(source).." / Recibido por: "..playerName, table.concat(args," "), "Private Message", Config.WebHooks['pm'].url)
            end
        end
    end
end, false)

-- Check if players have specific job
IsPlayerAllowed = function(job)
    local players = GetPlayers()
    for i = 1, #players, 1 do
        local User = VorpCore.getUser(players[i])
        local Character = User.getUsedCharacter
        if Character.job == job then
            return true, players[i]
        end
    end
    return false
end

-- SEND CALL
RegisterServerEvent('poke_rpchat:sendcall')
AddEventHandler('poke_rpchat:sendcall', function(targetCoords, msg, emergency)
    local _source = source
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local sourcename = Character.firstname..' '..Character.lastname
    local isPolice, playersPolice = IsPlayerAllowed("police")
    local isDoctor, playersDoctor = IsPlayerAllowed("doctor")
    if emergency == 'testigo' then
        if isPolice then
            TriggerClientEvent("chatMessage", playersPolice, "[Testigo] [".._source.."] ["..sourcename.."]", {255, 0, 0}, msg)
            TriggerClientEvent('poke_rpchat:marcador', playersPolice, targetCoords, emergency, -1747825963)
        end
        TriggerClientEvent("chatMessage", _source, "[Testigo]", {0, 147, 255}, msg)
        TriggerClientEvent('poke_rpchat:marcador', _source, targetCoords, emergency, -1747825963)
        if Config.WebHooks['testigo'].enable then
            DiscordWeb(Config.WebHooks['testigo'].color, "Nombre OOC: "..GetPlayerName(_source).." / Nombre IC: "..sourcename, msg, "Testigo", Config.WebHooks['testigo'].url)
        end
    elseif emergency == 'auxilio' then
        if isDoctor then
            TriggerClientEvent("chatMessage", playersDoctor, "[Auxilio] [".._source.."] ["..sourcename.."]", {255, 0, 0}, msg)
            TriggerClientEvent('poke_rpchat:marcador', playersDoctor, targetCoords, emergency, 1000514759)
        end
        TriggerClientEvent("chatMessage", _source, "[Auxilio]", {255, 0, 0}, msg)
        TriggerClientEvent('poke_rpchat:marcador', _source, targetCoords, emergency, 1000514759)
        if Config.WebHooks['auxilio'].enable then
            DiscordWeb(Config.WebHooks['auxilio'].color, "Nombre OOC: "..GetPlayerName(_source).." / Nombre IC: "..sourcename, msg, "Auxilio", Config.WebHooks['auxilio'].url)
        end
    end
end)

function DiscordWeb(color, name, message, footer, url)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "📛Reporte📛",
            ["description"] = "**".. name .."** \n"..message,
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }
    PerformHttpRequest(url, function(err, text, headers) end, 'POST', json.encode({username = Config.ServerName, embeds = embed}), { ['Content-Type'] = 'application/json' })
end
