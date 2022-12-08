-- Code provided by Fatboy =) Thank you very much.

local expect = require "cc.expect".expect

---@alias SearchType
---| 'files' # Search only for files.
---| 'folders' # Search only for folders.

--- Find a file (or files) with an ignore list. Note that this uses pattern matching for both the name and ignore list, as well as fs.find's own wildcard matching for the name.
---@param name string The file to match for.
---@param ignore_list table? The list of items to ignore.
---@param search_type SearchType? Whether to search for files or folders only (or both, if left nil).
---@return table

local function search(name, ignore_list, search_type)
  expect(1, name, "string")
  expect(2, ignore_list, "table", "nil")
  expect(3, search_type, "string", "nil")
  if search_type and search_type ~= "files" and search_type ~= "folders" then
    error("Bad argument #3: Expected 'files' or 'folders'", 2)
  end
  ignore_list = ignore_list or {}

  -- initialize the search string
  local search_str = name

  --- This function extends the search by prepending "*/"
  local function extend_search()
    search_str = string.format("*/%s", search_str)
  end

  --- The values that have been found to match.
  local found = {}

  repeat
    --- Current items from the search string.
    ---@type table
    local items = fs.find(search_str)
    extend_search()

    -- if there is anything in this folder that matches our search string
    if #items > 0 then
      -- check each item...
      for _, item in ipairs(items) do
        local ignored = false

        -- if it matches any values in our ignore list, ignore it.
        for _, ignore in ipairs(ignore_list) do
          if item:match(ignore) then
            ignored = true
            break
          end
        end

        -- if this is a directory
        if fs.isDir(item) then
          -- and we are looking for files only
          if search_type and search_type ~= "folders" then
            -- ignore this
            ignored = true
          end
        else
          -- if it's not a directory and we are looking for directories only
          if search_type and search_type ~= "files" then
            -- ignore this
            ignored = true
          end
        end

        -- If we don't want to ignore this (it doesn't match any ignores in the ignore list, and it matches our search pattern):
        if not ignored then
          -- Add it to our found list
          found[#found + 1] = item
        end
      end
    end
  until #fs.find(fs.getDir(search_str)) == 0 -- If there are no more folders to search at this depth, exit the loop.

  return found
end

return search