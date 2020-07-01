RegisterNetEvent('poke_rpchat:sendProximityMessage')
AddEventHandler('poke_rpchat:sendProximityMessage', function(playerId, title, message, color)
	local player = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local playerPed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local playerCoords, targetCoords = GetEntityCoords(playerPed), GetEntityCoords(targetPed)

	if target == player or #(playerCoords - targetCoords) < 20 then
		TriggerEvent('chat:addMessage', {args = {title, message}, color = color})
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
    local alpha = 250
    local call = N_0x554d9d53f696d002(1664425300, targetCoords.x, targetCoords.y, targetCoords.z)

    SetBlipSprite(call, blip, 1)
    Citizen.InvokeNative(0x9CB1A1623062F402, call, type)

    while alpha ~= 0 do
        Citizen.Wait(400)
        alpha = alpha - 1

        if alpha == 0 then
            RemoveBlip(call)
            return
        end
    end
end)