local nmap_cmd= "nmap -sP -T4 www.lwn.net/24"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)