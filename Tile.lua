Tile = class()

function Tile:init(x, y)
    self.x = x
    self.y = y
    self.state = "CLOSED" --{"CLOSED", "X", "O"}
end

function Tile:draw()

end

function Tile:touched(touch)

end
