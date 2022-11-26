local db = require(".UwUntuCC.OS.Libraries.Databaser")

db.setDir("UwUntuCC/OS/Libraries/ExtensionsService/DB/")

--[[db.createTable("Extensions")

db.addColumn("Extensions", "Extension")

db.addColumn("Extensions", "Naming")]]

local extensions = {
    ".mid", -- MIDI audio
    ".midi", -- MIDI audio
    ".mp3", -- MP3 audio
    ".wav", -- WAV audio
    ".7z", -- 7zip archive
    ".pkg", -- Package archive
    ".rar", -- RAR archive
    ".tar.gz", -- Tarball archive
    ".zip", -- ZIP archive
    ".dat", -- Data file
    ".db", -- Database
    ".dbf", -- Database
    ".log", -- Log file
    ".sql", -- SQL database
    ".xml", -- XML file
    ".exe", -- Executable
    ".jar", -- Java Archive
    ".py", -- Python file
    ".lua", -- Lua file
    ".gif", -- GIF image
    ".jpeg", -- JPEG image
    ".jpg", -- JPEG image
    ".png", -- PNG image
    ".svg", -- Vector file
    ".bimg", -- BIMG file
    ".nfp", -- NFP file
    ".bbf", -- BBF image
    ".css", -- CSS file
    ".html", -- HTML file
    ".js", -- JavaScript file
    ".php", -- PHP file
    ".c", -- C and C+ code
    ".class", -- Java class
    ".cpp", -- C++ code
    ".cs", -- C# code
    ".java", -- Java code
    ".cfg", -- Config
    ".yml", -- Config
    ".avi", -- AVI video
    ".h264", -- H264 video
    ".mp4", -- MPEG4 video
    ".mov", -- Apple movie
    ".doc", -- Microsoft Word?
    ".docx", -- Microsoft Word?
    ".odt", -- OpenOffice docs
    ".pdf", -- PDF file
    ".rtf", -- Rich Text Format
    ".txt", -- Plain Text File
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

db.import("Extensions", "Extension", extensions)

db.import("Extensions", "Naming", namings)