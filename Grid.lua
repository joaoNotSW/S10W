Grid = class()

function Grid:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size
    self.winner = nil --{nil, "X", "O"}
    self.lastPlay = {nil, nil}
    self.tiles = {}

    -- Init tiles as empty 3x3 matrix
    for i = 0, 2 do
      self.tiles[i] = {}
      for j = 0, 2 do
        x = self.x + j*self.size/3
        y = self.y + i*self.size/3
        self.tiles[i][j] = Tile(x, y, self.size/3)
      end
    end
end

function Grid:draw()
  -- Draw the surrounding lines
  pushStyle()
    stroke(0)
    strokeWidth(5)
    line(self.x + self.size/3, self.y + 20, self.x + self.size/3, self.y + self.size - 20)
    line(self.x + 2*self.size/3, self.y + 20, self.x + 2*self.size/3, self.y + self.size - 20)
    line(self.x + 20, self.y + self.size/3, self.x + self.size - 20, self.y + self.size/3)
    line(self.x + 20, self.y + 2*self.size/3, self.x + self.size - 20, self.y + 2*self.size/3)
  popStyle()

  if self.winner == nil then
    -- Draw all tiles
    for i = 0, 2 do
      for j = 0, 2 do
        self.tiles[i][j]:draw()
      end
    end
  end

  -- If there is a winner draw a X or O
  if self.winner == "X" then
    pushStyle()
      stroke(0, 255, 0)
      strokeWidth(25)
      x = self.x + self.size/6
      y = self.y + self.size/6
      line(x, y, x + 2*self.size/3, y + 2*self.size/3)
      line(x, y + 2*self.size/3, x + 2*self.size/3, y)
    popStyle()
  elseif self.winner == "O" then
    pushStyle()
      noFill()
      stroke(255, 0, 0)
      strokeWidth(25)
      ellipse(self.x + self.size/2, self.y + self.size/2, self.size - self.size/6)
    popStyle()
  end

end

function Grid:touched(touch, player)
  if self.winner == nil then
    jx = math.floor((touch.x - self.x)/(self.size/3))
    iy = math.floor((touch.y - self.y)/(self.size/3))

    tmp = self.tiles[iy][jx]:touched(touch, player)

    if tmp == 0 then
      self.lastPlay[0] = jx
      self.lastPlay[1] = iy
    end

    return tmp
  end

  return -1
end

function Grid:checkwin()
  -- Check Rows
  for i = 0, 2 do
    if self.tiles[i][0].state == self.tiles[i][1].state and self.tiles[i][0].state == self.tiles[i][2].state then
      if self.tiles[i][0].state ~= "CLOSED" then
        self.winner = self.tiles[i][0].state
        return self.tiles[i][0].state
      end
    end
  end

  -- Check Collumns
  for j = 0, 2 do
    if self.tiles[0][j].state == self.tiles[1][j].state and self.tiles[0][j].state == self.tiles[2][j].state then
      if self.tiles[0][j].state ~= "CLOSED" then
        self.winner = self.tiles[0][j].state
        return self.tiles[0][j].state
      end
    end
  end

  -- Check Diagonals
  if self.tiles[0][0].state == self.tiles[1][1].state and self.tiles[0][0].state == self.tiles[2][2].state then
    if self.tiles[1][1].state ~= "CLOSED" then
      self.winner = self.tiles[1][1].state
      return self.tiles[1][1].state
    end
  elseif self.tiles[0][2].state == self.tiles[1][1].state and self.tiles[0][2].state == self.tiles[2][0].state then
    if self.tiles[1][1].state ~= "CLOSED" then
      self.winner = self.tiles[1][1].state
      return self.tiles[1][1].state
    end
  end
  return nil
end
