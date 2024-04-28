local nmap_cmd= "nmap -Pn -d ipv4"
-- use -dd for greater effect
-- local nmap_cmd= "nmap -Pn -dd ipv4"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)