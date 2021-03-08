local warnings = 0

RegisterNetEvent('addWarning')
AddEventHandler('addWarning', function(message)
  for i = 1, #Config.Swearwords do
    print(i)
		if string.find(message, Config.Swearwords[i]) then
      warnings = warnings + 1
			if warnings >= tonumber(Config.WarnLimit) then
				TriggerServerEvent('getDropped')
				CancelEvent()
				if Config.Logs then
					exports.JD_logs:discord(GetPlayerName(GetPlayerServerId(PlayerId())).." was Kicked for Foul Language\nMessage: "..message, GetPlayerServerId(PlayerId()), 0, Config.LogsColor, Config.LogsChannel)
				end
				return
			else 
				TriggerEvent('chatMessage', Config.WarningChatName, { 255, 0, 0 }, Config.WarningMessage)
                CancelEvent()
				if Config.Logs then
					exports.JD_logs:discord(GetPlayerName(GetPlayerServerId(PlayerId())).." used foul language. They now have " .. _warnings .. " warnings(s).\nMessage: "..message, GetPlayerServerId(PlayerId()), 0, Config.LogsColor, Config.LogsChannel)
				end
				return
			end
		end
	end
end)

RegisterCommand("warns", function(source, args, rawCommand)
	TriggerEvent('chatMessage', Config.WarningChatName, { 255, 0, 0 }, "You currently have ^1"..tonumber(warnings).."/"..Config.WarnLimit.." ^0chat warning(s).")
end)

AddEventHandler("playerSpawned", function(spawn)
  TriggerEvent("chatMessage", Config.WarningChatName, { 255, 0, 0 }, "This server actively monitors chat for offensive and/or derogatory language. Please refrain from using such.")
end)