--_____   _____        ___       _   _   _____   _           ___   _____   _   _   
--|  _  \ |  _  \      /   |     | | | | |  _  \ | |         /   | /  ___| | | / /  
--| | | | | |_| |     / /| |     | | | | | |_| | | |        / /| | | |     | |/ /   
--| | | | |  _  /    / / | |  _  | | | | |  _  { | |       / / | | | |     | |\ \   
--| |_| | | | \ \   / /  | | | |_| | | | | |_| | | |___   / /  | | | |___  | | \ \  
--|_____/ |_|  \_\ /_/   |_| \_____/ |_| |_____/ |_____| /_/   |_| \_____| |_|  \_\ 



ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)


local open = false
local MenuBank = RageUI.CreateMenu("~h~BANQUE", "INTERACTION")
local transfere = RageUI.CreateSubMenu(MenuBank, "~h~BANQUE", "INTERACTION")
MenuBank.Display.Header = true
MenuBank.Closed = function()
    open = false
end

function OpenMenuBank()
    if open then
        open = false
        RageUI.Visible(MenuBank, false)
        return
    else
        open = true
        RageUI.Visible(MenuBank, true)
        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(MenuBank, function()


                    RageUI.Separator("~o~Propriétaire ~s~: ~g~".. GetPlayerName(PlayerId()))

                    RageUI.Separator("~b~Argent en banque : ~g~".. argentsoldebank .. "$")

                    RageUI.Separator("~y~Votre ID ~s~: ~g~"..GetPlayerServerId(PlayerId()))



                    RageUI.List("Déposer : ", DraJi.DeposerList, DraJi.DeposerIndex, nil, {}, true, {
                        onListChange = function(Index)
                            DraJi.DeposerIndex = Index
                        end,
                        onSelected = function(Index)
                            if Index == 1 then
                                local DepotMontant = KeyboardInput("Entrée le montant à déposer", "", 15)
                                if DepotMontant ~= nil then
                                    if tonumber(DepotMontant) then
                                        TriggerServerEvent('DraJi:deposer', tonumber(DepotMontant))
                                        RefreshArgentBank()
                                    end
                                end
                            elseif Index == 2 then
                                TriggerServerEvent('DraJi:deposer', 500)
                                RefreshArgentBank()
                            elseif Index == 3 then
                                TriggerServerEvent('DraJi:deposer', 1000)
                                RefreshArgentBank()
                            elseif Index == 4 then
                                TriggerServerEvent('DraJi:deposer', 1500)
                                RefreshArgentBank()
                            end
                        end
                    })

                    RageUI.List("Retrait : ", DraJi.RetirerList, DraJi.RetirerIndex, nil, {}, true, {
                        onListChange = function(Index)
                            DraJi.RetirerIndex = Index
                        end,
                        onSelected = function(Index)
                            if Index == 1 then
                                local RetraitMontant = KeyboardInput("Entrée le montant à retiré", "", 15)
                                if RetraitMontant ~= nil then
                                    if tonumber(RetraitMontant) then
                                        TriggerServerEvent('DraJi:Retrait', tonumber(RetraitMontant))
                                        RefreshArgentBank()
                                    end
                                end
                            elseif Index == 2 then
                                TriggerServerEvent('DraJi:Retrait', 500)
                                RefreshArgentBank()
                            elseif Index == 3 then
                                TriggerServerEvent('DraJi:Retrait', 1000)
                                RefreshArgentBank()
                            elseif Index == 4 then
                                TriggerServerEvent('DraJi:Retrait', 1500)
                                RefreshArgentBank()
                            end
                        end
                    })

                    RageUI.Button("Faire un Transfère", nil, {
                        RightLabel = "→"
                    }, true, {
                        onSelected = function()
                        end
                    }, transfere)

                end)

                RageUI.IsVisible(transfere, function()

                    RageUI.Button("ID de la personne", nil, {
                        RightLabel = to
                    }, true, {
                        onSelected = function()
                            local idperso = KeyboardInput("ID DE LA PERSONNE", '', '', 20)
                            if idperso ~= nil then
                                to = (tostring(idperso))
                            end
                        end
                    })
                    RageUI.Button("Somme du Transfère", nil, {
                        RightLabel = amountt
                    }, true, {
                        onSelected = function()
                            local somme = KeyboardInput("SOMME", '', '', 20)
                            if somme ~= nil then
                                amountt = (tostring(somme))
                            end
                        end
                    })
                    RageUI.Button("Valider le Transfère", nil, {
                        RightLabel = "→"
                    }, true, {
                        onSelected = function()
                            TriggerServerEvent('DraJi:transfer', to, amountt)
                            RefreshArgentBank()
                        end
                    })
                end)
                Wait(0)
            end
        end)
    end
end
