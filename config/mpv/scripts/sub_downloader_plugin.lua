local utils = require 'mp.utils'

-- Basit hata bildirimi
local function display_error()
  mp.msg.warn("Subtitle download failed.")
  mp.osd_message("Subtitle download failed", 3)
end

-- Tüm .srt dosyalarını mevcut klasörden bulur
local function find_all_srt_files(dir)
  local files = utils.readdir(dir, "files") or {}
  local srt_files = {}

  for _, file in ipairs(files) do
    if file:match("%.srt$") then
      table.insert(srt_files, utils.join_path(dir, file))
    end
  end

  return srt_files
end

-- Tüm altyazı dosyalarını ekler
local function add_all_subs(dir)
  local srt_files = find_all_srt_files(dir)

  if #srt_files == 0 then
    mp.osd_message("No subtitles found.", 3)
    return
  end

  for _, sub_file in ipairs(srt_files) do
    mp.commandv("sub-add", sub_file, "auto")
  end

  mp.msg.info("All subtitles added.")
  mp.osd_message("Subtitles loaded: " .. tostring(#srt_files), 3)
end

-- Asıl fonksiyon: ozusub ile indir, sonra ekle
local function load_all_subs()
  local path = mp.get_property("path")
  if not path then
    mp.osd_message("No file loaded.", 2)
    return
  end

  local dir, filename = utils.split_path(path)

  mp.osd_message("Downloading subtitles...", 2)
  local command = "cd '" .. dir .. "' && ozusub -m \"" .. filename .. "\""
  -- file name test
  mp.osd_message(filename)
  local result = os.execute(command)

  if result == 0 then
    mp.osd_message("Download complete. Loading subtitles...", 2)
    add_all_subs(dir)
  else
    display_error()
  end
end

-- "a" tuşuna basınca `load_all_subs()` çalışsın
mp.add_key_binding("a", "sub_downloader_plugin", load_all_subs)

