local version = "V0"

function getLabel()
    if os.getComputerLabel() == nil then
        return "N/A"
    else
        return os.getComputerLabel()
    end
end

function title(text)
    term.clear()
    term.setCursorPos(1,1)
    term.setTextColor(colors.yellow)
    term.write("VoidOS "..version.." | Label: "..getLabel().." | ID: "..os.getComputerID())
    term.setCursorPos(1,2)
    term.write(text)
    term.setTextColor(colors.white)
    term.setCursorPos(1,4)
end

return {version = version, title = title}