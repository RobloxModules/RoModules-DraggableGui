local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local mod = {}

function mod.MakeGuiDraggable(draggedGui: GuiObject, dragInitiator: GuiObject)
	if RunService:IsServer() then return end
	
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
	
	local initiateDragEnv
	initiateDragEnv = dragInitiator.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			
			isDragging = true
			dragStart = input.Position
			startPos = draggedGui.Position
			
			local changedEnv
			changedEnv = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					isDragging = false
					changedEnv:Disconnect()
				end
			end)
		end
	end)
	
	local inputChangedEnv
	inputChangedEnv = UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
			Update(input)
		end
	end)
	
	dragInitiator.Destroying:Connect(function()
		initiateDragEnv:Disconnect()
		inputChangedEnv:Disconnect()
	end)
end

return mod
