local GUI = require("GUI")
local system = require("System")
local filesystem = require("Filesystem")
local component = require("component")
if not component.isAvailable("modem") then
  GUI.alert("ЭТОЙ ПРОГЕ НУЖЕН МОДЕМ БЛЯТЬ.")
  return
end
local m = component.modem
message = "дарова мир че как"
port = 444

local workspace, window, menu = system.addWindow(GUI.filledWindow(1, 1, 60, 20, 0xE1E1E1))
local currentSriptDirectory = filesystem.path(system.getCurrentScript())

local layout = window:addChild(GUI.layout(1, 1, window.width, window.height, 1, 1))

window.onResize = function(newWidth, newHeight)
  window.backgroundPanel.width, window.backgroundPanel.height = newWidth, newHeight
  layout.width, layout.height = newWidth, newHeight
end

local messageInput = window:addChild(GUI.input(2, 12, 20, 3, 0xEEEEEE, 0x555555, 0x999999, 0xFFFFFF, 0x2D2D2D, "Hello world", "Message"))
messageInput.onInputFinished = function()
  message = messageInput.text
end

local portInput = window:addChild(GUI.input(24, 8, 20, 3, 0xEEEEEE, 0x555555, 0x999999, 0xFFFFFF, 0x2D2D2D, 123, "порт"))
portInput.onInputFinished = function()
  port = tonumber(portInput.text)
  m.close()
end

local portIsOpenButton = window:addChild(GUI.button(2, 4, 20, 3, 0xFFFFFF, 0x555555, 0x3C3C3C, 0xFFFFFF, "Port is open?"))
portIsOpenButton.onTouch = function()
  GUI.alert(m.isOpen(port))
end
local broadcastButton = window:addChild(GUI.button(2, 8, 20, 3, 0xFFFFFF, 0x555555, 0x3C3C3C, 0xFFFFFF, "Отправить"))
broadcastButton.onTouch = function()
  m.broadcast(port, message)
end

local setPortButton = window:addChild(GUI.button(24, 4, 20, 3, 0xFFFFFF, 0x555555, 0x3C3C3C, 0xFFFFFF, "Изменить порт"))
setPortButton.onTouch = function()
  m.open(port)
end

workspace:draw()
