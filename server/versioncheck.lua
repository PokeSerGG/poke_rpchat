if Config.VersionCheck then
    Citizen.CreateThread(function()
        updatePath = "/PokeSerGG/poke_rpchat"
        resourceName = "poke_rpchat ("..GetCurrentResourceName()..")"

        function checkVersion(err, responseText, headers)
            local curVersion = LoadResourceFile(GetCurrentResourceName(), "version")

            if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
                print("^1"..resourceName.." is outdated. Newest version: "..responseText.." \nplease update it from https://github.com"..updatePath.."")
            elseif tonumber(curVersion) > tonumber(responseText) then
                print("You somehow skipped a few versions of "..resourceName.." or the git went offline, if it's still online i advise you to update ( or downgrade? )")
            else
                print("^2"..resourceName.." is up to date, have fun!")
            end
        end

        PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/master/version", checkVersion, "GET")
    end)
end