local nmap_cmd= "nmap -Pn scanme.nmap.org"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)