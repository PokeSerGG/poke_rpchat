VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

-- LOCAL OOC
AddEventHandler('chatMessage', function(source, name, message)
    if string.sub(message, 1, string.len("/")) ~= "/" then
        local name = GetPlayerName(source)
        TriggerClientEvent('poke_rpchat:sendProximityMessage', -1, source, '[OOC] '..name, message, {128, 128, 128})
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
        end
    end
end, false)

-- PROXIMITY CHAT
RegisterCommand('me', function(source, args, rawCommand)
    local source = source
    args = table.concat(args, ' ')
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local playerName = Character.firstname..' '..Character.lastname
    TriggerClientEvent('poke_rpchat:sendProximityMessage', -1, source, playerName, args, {255, 0, 0})
end, false)

RegisterCommand('do', function(source, args, rawCommand)
    local source = source
    args = table.concat(args, ' ')
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local playerName = Character.firstname..' '..Character.lastname
    TriggerClientEvent('poke_rpchat:sendProximityMessage', -1, source, playerName, args, {0, 0, 255})
end, false)

-- COMMERCE COMMAND
RegisterCommand('anuncio', function(source, args, rawCommand)
    local source = source
    local playerName
    args = table.concat(args, ' ')
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local playerName = Character.firstname..' '..Character.lastname
    TriggerClientEvent("chatMessage", -1, "[Comercio] ["..playerName.."]", {9, 81, 3}, args)
end, false)

-- PRIVATE MESSAGE
RegisterCommand('pm', function(source, args, user)
    local player = tonumber(args[1])
    local message = args[2]
    table.remove(args, 1)
    if player then
        if message then
            TriggerClientEvent("chatMessage", player, "[PM] ["..source.."] ["..GetPlayerName(source).."]", {158, 65, 0}, table.concat(args," "))
            TriggerClientEvent("chatMessage", source, "[Sistema]", {255, 0, 0}, "Tu mensaje privado ha sido enviado")
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
            return true
        else
            return false
        end
    end
end

-- SEND CALL
RegisterServerEvent('poke_rpchat:sendcall')
AddEventHandler('poke_rpchat:sendcall', function(targetCoords, msg, emergency)
    local _source = source
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local sourcename = Character.firstname..' '..Character.lastname
    if emergency == 'testigo' and IsPlayerAllowed("police") then
        TriggerClientEvent("chatMessage", -1, "[Testigo] [".._source.."] ["..sourcename.."]", {255, 0, 0}, msg)
        TriggerClientEvent('poke_rpchat:marcador', -1, targetCoords, emergency, -1747825963)
    elseif emergency == 'auxilio' and IsPlayerAllowed("doctor") then
        TriggerClientEvent("chatMessage", -1, "[Auxilio] [".._source.."] ["..sourcename.."]", {255, 0, 0}, msg)
        TriggerClientEvent('poke_rpchat:marcador', -1, targetCoords, emergency, 1000514759)
    end
end)
