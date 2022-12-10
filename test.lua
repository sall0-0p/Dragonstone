local githubPath = "https://raw.githubusercontent.com/sall0-0p/UwUntuCC/"
local treePath = "https://api.github.com/repos/sall0-0p/UwUntuCC/git/trees"

local function createUwuntuTree(page, branch, dirName)
    dirName = dirName or ""
    local tree = {}
    local request, err = http.get(page, _G._GIT_API_KEY and {Authorization = "token ".._G._GIT_API_KEY})
    print("Creating file tree for "..(dirName~="" and "root/"..dirName or "root"))
    if(request==nil)then error("API rate limit exceeded. It will be available again in one hour.") end
    for _,v in pairs(textutils.unserialiseJSON(request.readAll()).tree)do
        if(v.type=="blob")then
            table.insert(tree, {name = v.path, path=fs.combine(dirName, v.path), url=githubPath..(branch or "master")..fs.combine(dirName, v.path), size=v.size})
        elseif(v.type=="tree")then
            tree[v.path] = createUwuntuTree(v.url, (branch or "master"), fs.combine(dirName, v.path))
        end
    end
    return tree
end

local tree = createUwuntuTree(treePath.."/master", "master")

for k,v in pairs(tree)do
    local request = http.get("https://raw.githubusercontent.com/sall0-0p/UwUntuCC/dev/test.lua")
    local dir = fs.makeDir(v, "w")
    dir.write(request)
    request.close()
end