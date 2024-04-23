return (function(Bucket)

    function Bucket.new(array)

    	local self = setmetatable( {}, Bucket )
    	local length = 0

            
    	if array then
    		for i, v in pairs(array) do
    			local stuff
    			local vl = 0
    			local str = tostring(v)
    
    			if type(v) == "table" then for _ in pairs(v) do vl = vl + 1 end end
    
    			if string.sub(str,1,string.len("(("))=="((" then
    				stuff = {
    					Key = i,
    					Value = v,
    					Type = "uni"
    				}
    
    			elseif type(v) == "table" and vl == 1 then
    				for Key, Value in pairs(v) do
    					stuff = {
    						Key = Key,
    						Value = Value,
    						Type = "pair"
    					}
    					break
    				end
    			else
    				stuff = {
    					Key = i,
    					Value = v,
    					Type = "uni"
    				}
    			end
    
    			self[length+1] = stuff
    
    			length = length + 1
    		end
    	end
    
    	return self
    end

        
end)
