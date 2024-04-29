local nmap_cmd= "nmap -Pn -6 2001:800:40:2a03::3"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)