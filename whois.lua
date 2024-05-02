local nmap_command = "nmap -Pn --script whois* -sn 93.184.215.14"
local handle = assert(io.popen(nmap_command, 'r'))
local result = handle:read('*a')
handle:close()

print(result)