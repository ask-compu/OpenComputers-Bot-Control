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
  elseif keyboard.isKeyDown(keyboard.keys.z) then
    tunnel.send("z")
  elseif keyboard.isKeyDown(keyboard.keys.x) then
    tunnel.send("x")
  elseif keyboard.isKeyDown(keyboard.keys.v) then
    tunnel.send("v")
  elseif keyboard.isKeyDown(keyboard.keys.t) then
    tunnel.send("t")
  elseif keyboard.isKeyDown(keyboard.keys.f) then
    tunnel.send("f")
    local _, localNetworkCard, remoteAddress, port, distance, payload = event.pull("modem_message")
    io.write(payload)
    slotNumber = io.read("*n")
    tunnel.send(tostring(slotNumber))
  elseif keyboard.isKeyDown(keyboard.keys.r) then
    tunnel.send("r")
  elseif keyboard.isKeyDown(keyboard.keys.c) then
    tunnel.send("c")
    os.exit()
  end
  local _, localNetworkCard, remoteAddress, port, distance, payload = event.pull("modem_message")
  print(payload)
  printKeys()
end

function printKeys()
  print("w = forward   x = use")
  print("s = backward   z = swing")
  print("a = turn left  v = place")
  print("d = turn right  f = select inventory slot")
  print("q = up  r = beep")
  print("e = down  t = take items")
end

printKeys()

while true do
  handleControl()  
end
