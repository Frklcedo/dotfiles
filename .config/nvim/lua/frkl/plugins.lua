local sp = {
	require("frkl.essentials"),
	require("frkl.editor"),
	require("frkl.completion"),
	require("frkl.lsp"),
	require("frkl.notes"),
	require("frkl.packages"),
}

local specs = {}
local config = {}
for _, s in ipairs(sp) do
	if s.setup then
		table.insert(config, s.setup)
	end
	if s.specs then
		s = s.specs
	end
	vim.list_extend(specs, s)
end

vim.pack.add(specs)

for _, setup in ipairs(config) do
	setup()
end
