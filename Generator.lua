math.randomseed(tick());
print'lig: part 2'
local Seed = Random.new();
local RS = game:GetService('ReplicatedStorage');

local Utilities = require(script.Parent.Utilities);
local FinishedGeneratingEvent = Instance.new("BindableEvent");
local RotatedRegion3 = require(script.Parent:WaitForChild("RotatedRegion3"));


--//Fragmentation Function

function fishRandomPartFromRestriction(Set, Restrictions)
	Restrictions = Restrictions or {};
	
	local NewSet = {};
	for i, v in pairs(Set) do
		if not ( table.find(Restrictions, v.Name) or Restrictions[v.Name] ) then
			NewSet[#NewSet+1] = v;
		end
	end
	return NewSet[Seed:NextInteger(1, #NewSet)] --:Clone()
end

function Shell(StartingPiece, MaxPieceCount, MinPieceCount, Parent, PieceSet, StartCFrame, Restrictions, Addends)
	warn'abcasc'
	local Restrictions = Restrictions or {};
	local Parts = {};
	local Statistics = {};
	local FilledRestrictions = {};
	local Pieces = PieceSet;
	local Children = PieceSet:GetChildren();
	local RandomPiece = StartingPiece:Clone() or fishRandomPartFromRestriction(Children, {"End"}):Clone();
	RandomPiece.Name = "Start";
	Parts[#Parts+1] = {RandomPiece, RotatedRegion3.FromPart(RandomPiece.Hitbox)};
	RandomPiece.Parent = Parent;
	RandomPiece:SetPrimaryPartCFrame(StartCFrame or RandomPiece:GetPrimaryPartCFrame())
	
	if (Restrictions[RandomPiece.Name] and Restrictions[RandomPiece.Name] <= 0) then
		FilledRestrictions[RandomPiece.Name] = true;
	elseif Restrictions[RandomPiece.Name] then
		Restrictions[RandomPiece.Name] = Restrictions[RandomPiece.Name] - 1;
	end
	
	local function Fragment(RandomPiece, SnapPiece)
		
		for i, v in pairs(Restrictions) do
			if (v == 0) then
				FilledRestrictions[i] = true;
			end
		end
		
		game:GetService('RunService').Heartbeat:Wait();
		if (MaxPieceCount <= 0) then
			FinishedGeneratingEvent:Fire();
			return;
		end
		
		MaxPieceCount = MaxPieceCount-1;
		for i, v in pairs(RandomPiece:GetChildren()) do
			
			if (v.Name:lower():match("snap%d+$")) then
				local Piece = fishRandomPartFromRestriction(Children, FilledRestrictions) --  Children[Seed:NextInteger(1, #Children)]:Clone();
				if (not Piece) then return nil end;
				Piece = Piece:Clone();
				Piece:SetPrimaryPartCFrame(v.CFrame)
				Piece.Hitbox.Size = Piece.Hitbox.Size - Vector3.new(0, math.random(0, 5) + math.random(), 0)
				local isColliding;
				local NewR3 = RotatedRegion3.FromPart(Piece.Hitbox);
				for i, v in pairs(Parts) do
					if (#NewR3:FindPartsInRegion3WithWhiteList({v[1].Hitbox}, 1) > 0) or (#v[2]:FindPartsInRegion3WithWhiteList({Piece.Hitbox}, 1) > 0) then
						isColliding = true;
					end
				end
				
				if (not isColliding) then
					local LinkedTo = Instance.new("ObjectValue", v);
					LinkedTo.Name = "LinkedTo";
					LinkedTo.Value = SnapPiece;
					
					local OtherLinkedTo = Instance.new("ObjectValue", SnapPiece)
					OtherLinkedTo.Name = "LinkedTo";
					OtherLinkedTo.Value = v;
					Parts[#Parts+1] = {Piece, NewR3};
					Piece.Hitbox.BrickColor = BrickColor.Random();
					if (Restrictions[Piece.Name] and Restrictions[Piece.Name] <= 0) then
						FilledRestrictions[Piece.Name] = true;
					elseif Restrictions[Piece.Name] then
						Restrictions[Piece.Name] = Restrictions[Piece.Name] - 1;
					end
					Statistics[Piece.Name] = Statistics[Piece.Name] and Statistics[Piece.Name]+1 or 1;
					Piece.Name = Piece.Name..#Parts;
					Piece.Parent = Parent;
					(Fragment)(Piece, v, MaxPieceCount);
				else
					Piece:Destroy();
					RandomPiece[v.Name.."Wall"].CanCollide = true;
					RandomPiece[v.Name.."Wall"].Transparency = 0;
				end
			end
			
		end
		return 0;
	end;
		
	
	(Fragment)(RandomPiece, RandomPiece.Snap1);
	
	local Unlinked = {};
	
	for i, v in pairs(Parent:GetDescendants()) do
		if (not v:FindFirstChild("LinkedTo") and v.Name:match('Snap%d+$')) then
			Unlinked[#Unlinked+1] = v;
		end
	end
	
	Utilities:Shuffle(Unlinked); --dataloss shouldn't occur i hope ._.
	
	repeat game:GetService('RunService').Heartbeat:Wait()
		for IndexName, Amount in pairs(Addends or {}) do --structure: [structureTitle] = amount]. fuzzy, use quota and restriction to make sure there's only one.
			if (#Unlinked <= 0) then return Parts, Statistics, Addends end
			if (not tonumber(Amount)) then return error("invalid amount for index "..IndexName..".");  end
			if (Amount <= 0) then Addends[IndexName] = nil; continue end;
			local ChosenUnlink_INT = Seed:NextInteger(1, #Unlinked)
			local ChosenUnlink = Unlinked[ChosenUnlink_INT];
			
			local Piece = Pieces:FindFirstChild(IndexName);
			if (not Piece) then continue end;
			
			Piece = Piece:Clone();
			Piece:SetPrimaryPartCFrame(ChosenUnlink.CFrame)
			Piece.Hitbox.Size = Piece.Hitbox.Size - Vector3.new(0, math.random(0, 5) + math.random(), 0)
			local isColliding;
			local NewR3 = RotatedRegion3.FromPart(Piece.Hitbox);
			for i, v in pairs(Parts) do
				if (#NewR3:FindPartsInRegion3WithWhiteList({v[1].Hitbox}, 1) > 0) or (#v[2]:FindPartsInRegion3WithWhiteList({Piece.Hitbox}, 1) > 0) then
					isColliding = true;
				end
			end
			
			if (not isColliding) then 
				local LinkedTo = Instance.new("ObjectValue", Piece);
				LinkedTo.Name = "LinkedTo";
				LinkedTo.Value = ChosenUnlink;
				
				local OtherLinkedTo = Instance.new("ObjectValue", ChosenUnlink)
				OtherLinkedTo.Name = "LinkedTo";
				OtherLinkedTo.Value = Piece;
				Piece.Hitbox.BrickColor = BrickColor.Random();
				if (Restrictions[Piece.Name] and Restrictions[Piece.Name] <= 0) then
					FilledRestrictions[Piece.Name] = true;
				elseif Restrictions[Piece.Name] then
					Restrictions[Piece.Name] = Restrictions[Piece.Name] - 1;
				end
				Statistics[Piece.Name] = Statistics[Piece.Name] and Statistics[Piece.Name]+1 or 1;
				Piece.Name = Piece.Name..#Parts;
				Piece.Parent = Parent;
				
				Parts[#Parts+1] = {Piece, NewR3};
				table.remove(Unlinked, ChosenUnlink_INT);
				Addends[IndexName] = Addends[IndexName] - 1
			else
				Piece:Destroy();
			end		
			
		end
	until (Utilities:Length(Addends) <= 0) or (Utilities:Length(Unlinked) <= 0)
	
	return Parts, Statistics, Addends;
end

return Shell;
