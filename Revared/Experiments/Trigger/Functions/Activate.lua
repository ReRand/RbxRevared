local Revared = require(script.Parent.Parent.Parent.Parent);


return (function(Trigger)

    
	function Trigger:Activate()
    	if (not self.Running) then
    		task.wait(1);
    		self.Running = true;


            local dir = Revared:GetDirectoryOf(self.Part);
    		
    		
    		local function ActivateServer()
    
    			self._outEvent.OnServerEvent:Connect(function(player, outType)
    				if (outType == 1) then
    					self.Entered:Fire(workspace[player.Name], player);
    				else
    					self.Exited:Fire(workspace[player.Name], player);
    				end
    			end)
    
    
    			self._playerHandler.OnServerEvent:Connect(function()
    				self._inEvent:FireAllClients(dir, self.Id, self.Settings);
    			end)
    
    			self._inEvent:FireAllClients(dir, self.Id, self.Settings);
    		end
    		
    		
    		local function ActivateClient()
    			repeat task.wait() until game:IsLoaded();
                local player = game.Players.LocalPlayer;

                self._referOutEvent.Event:Connect(function(outType)
    				if (outType == 1) then
    					self.Entered:Fire(workspace[player.Name], player);
    				else
    					self.Exited:Fire(workspace[player.Name], player);
    				end
    			end)
                

                self._referInEvent:Fire(dir, self.Id, self.Settings);
    			
    			player.CharacterAdded:Connect(function()
    				ActivateClient();
    			end)
    		end
    		
    		
    		if (not pcall(ActivateServer)) then
    			ActivateClient()
    		end
    	else
    		self.Enabled.Value = true;
    	end
    end

    
end)
