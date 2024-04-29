-- scan the whole private 10 range except anything starting with 10.6
local nmap_cmd= "nmap -Pn 10.0.0.0/8 --exclude 10.6.0.0/16"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)