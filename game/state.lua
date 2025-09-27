local GS = {}

GS.state = {
    Menu = 1,
    InGame = 2,
    Finished = 3,
}

GS.getStateName = {}
for k, v in pairs(GS.state) do
    GS.getStateName[v] = k
end

return GS
