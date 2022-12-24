for index, value in ipairs(peripheral.getNames()) do
    if peripheral.getType(value) == "computer" then
        print(value)
        for index1, value1 in ipairs(peripheral.getMethods(value)) do
            print(value1)
        end
    end
end