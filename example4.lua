local nmap_cmd= "nmap -Pn 64.13.134.52/24 --exclude scanme.nmap.org,insecure.org"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)