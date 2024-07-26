local M = {}

M.find_ancestor_with_file = function(file_name)
  local function file_exists(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == 'file'
  end

  local function get_parent_dir(path)
    local parent = vim.fn.fnamemodify(path, ":h")
    if parent == path then
      return nil
    else
      return parent
    end
  end

  local function is_workspace_dir(dir)
    return dir == vim.fn.getcwd()
  end

  local function find_file_in_ancestors(start_path, file_name)
    local dir = start_path
    while dir do
      if file_exists(dir .. '/' .. file_name) then
        return dir
      end
      if is_workspace_dir(dir) then
        break
      end
      dir = get_parent_dir(dir)
    end
    return nil
  end

  local start_path = vim.fn.expand("%:p:h")
  return find_file_in_ancestors(start_path, file_name)
end

M.get_file_name = function(url)
  return url:match("^.+/(.+)$")
end

M.get_file_extension = function(url)
  return url:match("^.+%.([^%.]+)$")
end

M.read_and_parse_json_file = function (file_path)
    local file = io.open(file_path, "r")
    if not file then
        print("Failed to open file: " .. file_path)
        return nil
    end

    local content = file:read("*a")
    file:close()

    local success, result = pcall(vim.fn.json_decode, content)
    if not success then
        print("Error while parsing JSON: " .. result)
        return nil
    end

    return result
end

M.table_contains_by_attribute = function (tbl, key, value)
    for _, v in pairs(tbl) do
        if v[key] == value then
            return true
        end
    end
    return false
end

return M
