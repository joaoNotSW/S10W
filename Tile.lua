Tile = class()

function Tile:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size
    self.state = "CLOSED" --{"CLOSED", "X", "O"}
end

function Tile:draw()
  -- If there is an X
  if self.state == "X" then
    pushStyle()
      stroke(0, 255, 0)
      strokeWidth(7)
      line(self.x + self.size/3, self.y + self.size/3, self.x + 2*self.size/3, self.y + 2*self.size/3)
      line(self.x + self.size/3, self.y + 2*self.size/3, self.x + 2*self.size/3, self.y + self.size/3)
    popStyle()

  -- If there is an O
  elseif self.state == "O" then
    pushStyle()
      noFill()
      stroke(255, 0, 0)
      strokeWidth(7)
      ellipse(self.x + self.size/2, self.y + self.size/2, self.size/3)
    popStyle()
  end
end

function Tile:touched(touch, player)
  if self.state == "CLOSED" then
    self.state = player
    return 0
  end

  return -1
end
