local M = {}

local cache_file = vim.fs.joinpath(vim.fn.stdpath("cache"), "laravel-lsp-path")

local function run(args)
	local result = vim.system(args, { text = true }):wait()

	if result.code ~= 0 then
		error(result.stderr ~= "" and result.stderr or result.stdout)
	end

	return vim.trim(result.stdout)
end

local function composer()
	local executable = vim.fn.exepath("composer")

	if executable == "" then
		error("Laravel LSP: Composer wurde nicht in PATH gefunden")
	end

	return executable
end

local function cached_bin()
	local file = io.open(cache_file, "r")

	if not file then
		return
	end

	local executable = vim.trim(file:read("*a"))
	file:close()

	if executable ~= "" and vim.uv.fs_stat(executable) then
		return executable
	end
end

local function cache_bin(executable)
	local file = assert(io.open(cache_file, "w"))
	file:write(executable)
	file:close()
end

local function find_bin()
	local dir = run({
		composer(),
		"global",
		"config",
		"bin-dir",
		"--absolute",
	})

	local names = vim.fn.has("win32") == 1 and { "laravel-lst.bat", "laravel-lsp.cmd", "laravel-lsp" }
		or { "laravel-lsp" }

	for _, name in ipairs(names) do
		local executable = vim.fs.joinpath(dir, name)

		if vim.uv.fs_stat(executable) then
			cache_bin(executable)
			return executable
		end
	end
end

function M.ensure()
	local executable = cached_bin() or find_bin()

	if executable then
		return executable
	end

	vim.notify("Laravel LSP wird installiert ...", vim.log.levels.INFO)

	run({
		composer(),
		"global",
		"require",
		"laravel/lsp",
		"--no-interaction",
		"--no-progress",
	})

	executable = find_bin()

	if not executable then
		error("Laravel LSP wurde installiert, aber das Binary wurde nicht gefunden")
	end

	return executable
end

function M.update()
	run({
		composer(),
		"global",
		"update",
		"laravel/lsp",
		"--with-all-dependencies",
		"--no-interaction",
		"--no-progress",
	})

	local executable = find_bin()

	if not executable then
		error("Laravel LSP wurde aktualisiert, aber das Binary wurde nicht gefunden")
	end

	print("Laravel LSP aktualisiert")
end

return M
