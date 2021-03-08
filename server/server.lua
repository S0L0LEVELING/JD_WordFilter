_warnings = 0

RegisterNetEvent('getDropped')
AddEventHandler('getDropped', function()
	DropPlayer(source, Config.KickMessage)
	return
end)

AddEventHandler('chatMessage', function(source, name, message)
	TriggerClientEvent('addWarning', source, message)
end)

exports('checkMessage', function(id, message)
	TriggerClientEvent('addWarning', id, message)
end)

-- version check
Citizen.CreateThread(
	function()
		local vRaw = LoadResourceFile(GetCurrentResourceName(), 'version.json')
		if vRaw and Config.versionCheck then
			local v = json.decode(vRaw)
			PerformHttpRequest(
				'https://raw.githubusercontent.com/JokeDevil/JD_WordFilter/master/version.json',
				function(code, res, headers)
					if code == 200 then
						local rv = json.decode(res)
						if rv.version ~= v.version then
							print(
								([[^1
-------------------------------------------------------
JD_WordFilter
UPDATE: %s AVAILABLE
CHANGELOG: %s
-------------------------------------------------------
^0]]):format(
									rv.version,
									rv.changelog
								)
							)
						end
					else
						print('JD_WordFilter unable to check version')
					end
				end,
				'GET'
			)
		end
	end
)