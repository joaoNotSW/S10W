Tile = class()

function Tile:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size
    self.state = "CLOSED" --{"CLOSED", "X", "O"}
end

function Tile:draw()
  rectMode(CORNER)
  stroke(0)
  strokeWidth(1)
  fill(255)
  rect(self.x, self.y, self.size, self.size)
end

function Tile:touched(touch)

end
