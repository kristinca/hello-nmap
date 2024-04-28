local nmap_cmd= "nmap -Pn -f ipv4"
-- local nmap_cmd= "nmap -Pn -ff ipv4"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)