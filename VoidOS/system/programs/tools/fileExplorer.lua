local util = require("/VoidOS/system/core/api/util")
local menuAPI = require("/VoidOS/system/core/api/menu")

local function createFileBrowserMenu(directory)
    local files = fs.list(directory)
    local menuOptions = {}

    if directory ~= "/" then
        table.insert(menuOptions, "..")
    end

    for _, file in ipairs(files) do
        if fs.isDir(directory .. "/" .. file) then
            table.insert(menuOptions, "/" .. file)
        else
            table.insert(menuOptions, file)
        end
    end

    table.insert(menuOptions, "+ New File")
    table.insert(menuOptions, "+ New Directory")

    return menuOptions
end

local function openFile(file)
    local extension = string.match(file, "%.(%w+)$")
    local submenuOptions = {"Edit", "Delete", "Run"}
    local submenuSelected = menuAPI.runMenu(submenuOptions, term.current(), 1, 4, file)
    if submenuSelected == 1 then
        shell.openTab("edit " .. file)
    elseif submenuSelected == 2 then
        fs.delete(file)
    elseif submenuSelected == 3 then
        shell.openTab(file)
    end
end

local function createNewFile(directory)
    term.clear()
    term.setCursorPos(1, 1)
    util.title("Create New File")
    print("Current Directory: " .. directory)
    print()
    print("Enter the name of the new file:")
    local fileName = read()
    fileName = tostring(fileName)
    local filePath = directory .. "/" .. fileName
    local file = fs.open(filePath, "w")
    if file then
        file.close()
        print("File created successfully.")
        os.sleep(2)
    else
        print("Failed to create the file.")
        os.sleep(2)
    end
end

local function createNewDirectory(directory)
    term.clear()
    term.setCursorPos(1, 1)
    util.title("Create New Directory")
    print("Current Directory: " .. directory)
    print()
    print("Enter the name of the new directory:")
    local dirName = read()
    dirName = tostring(dirName)
    local dirPath = directory .. "/" .. dirName
    fs.makeDir(dirPath)
    if fs.exists(dirPath) then
        print("Directory created successfully.")
        os.sleep(2)
    else
        print("Failed to create the directory.")
        os.sleep(2)
    end
end

local function deleteFileOrDirectory(path)
    term.clear()
    term.setCursorPos(1, 1)
    util.title("Delete File or Directory")
    print("Path: " .. path)
    print()
    print("Are you sure you want to delete this file/directory? (y/n)")
    local confirmation = read()
    if confirmation == "y" or confirmation == "Y" then
        fs.delete(path)
        if not fs.exists(path) then
            print("File/directory deleted successfully.")
            os.sleep(2)
        else
            print("Failed to delete the file/directory.")
            os.sleep(2)
        end
    end
end

local function browseFiles(directory)
    while true do
        local menuOptions = createFileBrowserMenu(directory)
        local selected = menuAPI.runMenu(menuOptions, term.current(), 1, 4, directory)

        if selected == 1 and directory ~= "/" then
            local parentDir = fs.getDir(directory)
            if type(parentDir) == "nil" then
                shell.run("/VoidOS/system/core/menu/mainMenu tool")
            end
            directory = parentDir
        elseif selected == #menuOptions - 1 then
            createNewFile(directory)
        elseif selected == #menuOptions then
            createNewDirectory(directory)
        else
            local selectedItem = menuOptions[selected]
            local itemPath = directory .."/".. selectedItem

            if fs.isDir(itemPath) then
                local submenuOptions = {"Open", "Delete"}
                local submenuSelected = menuAPI.runMenu(submenuOptions, term.current(), 1, 4, selectedItem)
                if submenuSelected == 1 then
                    directory = itemPath
                elseif submenuSelected == 2 then
                    deleteFileOrDirectory(itemPath)
                end
            else
                openFile(itemPath)
            end
        end
    end
end

local fileBrowserDirectory = "VoidOS"
browseFiles(fileBrowserDirectory)
