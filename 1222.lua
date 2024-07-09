local GUI = require("GUI")
local system = require("System")
local component = require("component")
local event = require("Event")
if not component.isAvailable("modem") then
  GUI.alert("This programm requies wireless modem.")
  return
end
local m = component.modem
port = 556
local workspace, window, menu = system.addWindow(GUI.filledWindow(1, 1, 60, 20, 0xE1E1E1))
local localization = system.getCurrentScriptLocalization()
local layout = window:addChild(GUI.layout(1, 1, window.width, window.height, 1, 1))
local modemH = event.addHandler(function(e1, e2, e3, e4, e5, e6)
    if e1 == "modem_message" then
      window:addChild(GUI.text(2, 11, 0x000000, localization.from))
      window:addChild(GUI.text(7, 11, 0x000000, "                                                           "))
      window:addChild(GUI.text(7, 11, 0x000000, e3))
      window:addChild(GUI.text(2, 12, 0x000000, localization.port))
      window:addChild(GUI.text(8, 12, 0x000000, "                                                           "))
      window:addChild(GUI.text(8, 12, 0x000000, e4))
      window:addChild(GUI.text(2, 13, 0x000000, localization.message))
      window:addChild(GUI.text(13, 13, 0x000000, "                                                           "))
      window:addChild(GUI.text(13, 13, 0x000000, e6))
    end
end)

m.open(556)
window:addChild(GUI.text(2, 7, 0x000000, localization.programName))
window:addChild(GUI.text(2, 8, 0x000000, localization.inst1))
window:addChild(GUI.text(2, 9, 0x000000, localization.inst2))
window:addChild(GUI.text(2, 10, 0x000000, localization.packet))

local handlerOffB = window:addChild(GUI.button(2, 4, 15, 3, 0xFFFFFF, 0x555555, 0x696969, 0xFFFFFF, localization.handlerOff))
handlerOffB.onTouch = function()
  event.removeHandler(modemH)
end

local portInput = window:addChild(GUI.input(18, 4, 20, 3, 0xEEEEEE, 0x555555, 0x999999, 0xFFFFFF, 0x2D2D2D, 556, localization.portI))
portInput.onInputFinished = function()
  port = tonumber(portInput.text)
  m.close()
  m.open(port)
end

window.onResize = function(newWidth, newHeight)
  window.backgroundPanel.width, window.backgroundPanel.height = newWidth, newHeight
  layout.width, layout.height = newWidth, newHeight
end
workspace:draw()
