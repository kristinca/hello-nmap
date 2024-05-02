local nmap_command = "nmap -Pn -T4 --traceroute www.example.com"
local handle = assert(io.popen(nmap_command, 'r'))
local result = handle:read('*a')
handle:close()

print(result)