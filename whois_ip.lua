local nmap_command = "nmap -Pn --script whois-ip example.com"
local handle = assert(io.popen(nmap_command, 'r'))
local result = handle:read('*a')
handle:close()

print(result)