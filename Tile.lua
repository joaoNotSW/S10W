Tile = class()

function Tile:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size
    self.state = "CLOSED" --{"CLOSED", "X", "O"}
end

function Tile:draw()
  pushStyle()
    rectMode(CORNER)
    stroke(255)
    strokeWidth(5)
    noFill()
    rect(self.x, self.y, self.size, self.size)
  popStyle()

  if self.state == "X" then
    pushStyle()
      stroke(0, 255, 0)
      strokeWidth(5)
      line(self.x + self.size/3, self.y + self.size/3, self.x + 2*self.size/3, self.y + 2*self.size/3)
      line(self.x + self.size/3, self.y + 2*self.size/3, self.x + 2*self.size/3, self.y + self.size/3)
    popStyle()

  elseif self.state == "O" then
    pushStyle()
      noFill()
      stroke(255, 0, 0)
      strokeWidth(5)
      ellipse(self.x + self.size/2, self.y + self.size/2, self.size/3)
    popStyle()
  end
end

function Tile:touched(touch, player)
  if self.state == "CLOSED" then
    self.state = player
    return 0
  end
end
