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
  if failed then
    robot.setLightColor(0x00FF00)
  else
    robot.setLightColor(0x808000)
  end
  if message then
    return failedStr .. " " .. message
  else
    return failedStr
  end
end
local function handleControl()
  robot.setLightColor(0xFFC0CB)
  if keyboard.isKeyDown(keyboard.keys.w) and keyboard.isControlDown() then
    robot.setLightColor(0xFF0000)
    os.exit()
  end
  local _, localNetworkCard, remoteAddress, port, distance, payload = event.pull("modem_message")
  if payload == "c" then
    robot.setLightColor(0xFF0000)
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
  elseif payload == "z" then
    failed, message = robot.swing()
    tunnel.send(handleResponse(failed, message))
  elseif payload == "x" then
    failed, message = robot.use()
    tunnel.send(handleResponse(failed, message))
  elseif payload == "v" then
    failed, message = robot.place()
    tunnel.send(handleResponse(failed, message))
  elseif payload == "q" then
    failed, message = robot.up()
    tunnel.send(handleResponse(failed, message))
  elseif payload == "f" then
    tunnel.send("Inventory slot number? ")
    local _, localNetworkCard, remoteAddress, port, distance, payload = event.pull("modem_message")
    number = tostring(robot.select(tonumber(payload)))
    tunnel.send(number)
  elseif payload == "e" then
    failed, message = robot.down()
  end
end

print("Press ctrl+w to quit")
robot.setLightColor(0xFFC0CB)
while true do
  handleControl()  
end
