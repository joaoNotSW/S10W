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
  for i = 0, 2 do
    for j = 0, 2 do
      self.tiles[i][j]:draw()
    end
  end
end

function Grid:touched(touch)

end
