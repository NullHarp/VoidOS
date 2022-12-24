for index, value in ipairs(peripheral.getNames()) do
    if peripheral.getType(value) == "monitor" then
        local mon = peripheral.wrap(value)
        local old_term = term
        term.redirect(mon)
        term.setBackgroundColor(colors.black)
        term.setTextColor(colors.white)
        term.clear()
        local x,y = term.getSize()
        --paintutils.drawImage(face,x/2-10,y/4)
        

        paintutils.drawFilledBox(x/10,y/10,x/5,y/2,colors.white)
        paintutils.drawFilledBox(x-x/10,y/10,x-x/5,y/2,colors.white)
        paintutils.drawFilledBox(x/4,y-y/10,x-x/4,y-y/5,colors.white)
    end
end