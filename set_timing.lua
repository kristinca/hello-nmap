local nmap_cmd= "nmap -Pn ipv4"
-- local nmap_cmd= "nmap -Pn ipv4 -T<0-5>, 0 ---> slowest; 5 ---> fastest;"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)