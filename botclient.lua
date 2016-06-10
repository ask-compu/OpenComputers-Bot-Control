local component = require("component")
local computer = require("computer")
local event = require("event")
local keyboard = require("keyboard")

local tunnel = component.tunnel

local function handleControl()
  event.pull("key_down")
  if keyboard.isKeyDown(keyboard.keys.w) then
    tunnel.send("w")
  elseif keyboard.isKeyDown(keyboard.keys.s) then
    tunnel.send("s")
  elseif keyboard.isKeyDown(keyboard.keys.a) then
    tunnel.send("a")
  elseif keyboard.isKeyDown(keyboard.keys.d) then
    tunnel.send("d")
  elseif keyboard.isKeyDown(keyboard.keys.q) then
    tunnel.send("q")
  elseif keyboard.isKeyDown(keyboard.keys.e) then
    tunnel.send("e")
  elseif keyboard.isKeyDown(keyboard.keys.c) then
    tunnel.send("c")
    os.exit()
  end
  local _, localNetworkCard, remoteAddress, port, distance, payload = event.pull("modem_message")
  print(payload)
end

print("w = forward")
print("s = backward")
print("a = turn left")
print("d = turn right")
print("q = up")
print("e = down")

while true do
  handleControl()  
end
