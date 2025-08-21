local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
if RunService:IsServer() then return end

local mod = {}

function mod.MakeGuiDraggable(draggedGui: GuiObject, dragInitiator: GuiObject)
	if typeof(dragInitiator) ~= "Instance" or not dragInitiator:IsA("GuiObject") then
		warn("Passed DragInitiator is not a GuiObject! Falling back to DraggedGui")
		dragInitiator = draggedGui
	end
	
	local isDragging = false
	local dragStart = nil
	local startPos = nil
	
	local function Update(input)
		local delta = input.Position - dragStart
		draggedGui.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
	
	local initiateDragEnv = dragInitiator.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			isDragging = true
			dragStart = input.Position
			startPos = draggedGui.Position
		end
	end)
	
	local inputChangedEnv = UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
			Update(input)
		end
	end)
	
	local inputEndedEnv = UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and isDragging then
			isDragging = false
		end
	end)
	
	dragInitiator.Destroying:Connect(function()
		initiateDragEnv:Disconnect()
		inputChangedEnv:Disconnect()
		inputEndedEnv:Disconnect()
	end)
end

return mod
