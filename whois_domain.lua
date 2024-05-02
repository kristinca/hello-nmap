local nmap_command = "nmap -Pn --script whois-domain.nse example.com"
local handle = assert(io.popen(nmap_command, 'r'))
local result = handle:read('*a')
handle:close()

print(result)