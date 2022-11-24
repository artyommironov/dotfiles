function file_exists(name)
  local f = io.open(name,"r")
  local exists = f ~= nil
  if exists then io.close(f) end
  return exists
end

function read_all(file)
  local f = assert(io.open(file, "rb"))
  local content = f:read("*all")
  f:close()
  return content
end

function run(command)
  local f = io.popen(command)
  local result = f:read("*a")
  f:close()
  return result
end

function main()
  fileName = mp.get_property("filename")
  filePath = mp.get_property("path")
  realFilePath = run("realpath \"" .. filePath .. "\"")
  lrcFileName = fileName:gsub("%.[^.]+$", ".txt")
  lrcPath = realFilePath:gsub("%/[^/]+$", "/lyrics/" .. lrcFileName)
  if file_exists(lrcPath) then
    mp.commandv("print-text", "")
    mp.commandv("print-text", read_all(lrcPath))
  end
end

mp.register_event("file-loaded", main)
