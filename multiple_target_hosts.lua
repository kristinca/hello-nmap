local nmap_cmd= "nmap -Pn -v ipv4-1 ipv4-2"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)