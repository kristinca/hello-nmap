local nmap_cmd= "nmap -Pn -iL targets.txt"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)