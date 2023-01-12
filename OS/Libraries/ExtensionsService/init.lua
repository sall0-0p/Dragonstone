local service = {}
local db = require(".Dragonstone.OS.Libraries.Databaser")

db.setDir("Dragonstone/OS/Libraries/ExtensionsService/DB/")

local extensions = {
    ".mid",
    ".midi",
    ".mp3",
    ".wav",
    ".7z",
    ".pkg",
    ".rar",
    ".tar.gz",
    ".zip",
    ".dat",
    ".db",
    ".dbf",
    ".log",
    ".sql",
    ".xml",
    ".exe",
    ".jar",
    ".py",
    ".lua",
    ".gif",
    ".jpeg",
    ".jpg",
    ".png",
    ".svg",
    ".bimg",
    ".nfp",
    ".bbf",
    ".css",
    ".html",
    ".js",
    ".php",
    ".c",
    ".class",
    ".cpp",
    ".cs",
    ".java",
    ".cfg",
    ".yml",
    ".avi",
    ".h264",
    ".mp4",
    ".mov",
    ".doc",
    ".docx",
    ".odt",
    ".pdf",
    ".rtf",
    ".txt",
  }

  local namings = {
    "MIDI audio",
    "MIDI audio",
    "MP3 audio",
    "WAV audio",
    "7z archive",
    "Package",
    "RAR Archive",
    "Tarball archive",
    "ZIP archive",
    "Data file",
    "Database",
    "Database",
    "Log file",
    "SQL database",
    "XML file",
    "Executable",
    "Java Archive",
    "Python file",
    "Lua file",
    "GIF image",
    "JPEG image",
    "JPEG image",
    "PNG image",
    "Vector image",
    "BIMG image (CC)",
    "NFP image (CC)",
    "BBF image (CC)",
    "CSS file",
    "HTML file",
    "JavaScript file",
    "PHP file",
    "C and C+ code",
    "Java class",
    "C++ code",
    "C# code",
    "Java code",
    "Config",
    "Config",
    "AVI video",
    "H264 video",
    "MPEG4 video",
    "Apple movie",
    "Microsoft Word?",
    "Microsoft Word?",
    "OpenOffice docs",
    "PDF file",
    "Rich Text Format",
    "Lovely TXT",
  }

service = {

    get = function(extension)
        local index
        for i, v in pairs(extensions) do
            if extension == v then
                return namings[i], extensions[i]
            end
        end
    end
}

return service