NestedGrid = class()

function NestedGrid:init(x, y, size)
  self.x = x
  self.y = y
  self.size = size
  self.grids = {}

  for i = 0, 2 do
    self.grids[i] = {}
    for j = 0, 2 do
      x = self.x + j*self.size/3
      y = self.y + i*self.size/3
      self.grids[i][j] = Grid(x, y, self.size/3)
    end
  end

end

function NestedGrid:draw()
  for i = 0, 2 do
    for j = 0, 2 do
      self.grids[i][j]:draw()
    end
  end

  pushStyle()
    stroke(255)
    strokeWidth(5)
    line(self.x + self.size/3, self.y + 20, self.x + self.size/3, self.y + self.size - 20)
    line(self.x + 2*self.size/3, self.y + 20, self.x + 2*self.size/3, self.y + self.size - 20)
    line(self.x + 20, self.y + self.size/3, self.x + self.size - 20, self.y + self.size/3)
    line(self.x + 20, self.y + 2*self.size/3, self.x + self.size - 20, self.y + 2*self.size/3)
  popStyle()

end

function NestedGrid:touched(touch)

end
