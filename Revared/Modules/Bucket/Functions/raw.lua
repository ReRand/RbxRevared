return (function(Bucket)

    function Bucket.raw(array)

            
	local self = setmetatable( {}, Bucket )
	local length = 0

            
	if array then
		for i, v in pairs(array) do
			local stuff
			local vl = 0
			local str = tostring(v)

			if type(v) == "table" then for _ in pairs(v) do vl = vl + 1 end end
			
			
			stuff = {
				Key = i,
				Value = v,
				Type = "pair"
			}
			

			self[length+1] = stuff

			length = length + 1
		end
	end

	return self
end

        
end)
