local nmap_cmd= "nmap -Pn -p 80 -d -packet-trace ipv4"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)