Inventory = exports.vorp_inventory:vorp_inventoryApi()
-- ADMIN COMMANDS
RegisterCommand('curar', function(source, args, user)
    local _source = source
    TriggerEvent("vorp:getCharacter", _source, function(user)
        local group = user.group
        if group == 'admin' then
            TriggerClientEvent("vorpmetabolism:setValue", _source, "Hunger", 1000)
            TriggerClientEvent("vorpmetabolism:setValue", _source, "Thirst", 1000)
        end
    end)
end, false)

RegisterCommand('additem', function(source, args, rawCommand)
    local _source = source
    local player = tonumber(args[1])
    local item = args[2]
    local count = args[3]
    TriggerEvent("vorp:getCharacter", _source, function(user)
        local group = user.group
        if group == 'admin' then
            if player and item and count then
                Inventory.addItem(player, item, count)
            else
                TriggerClientEvent("chatMessage", _source, "Error de sintaxis", {255, 0, 0}, "/additem id item count")
            end
        end
    end)
end, false)

RegisterCommand('report', function(source, args, rawCommand)
    local source = source
    args = table.concat(args, ' ')
    local name = GetPlayerName(source)
    TriggerEvent("vorp:getCharacter", source, function(user)
        local playerName = user.firstname..' '..user.lastname
        TriggerClientEvent("chatMessage", source, "[Sistema]", {255, 0, 0}, "Tu report ha sido enviado a los administradores")
        if Config.UseDiscord then
            DiscordWeb(16753920, "Nombre OOC: "..name.." / Nombre IC: "..playerName, args, "Reportes")
        end
    end)
end, false)

function DiscordWeb(color, name, message, footer)
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
    PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode({username = Config.ServerName, embeds = embed}), { ['Content-Type'] = 'application/json' })
end