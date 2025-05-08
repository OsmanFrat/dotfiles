local utils = require 'mp.utils'

function display_error()
  mp.msg.warn("Subtitle download failed: ")
  mp.osd_message("Subtitle download failed")
end

-- ost download --file Dumbo.1941.mp4
function load_sub_with_hash()
  local path = mp.get_property("path")
  local dir, filename = utils.split_path(path)
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


function get_current_directory()
    local path = mp.get_property("path", "")
    if path == "" then return nil end  -- Eğer bir dosya oynatılmıyorsa
    return utils.split_path(path)
end

function find_all_srt_files()
    local dir = get_current_directory()
    if not dir then
        mp.msg.warn("Şu an bir dizin içinde değil!")
        return {}
    end

    local files = utils.readdir(dir, "files") or {}
    local srt_files = {}

    for _, file in ipairs(files) do
        if file:match("%.srt$") then
            table.insert(srt_files, file)
        end
    end

    return srt_files
end

function add_all_subs()
  local srt_files = find_all_srt_files()
  mp.osd_message("Starting to adding all subtitles")

  if #srt_files > 0 then
    for i = 1,#srt_files,1
    do
      mp.commandv("sub-add", srt_files[i], "auto")  -- İlk .srt dosyasını yükle
    end
  end
end


-- ost download --file Dumbo.1941.mp4
function load_all_subs()
  local path = mp.get_property("path")
  local dir = utils.split_path(path)
  local filename = string.gsub(dir, "%.%w+$", "")
  local srt_path = string.gsub(path, "%.%w+$", ".srt")
  -- local downloaded_sub = os.execute("cd '"..dir.."' && ozusub")
  mp.osd_message("Opening subtitle searcher...")

  -- if os.execute("cd '"..dir.."' && ost download --file "..filename.." && mv "..sub_name..".srt '"..srt_path.."'") then
  if os.execute("cd '"..dir.."' && ozusub -m "..filename.."") then
      add_all_subs()
      mp.msg.warn("Subtitle download succeeded")
      mp.osd_message("Subtitle download succeeded: \n" .. srt_path .. "", 5)
      else
        display_error()
  end
end


-- mp.add_key_binding("a", "sub_downloader_plugin", load_sub_with_hash)
mp.add_key_binding("a", "sub_downloader_plugin", load_all_subs)
