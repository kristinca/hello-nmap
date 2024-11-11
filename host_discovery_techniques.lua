local nmap_cmd= "nmap -sn -PE -R -v microsoft.com ebay.com citibank.com google.com slashdot.org yahoo.com --unprivileged"
local handle = assert(io.popen(nmap_cmd, 'r'))
local result = handle:read('*a')
handle:close()

print(result)