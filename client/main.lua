local usergroup = 'user'

Citizen.CreateThread(function()
    TriggerEvent("vorp:ExecuteServerCallBack", "getGroupReport", function(group)
        usergroup = group
    end, 'i')
end)

RegisterNetEvent('poke_rpchat:sendProximityMessage')
AddEventHandler('poke_rpchat:sendProximityMessage', function(playerId, title, message, color)
	local player = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local playerCoords, targetCoords = GetEntityCoords(playerPed), GetEntityCoords(targetPed)

    if target ~= -1 then
        if target == player or #(playerCoords - targetCoords) < 20 then
            TriggerEvent('chat:addMessage', {args = {title, message}, color = color})
        end
    end
end)

RegisterCommand('testigo', function(source, args, rawCommand)
    local playerCoords = GetEntityCoords(PlayerPedId(), true)
	local msg = rawCommand:sub(9)
	local emergency = 'testigo'
    TriggerServerEvent('poke_rpchat:sendcall', { x = playerCoords.x, y = playerCoords.y, z = playerCoords.z }, msg, emergency)
end, false)

RegisterCommand('auxilio', function(source, args, rawCommand)
    local playerCoords = GetEntityCoords(PlayerPedId(), true)
	local msg = rawCommand:sub(9)
	local emergency = 'auxilio'
    TriggerServerEvent('poke_rpchat:sendcall', { x = playerCoords.x, y = playerCoords.y, z = playerCoords.z }, msg, emergency)
end, false)

RegisterNetEvent('poke_rpchat:marcador')
AddEventHandler('poke_rpchat:marcador', function(targetCoords, type, blip)
    local alpha = Config.BlipCallTimer
    local call = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, targetCoords.x, targetCoords.y, targetCoords.z)

    SetBlipSprite(call, blip, 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, call, type)

    while alpha > 0 do
        Citizen.Wait(1000)
        alpha = alpha - 1
    end

    RemoveBlip(call)
end)

RegisterNetEvent('poke_rpchat:sendReport')
AddEventHandler('poke_rpchat:sendReport', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {args = {"^1[Reporte]: ^r", "Enviado a todos los administradores"}})
    end

    if usergroup ~= 'user' then
        message =  " [".. id .."] " .. name .."  "..": " .. message
        TriggerEvent('chat:addMessage', {args = {"^1[Reporte]:^r", message}})
    end
end)