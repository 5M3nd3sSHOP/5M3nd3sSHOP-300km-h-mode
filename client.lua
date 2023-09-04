local vehicleSpeedLimits = {}

RegisterNetEvent("updateVehicleSpeedLimit")
AddEventHandler("updateVehicleSpeedLimit", function(vehicle, speedLimit)
    vehicleSpeedLimits[vehicle] = speedLimit
end)

RegisterNetEvent("resetVehicleSpeedLimit")
AddEventHandler("resetVehicleSpeedLimit", function(vehicle)
    vehicleSpeedLimits[vehicle] = nil
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

        if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
            local currentSpeed = GetEntitySpeed(vehicle) * 3.6 
            local speedLimit = vehicleSpeedLimits[vehicle]

            if speedLimit and currentSpeed > speedLimit then
                SetEntityMaxSpeed(vehicle, speedLimit / 3.6) 
            end
        end
    end
end)


local isModo300Ativado = false

RegisterCommand("modo300", function()
    isModo300Ativado = not isModo300Ativado

    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        if isModo300Ativado then
            local currentSpeed = GetEntitySpeed(vehicle) * 3.6 
            TriggerEvent("chatMessage", "^2Modo 300 km/h ativado!")
            TriggerServerEvent("setVehicleSpeedLimit", vehicle, currentSpeed + 300.0) -- change here your max velocity!
        else
            TriggerEvent("chatMessage", "^1Modo 300 km/h desativado!")
            TriggerServerEvent("resetVehicleSpeedLimit", vehicle)
        end
    end
end, false)
