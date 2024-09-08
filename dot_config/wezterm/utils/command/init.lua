local module = {}

function module.AppendCommandArgs(...)
	local args = {}
	for _, arg in ipairs({ ... }) do
		table.insert(args, arg)
	end
	return args
end

function module.ZshCommands(...)
	return module.AppendCommandArgs("zsh", "--login", ...)
end

return module
