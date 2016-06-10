local component = require("component")
local computer = require("computer")
local robot = require("robot")
local shell = require("shell")
local sides = require("sides")
local event = require("event")
local keyboard = require("keyboard")

local tunnel = component.tunnel

local function handleResponse(failed, message)
  failedStr = tostring(failed)
  if message then
    return failedStr .. message
  else
    return failedStr
  end
end
local function handleControl()
  if keyboard.isKeyDown(keyboard.keys.w) and keyboard.isControlDown() then
    os.exit()
  end
  local _, localNetworkCard, remoteAddress, port, distance, payload = event.pull("modem_message")
  if payload == "c" then
    os.exit()
  elseif payload == "w" then
    failed, message = robot.forward()
    tunnel.send(handleResponse(failed, message))
  elseif payload == "s" then
    failed, message = robot.back()
    tunnel.send(handleResponse(failed, message))
  elseif payload == "a" then
    failed, message = robot.turnLeft()
    tunnel.send(handleResponse(failed, message))
  elseif payload == "d" then
    failed, message = robot.turnRight()
    tunnel.send(handleResponse(failed, message))
  elseif payload == "q" then
    failed, message = robot.up()
    tunnel.send(handleResponse(failed, message))
  elseif payload == "e" then
    failed, message = robot.down()
  end
end

print("Press ctrl+w to quit")
while true do
  handleControl()  
end
