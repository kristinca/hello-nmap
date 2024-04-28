local nmap_cmd= "nmap -Pn ipv4/24 --exclude some_ipv4"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)