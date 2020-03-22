Button = class()

function Button:init(text, x, y, width, height)
  self.text = text

  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.radius = height/2
end

function Button:draw()
  pushStyle()
    fill(0, 255, 0)
    rectMode(CENTER)
    rect(self.x, self.y, self.width - 2*self.radius, self.height)
    ellipse(self.x + (self.width/2 - self.radius), self.y, 2*self.radius)
    ellipse(self.x - (self.width/2 - self.radius), self.y, 2*self.radius)
  popStyle()

  pushStyle()
    fill(255)
    font("Futura-CondensedExtraBold")
    fontSize(50)
    textMode(CENTER)
    text(self.text, self.x, self.y)
  popStyle()
end

function Button:touched(touch)
  if touch.state == ENDED then
    if dist(touch.x, touch.y, self.x - (self.width/2 - self.radius), self.y) <= self.radius then
      return true

    elseif dist(touch.x, touch.y, self.x + (self.width/2 - self.radius), self.y) <= self.radius then
      return true

    elseif touch.x >= self.x - (self.width/2 - self.radius) and touch.x <= self.x + (self.width/2 - self.radius) then
    if touch.y >= self.y - self.height/2 and touch.y <= self.y + self.height/2 then
        return true
      end
    end
  end

  return false
end

function dist(x1, y1, x2, y2)
  res = math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2))

  return res
end
