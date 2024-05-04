-- in Lua, we have local and global vars
-- don't use global
local nmap_command = "nmap scanme.nmap.org ipv4"

-- some_result = assert(some_function(), "Error: some_function failed.")
-- io.popen -> function in the Lua std lib that opens a process and returns a file handle, 
--             used for executing external commands and capturing their output
--             io.popen(some_command, mode), mode: 'r', 'w', ok this is like python
local handle = assert(io.popen(nmap_command, 'r'))
local result = handle:read('*a')
handle:close()

print(result)
