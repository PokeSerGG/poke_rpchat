local VORPcore = exports.vorp_core:GetCore()

RegisterCommand('report', function(source, args, rawCommand)
    local _source = source
    args = table.concat(args, ' ')
    local name = GetPlayerName(_source)
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local playerName = Character.firstname..' '..Character.lastname
    TriggerClientEvent("poke_rpchat:sendReport", -1, _source, name, args)
    if Config.WebHooks['report'].enable then
        DiscordWeb(16753920, "Nombre OOC: "..name.." / Nombre IC: "..playerName, args, "Reportes", Config.WebHooks['report'].url)
    end
end, false)

VORPcore.Callback.Register('getGroupReport', function(source,cb)
    local _source = source
    local User = VORPcore.getUser(_source)
    local group = User.getGroup
    if group ~= nil then
        cb(group)
    else
        cb('user')
    end
end)