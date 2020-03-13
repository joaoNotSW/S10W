Grid = class()

function Grid:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size
    self.winner = nil --{nil, "X", "O"}
end

function Grid:draw()
  
end

function Grid:touched(touch)

end
