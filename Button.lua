Button = class()

function Button:init(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height

end

function Button:draw()
  pushStyle()
    rectMode(CENTER)
    fill(45)
    rect(self.x, self.y, self.width, self.height)

  popStyle()
end
