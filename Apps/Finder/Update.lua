term.clear()

term.setTextColor(colors.lime)

shell.setDir("BucketOS/Apps/Finder")
fs.delete("BucketOS/Apps/Finder/Finder")

shell.run("pastebin", "get", "U2KVvuC7", "Finder")

write("Updated!")

-----------------

shell.run("Finder")
