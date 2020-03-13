Grid = class()

function Grid:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size
    self.winner = nil --{nil, "X", "O"}
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
  -- Draw all tiles
  for i = 0, 2 do
    for j = 0, 2 do
      self.tiles[i][j]:draw()
    end
  end
end

function Grid:touched(touch, player)
  if touch.state == ENDED then
    if touch.x >= self.x and touch.x <= self.x + self.size then
      if touch.y >= self.y and touch.y <= self.y + self.size then
        j = math.floor((touch.x - self.x)/(self.size/3))
        i = math.floor((touch.y - self.y)/(self.size/3))

        --Debug
        print (j,i, player)
        return self.tiles[i][j]:touched(touch, player)
      end
    end
  end
end
