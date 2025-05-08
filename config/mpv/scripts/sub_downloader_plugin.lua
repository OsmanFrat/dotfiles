local utils = require 'mp.utils'

function display_error()
  mp.msg.warn("Subtitle download failed: ")
  mp.osd_message("Subtitle download failed")
end

local path = mp.get_property("path")
local dir, filename = utils.split_path(path)
 
-- ost download --file Dumbo.1941.mp4
function load_sub_with_hash()
 local sub_name = string.gsub(filename, "%.%w+$", "")
  local srt_path = string.gsub(path, "%.%w+$", ".srt")
  mp.osd_message("Searching subtitle...")

  if os.execute("cd '"..dir.."' && ost download --file "..filename.." && mv "..sub_name..".srt '"..srt_path.."'") then
      if mp.commandv("sub_add", srt_path) then
        mp.msg.warn("Subtitle download succeeded")
        mp.osd_message("Subtitle download succeeded: \n" .. srt_path .. "", 5)
      end
      else
        display_error()
      end
end


--> seach subtitle by video name and download matched top 5 subitle and add to current mpv video <--

-- search all .srt files in current directory
for dosya in io.popen('ls "' ..path.. '/*.srt"'):lines() do
    print(dosya)
end



-- mp.add_key_binding("a", "sub_downloader_plugin", load_sub_with_hash)

