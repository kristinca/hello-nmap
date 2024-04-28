local nmap_cmd= "nmap -Pn -6 ipv6"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)