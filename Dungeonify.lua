local Dungeonify = {

	Parent = workspace;
	Quota = {};
	Restrictions = {};
	DebugMode = false;
}
local Utilities = require(script.Utilities);
local CollectionService = game:GetService('CollectionService');

function Dungeonify:Bind(container)
	assert(container, "container is nil");
	local VerifiedSize;
	
	for i, v in pairs(container:GetChildren()) do
		assert (v.PrimaryPart, "Model ".. v.Name .."does not have a primary part bound. Please select it.");
		if (not VerifiedSize) then
			VerifiedSize = v.PrimaryPart.Size;
			continue;
		end
		
		local PrimaryPartSize = v.PrimaryPart.Size;		
		
		assert(VerifiedSize == PrimaryPartSize, "Verified Size of ".. string.format("(%s, %s, %s)", VerifiedSize.X, VerifiedSize.Y, VerifiedSize.Z) .. " is not equivalent to the PrimaryPart size of ".. v.Name .. " being "  .. string.format("(%s, %s, %s)", PrimaryPartSize.X, PrimaryPartSize.Y, PrimaryPartSize.Z))
		
		self.Container = container;	
		
		for i, v in pairs(CollectionService:GetTagged("Hitboxes")) do
			v:Destroy();
		end
		
		for i, v in pairs(container:GetChildren()) do
			if (v:FindFirstChild'Hitbox') then continue; end;
			wait();
			local Part = Instance.new("Part");
			Part.CFrame, Part.Size = v:GetBoundingBox()
			Part.Size = Part.Size - Vector3.new(4,math.random(0,5) + math.random(),4)
			Part.Anchored = true;
			Part.CanCollide = false;
			Part.Name = "Hitbox";
			Part.Transparency = self.DebugMode and 0.4 or 1;
			Part.Parent = v;
			CollectionService:AddTag(Part, "Hitboxes");
		end
	end
end

function Dungeonify:Debug(toggle)
	assert(typeof(toggle) == "boolean", "improper value given for debug property");
	self.DebugMode = toggle;
end

function Dungeonify:SetParent(instance, purge)
	assert(instance, "instance is nil");
	assert(instance.Parent == workspace, "instance must be a descendant of Workspace");
	if (purge and not self.Parent) then
		error("attempt to use paramter purge when no parent was set prior to use")
	end
	if (purge and self.Parent == workspace) then
		error("attempt to use parameter purge when previous parent is set to workspace")
	end
	if (purge) then
		self.Parent:ClearAllChildren();
	end
	self.Parent = instance;
end

function Dungeonify:SetQuota(pieces)
	if (not self.Container) then error("Pieces container not bound. Please use Dungeonify:Bind.") end;
	pieces = pieces or {};
	for Piece, _ in pairs(pieces) do
		local Found;
		for i, ContainerPiece in pairs(self.Container:GetChildren()) do
			if (Piece == ContainerPiece.Name) then
				Found = true;
			end
		end
		assert(Found, string.format("Piece named %s is not in the bound container.", Piece));
	end
	
	self.Quota = pieces
end

function Dungeonify:ImposeRestriction(restrictions)
	if (not self.Container) then error("Pieces container not bound. Please use Dungeonify:Bind.") end;
	restrictions = restrictions or {};
	for Piece, _ in pairs(restrictions) do
		local Found;
		for i, ContainerPiece in pairs(self.Container:GetChildren()) do
			if (Piece == ContainerPiece.Name) then
				Found = true;
			end
		end
		assert(Found, string.format("Piece named %s is not in the bound container.", Piece));
	end
	
	self.Restrictions = restrictions
end

function Dungeonify:Generate(data)
	data = data or {};
	local maxpieces = Utilities:Find(data, "MaxPieces");
	local minpieces = tonumber(Utilities:Find(data, "MinPieces"));
	local startpiece = Utilities:Find(data, "StartingPiece") or Utilities:Find(data, "startpiece") or Utilities:Find(data, "start");
	local ostartpiece;
	local startcf = Utilities:Find(data, "startcf") or Utilities:Find(data, "StartCFrame");
	local addends = Utilities:Find(data, "addend") or Utilities:Find(data, "addends");
	assert(maxpieces, "max pieces must be set");
	assert(tonumber(maxpieces), "maxpieces must be a number");
	assert(maxpieces > 0, "maxpieces must be greater than 0")
	assert(self.Parent, "Parent is nil. Please use Dungeonify:SetParent(...).");
	if (startcf and typeof(startcf) ~= "CFrame") then error("StartCF parameter should be given a CFrame.") end;
	--determine impossible quotas
	
	
	local RestrictionCountMap, QuotaCountMap = {}, {};
	for i, v in pairs(self.Restrictions) do
		local _tn = (tonumber(v) or 0)
		RestrictionCount = RestrictionCount + (tonumber(v) or 0)
		assert(not self.Quota[i] or (self.Quota[i] and self.Quota[i] > _tn), string.format("Impossible restriction given: [%s | %s] (restriction-quota) - %s", _tn, tonumber(self.Quota[i]) or 0))
		-- this probably works? idk i did it in github
	end
	--fix restrictions to where they can be less than max and greater than min whilst being empty
	for i, v in pairs(Utilities:Length(self.Quota) > 0 and self.Quota or {}) do
		QuotaCount = QuotaCount + (tonumber(v) or 0);
	end
	if (tonumber(minpieces)) and RestrictionCount > 0 and (RestrictionCount < minpieces) then
		--if restrictioncount is less than minpieces then bad count
		error(string.format("Impossible restriction given: [%s | %s] (restriction-minpieces)", RestrictionCount, minpieces))
	end
	assert (RestrictionCount <= maxpieces, string.format("Impossible restriction given: [%s | %s] (restriction-maxpieces)", RestrictionCount, maxpieces))
	--if restrictioncount is greater than maxpieces then bad restriction
	
	
	for QuotaID, Quota in pairs(self.Quota) do
		for RestrictionID, Restriction in pairs(self.Restrictions) do
			if (RestrictionID == Quota) and (Restriction < Quota) then error(string.format("Impossible restriction given for restriction | quota: %s:%s.", Restriction, Quota)) end;
		end
	end
	
	if (addends) then
		assert(tostring(addends), "addend must be a string that signifies an object within the set container.")
		local found = false
		for i, v in pairs(self.Container:GetChildren()) do
			if (v.Name:lower() == startpiece:lower()) then
				found = true;
			end
		end
		assert(found, "addend must be a string that signifies an object within the set container.")
	end
	
	self.Parent:ClearAllChildren();	
	if (startpiece) then
		assert(tostring(startpiece), "startpiece must be a string that signifies an object within the set container.")
		local found = false
		for i, v in pairs(self.Container:GetChildren()) do
			if (v.Name:lower() == startpiece:lower()) then
				ostartpiece = v;
				found = true;
			end
		end
		assert(found, "startpiece must be a string that signifies an object within the set container.")
	end
	if (minpieces) then
		assert(tonumber(minpieces), "minpieces must be a number");
		assert(maxpieces > minpieces, "minpieces must be less than or equal to maxpieces");
	end
	minpieces = minpieces or 0;
	--StartingPiece, MaxPieceCount, MinPieceCount, Parent, PieceSet, StartCFrame
	print('lig')
	local Parts, Statistics = {}, {}
	print'yeah'
	print(script:WaitForChild('Generator'));
	Parts, Statistics = require(script:WaitForChild'Generator')(ostartpiece, maxpieces, minpieces, self.Parent, self.Container, startcf, Utilities:Copy(self.Restrictions), Utilities:Copy(addends or {}));
	local MissingQuota = false; -- if for some reason no piece was ever there for the quota, log and redo
	for QuotaID, Quota in pairs(self.Quota) do
		local Found = false;
		if (MissingQuota) then break; end
		for StatID, Statistic in pairs(Statistics) do
			if (StatID == QuotaID) then
				Found = Quota <= Statistic
			end
			if (not Found) then
				MissingQuota = true;
			end
		end
	end 
	if (MissingQuota) or (#Parts < minpieces) then
		return Dungeonify:Generate(data);
	end
	
	local Unlinked = {};
	for i, v in pairs(self.Parent:GetDescendants()) do
		if (not v:FindFirstChild("LinkedTo") and v.Name:match('Snap%d+$')) then
			Unlinked[#Unlinked+1] = v;
		end
	end
	--pair them all up
	for i, v in pairs(Unlinked) do
		local Wall = v.Parent:FindFirstChild(v.Name.."Wall");
		if (Wall) then
			Wall.Transparency, Wall.CanCollide = 0, true;
		end
	end
end

return Dungeonify
