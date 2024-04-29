local nmap_cmd= "nmap -Pn scanme.nmap.org/24"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)