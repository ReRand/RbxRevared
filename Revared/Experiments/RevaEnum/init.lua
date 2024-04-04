--[[

local RevaEnum = Revared:GetModule("RevaEnum");
local PlayerControls = Revared:GetModule("PlayerControls");


RevaEnum.new("MoveDirection", {
    "Left", "Right",
    "Forward", "Backward", 
    "Up", "Down",
});


local md = PlayerControls:GetMoveDirection(player);


print(md.Directions); // { Enum.MoveDirection.Forward, Enum.MoveDirection.Right };


if md:MovingIn(Enum.MoveDirection.Forward) and md:VelocityIn(Enum.MoveDirection.Forward) > 25 then
 -- do stuff
end

]]



local RevaEnum = {};
RevaEnum.__index = RevaEnum;


local RevaEnumItem = {};
RevaEnumItem.__index = RevaEnumItem;


-- enum item
function RevaEnumItem.new(name: string, value: number, et: RevaEnum)
	local self = setmetatable({
		Name = name,
		Value = value,
		EnumType = et
	}, RevaEnumItem);

	return self;
end


-- enum main
function RevaEnum.new(name, items)
	local self = setmetatable({
		Name = name,
		Items = items,
		Me = nil
	}, RevaEnum);

	Enum[name] = self;
	self.Me = Enum[name];

	for itemValue, itemName in ipairs(self.Items) do
		self.Items[i] = RevaEnumItem.new(itemName, itemValue, self);
	end

	return self;
end


function RevaEnum:GetEnumItems()
	return self.Items;
end


return RevaEnum;
