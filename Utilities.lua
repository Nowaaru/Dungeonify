local Utilities = {};

function Utilities:Find(table, string)
	
	for i, v in pairs(table) do
		if (i:lower() == string:lower()) then
			return v;
		end
	end
	
	return nil;
end;

function Utilities:Copy(orig)
	print'copy'
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[self:Copy(orig_key)] = self:Copy(orig_value)
        end
        setmetatable(copy, self:Copy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
	end
	print'done'
    return copy
end

function Utilities:Length(table)
	local length = 0;
	for i, v in pairs(table) do
		length = length + 1;
	end
	return length;
end


function Utilities:Shuffle(tabl)
    for i=1,#tabl-1 do
        local ran = math.random(i,#tabl)
        tabl[i],tabl[ran] = tabl[ran],tabl[i]
    end
end
return Utilities;