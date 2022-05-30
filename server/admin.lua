VORP = exports.vorp_core:vorpAPI()

RegisterCommand('report', function(source, args, rawCommand)
    local source = source
    args = table.concat(args, ' ')
    local name = GetPlayerName(source)
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local playerName = Character.firstname..' '..Character.lastname
    TriggerClientEvent("poke_rpchat:sendReport", -1, source, name, args)
    if Config.WebHooks['report'].enable then
        DiscordWeb(16753920, "Nombre OOC: "..name.." / Nombre IC: "..playerName, args, "Reportes", Config.WebHooks['report'].url)
    end
end, false)

VORP.addNewCallBack("getGroupReport", function(source, cb, item)
    local _source = source
    local User = VorpCore.getUser(_source)
    local group = User.getGroup
    if group ~= nil then
        cb(group)
    else
        cb('user')
    end
end)