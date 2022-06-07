ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("DraJi:deposer")
AddEventHandler("DraJi:deposer", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local montant = money
    local xMoney = xPlayer.getMoney()

    if xMoney >= montant then

        xPlayer.addAccountMoney('bank', montant)
        xPlayer.removeMoney(montant)

        TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'Banque',
            "Vous avez deposé ~g~" .. montant .. "$~s~ à la banque !", 'CHAR_BANK_FLEECA', 1)
    else
        TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'Retrait',
            "Vous n'avez pas suffisament d'argent", 'CHAR_BANK_FLEECA', 1)
    end
end)

RegisterNetEvent('DraJi:Retrait')
AddEventHandler('DraJi:Retrait', function(montant)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if xPlayer.getAccount('bank').money >= montant then
        xPlayer.removeAccountMoney('bank', montant)
        xPlayer.addMoney(montant)
        Citizen.Wait(500)
        TriggerClientEvent('esx:showAdvancedNotification', _src, 'Banque', 'Retrait',
            "Vous venez de retrait ~g~" .. montant .. "$ ~s~dans votre banque.", 'CHAR_BANK_FLEECA', 1)
    else
        Citizen.Wait(500)
        TriggerClientEvent('esx:showAdvancedNotification', _src, 'Banque', 'Retrait',
            "Vous n'avez pas suffisament d'argent", 'CHAR_BANK_FLEECA', 1)
    end
end)

RegisterServerEvent("DraJi:Argent")
AddEventHandler("DraJi:Argent", function(action, amount)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local playerMoney = xPlayer.getMoney()

    TriggerClientEvent("DraJi:RefreshArgent", source, playerMoney)
end)

RegisterServerEvent("DraJi:ArgentBank")
AddEventHandler("DraJi:ArgentBank", function(action, amount)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local playerMoneyBank = xPlayer.getAccount('bank').money

    TriggerClientEvent("DraJi:RefreshArgentBank", source, playerMoneyBank)
end)


RegisterServerEvent('DraJi:transfer')
AddEventHandler('DraJi:transfer', function(to, amountt)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(to)
    local balance = 0

    if (zPlayer == nil or zPlayer == -1) then
        TriggerClientEvent('esx:showAdvancedNotification', _source, "Problème", 'Banque',
            "Ce destinataire n'existe pas.", 'CHAR_BANK_FLEECA', 1)
    else
        balance = xPlayer.getAccount('bank').money
        zbalance = zPlayer.getAccount('bank').money

        if tonumber(_source) == tonumber(to) then
            TriggerClientEvent('esx:showAdvancedNotification', _source, "Problème", 'Banque',
                "Vous ne pouvez pas transférer d'argent à vous-même.", 'CHAR_BANK_FLEECA', 1)
        else
            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
                TriggerClientEvent('esx:showAdvancedNotification', _source, 'Banque', "Problème",
                    "Vous n'avez pas assez d'argent en banque.", 'CHAR_BANK_FLEECA', 1)
            else
                xPlayer.removeAccountMoney('bank', tonumber(amountt))
                zPlayer.addAccountMoney('bank', tonumber(amountt))
                TriggerClientEvent('esx:showAdvancedNotification', _source, "Succès", 'Banque',
                    "Transfert réussi vous avez envoyé " .. tonumber(amountt) .. " $ à " .. zPlayer.getName(),
                    'CHAR_BANK_FLEECA', 1)
                TriggerClientEvent('esx:showAdvancedNotification', to, "Banque", 'Banque',
                    "Vous avez recu " .. tonumber(amountt) .. " $ de la part de " .. xPlayer.getName(),
                    'CHAR_BANK_FLEECA_FLEECA', 1)
            end
        end
    end
end)
