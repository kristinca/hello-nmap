local nmap_cmd= "nmap -Pn -v -p 22, 80,443 ipv4"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)