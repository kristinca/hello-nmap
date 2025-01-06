local handle = io.popen("ipconfig /all")
if not handle then
    print("Failed to run ipconfig ._. ")
    return
end

local result = handle:read("*a")
handle:close()

if result == "" then
    print("No output received. :/ Make sure you are running this script on Windows")
    return
end

print(result)