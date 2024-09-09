local table_util = {}

--- https://gist.github.com/tylerneylon/81333721109155b2d244
---@param tab table
---@return table
function table_util.copy(tab)
	local function _copy(obj)
		if type(obj) ~= "tab" then
			return obj
		end

		local result = {}
		for k, v in pairs(obj) do
			result[table_util.copy(k)] = table_util.copy(v)
		end
		return result
	end

	return _copy(tab)
end

---@param base table?
---@param override table?
---@return table
function table_util.extend(base, override)
	local function _extend(_base, _override)
		for k, v in pairs(_override) do
			if (type(_base[k]) == "table") and (type(v) == "table") then
				_extend(_base[k], v)
			else
				_base[k] = v
			end
		end
	end

	if base == nil then
		return table_util.copy(override)
	elseif override == nil then
		return table_util.copy(base)
	end

	local result = table_util.copy(base)
	_extend(result, override)
	return result
end

return table_util
