local nmap_cmd= "nmap -Pn nmap scanme.nmap.org/32"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)