NestedGrid = class()

function NestedGrid:init(x, y, size)
  self.x = x
  self.y = y
  self.size = size
  self.grids = {}
  self.nextPlay = {nil, nil}
  self.winner = nil
  self.nextPlayer = "X"

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
  if self.winner == nil then
    for i = 0, 2 do
      for j = 0, 2 do
        self.grids[i][j]:draw()
      end
    end

    pushStyle()
      if self.nextPlayer == "X" then
        fill(100, 255, 100, 50)
      else
        fill(255, 100, 100, 50)
      end
      rectMode(CORNER)

      if self.nextPlay[0] ~= nil and self.nextPlay[1] ~= nil then
        size = self.grids[0][0].size
        rect(self.x + self.nextPlay[0]*size, self.y + self.nextPlay[1]*size, size)
      else
          rect(self.x, self.y, self.size)
      end
    popStyle()
  end

  pushStyle()
    if self.winner == nil then
      stroke(0)
    else
      stroke(175)
    end
    strokeWidth(10)
    line(self.x + self.size/3, self.y + 20, self.x + self.size/3, self.y + self.size - 20)
    line(self.x + 2*self.size/3, self.y + 20, self.x + 2*self.size/3, self.y + self.size - 20)
    line(self.x + 20, self.y + self.size/3, self.x + self.size - 20, self.y + self.size/3)
    line(self.x + 20, self.y + 2*self.size/3, self.x + self.size - 20, self.y + 2*self.size/3)
  popStyle()

  if self.winner == "X" then
    pushStyle()
      stroke(0, 255, 0)
      strokeWidth(35)
      x = self.x + self.size/6
      y = self.y + self.size/6
      line(x, y, x + 2*self.size/3, y + 2*self.size/3)
      line(x, y + 2*self.size/3, x + 2*self.size/3, y)
    popStyle()
  elseif self.winner == "O" then
    pushStyle()
      noFill()
      stroke(255, 0, 0)
      strokeWidth(35)
      ellipse(self.x + self.size/2, self.y + self.size/2, self.size - self.size/6)
    popStyle()
  end

end

function NestedGrid:touched(touch, player)
  if touch.state == ENDED or touch.state == 1999 then
    if touch.x >= self.x and touch.x <= self.x + self.size then
      if touch.y >= self.y and touch.y <= self.y + self.size then
        j = math.floor((touch.x - self.x)/(self.size/3))
        i = math.floor((touch.y - self.y)/(self.size/3))

        if j == self.nextPlay[0] and i == self.nextPlay[1] then
          tmp = self.grids[i][j]:touched(touch, player)

          self.grids[i][j]:checkwin()

          if tmp == 0 then
            self.nextPlay[0] = self.grids[i][j].lastPlay[0]
            self.nextPlay[1] = self.grids[i][j].lastPlay[1]
            if self.grids[self.nextPlay[1]][self.nextPlay[0]].winner ~= nil then
              self.nextPlay[0] = nil
              self.nextPlay[1] = nil
            end
          end

          return tmp
        end

        if self.nextPlay[0] == nil and self.nextPlay[1] == nil then
          tmp = self.grids[i][j]:touched(touch, player)

          if tmp == 0 then
            self.nextPlay[0] = self.grids[i][j].lastPlay[0]
            self.nextPlay[1] = self.grids[i][j].lastPlay[1]

            if self.grids[self.nextPlay[1]][self.nextPlay[0]].winner ~= nil then
              self.nextPlay[0] = nil
              self.nextPlay[1] = nil
            end
          end

          self.grids[i][j]:checkwin()
          return tmp
        end

        return -1
      end
    end
  end
end

function NestedGrid:checkwin()
  -- Check Rows
  for i = 0, 2 do
    if self.grids[i][0].winner == self.grids[i][1].winner and self.grids[i][0].winner == self.grids[i][2].winner then
      if self.grids[i][0].winner ~= nil then
        return self.grids[i][0].winner
      end
    end
  end

  -- Check Collumns
  for j = 0, 2 do
    if self.grids[0][j].winner == self.grids[1][j].winner and self.grids[0][j].winner == self.grids[2][j].winner then
      if self.grids[0][j].winner ~= nil then
        return self.grids[0][j].winner
      end
    end
  end

  -- Check Diagonals
  if self.grids[0][0].winner == self.grids[1][1].winner and self.grids[0][0].winner == self.grids[2][2].winner then
    if self.grids[1][1].winner ~= nil then
      return self.grids[1][1].winner
    end
  elseif self.grids[0][2].winner == self.grids[1][1].winner and self.grids[0][2].winner == self.grids[2][0].winner then
    if self.grids[1][1].winner ~= nil then
      return self.grids[1][1].winner
    end
  end
  return nil
end
