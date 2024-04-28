local nmap_cmd= "nmap -Pn -D <decoy-IP> ipv4"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)