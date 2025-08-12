<p align="center">
  <h1 align="center"><big>DraggableGui</big></h1>
</p>

**DraggableGui** is a simple Module Script that makes a GUI draggable, with a custom drag initiator, mimicing the function of the original [`GuiObject.Draggable`](https://create.roblox.com/docs/reference/engine/classes/GuiObject#Draggable) but with more consistency and with up-to-date code.

Example Usage:
```luau
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DraggableGui = require(ReplicatedStorage.DraggableGui)

local draggedGui = script.Parent
local dragInitiator = draggedGui.DragInitiator

DraggableGui.MakeGuiDraggable(draggedGui, dragInitiator, Vector2.new(100, 100))
```

Created by [Zalthen](https://www.roblox.com/users/1377987741/profile)
