--_____   _____        ___       _   _   _____   _           ___   _____   _   _   
--|  _  \ |  _  \      /   |     | | | | |  _  \ | |         /   | /  ___| | | / /  
--| | | | | |_| |     / /| |     | | | | | |_| | | |        / /| | | |     | |/ /   
--| | | | |  _  /    / / | |  _  | | | | |  _  { | |       / / | | | |     | |\ \   
--| |_| | | | \ \   / /  | | | |_| | | | | |_| | | |___   / /  | | | |___  | | \ \  
--|_____/ |_|  \_\ /_/   |_| \_____/ |_| |_____/ |_____| /_/   |_| \_____| |_|  \_\ 


function KeyboardInput(textEntry, inputText, maxLength)
    AddTextEntry('FMMC_KEY_TIP1', textEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(1.0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        return result
    else
        Wait(500)
        return nil
    end
end

argentsolde = 0
argentsoldebank = 0
amountt = nil
to = nil

DraJi = {
    DeposerList = {"Personnalisé", "~g~500$~s~", "~g~1000$~s~", "~g~1500$~s~"},
    DeposerIndex = 1,
    RetirerList = {"Personnalisé", "~g~500$~s~", "~g~1000$~s~", "~g~1500$~s~"},
    RetirerIndex = 1
}

RegisterNetEvent("DraJi:RefreshArgentBank")
AddEventHandler("DraJi:RefreshArgentBank", function(money, cash)
    argentsoldebank = tonumber(money)
end)

function RefreshArgentBank()
    TriggerServerEvent("DraJi:ArgentBank", action)
end


function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end


Keys.Register("E", "-openbankatm", "Ouvrir le menu ATM", function()
    for index, objects in ipairs(Bank.ATMObjects) do
        local myCoords = GetEntityCoords(PlayerPedId())
        local getClosestObjects = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 0.7, GetHashKey(objects),
            true, true, true)
        if getClosestObjects ~= 0 then
            playAnim('mp_common', 'givetake2_a', 2500)
            Citizen.Wait(1000)
            OpenMenuBank()
            RefreshArgentBank()
        end
    end
end)




