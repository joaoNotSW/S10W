Menu = class()

function Menu:init()
  self.options = {"Single Player", "Multiplayer", "Online Multiplayer"}
  self.buttons = {}

  for i = 0, 2 do
    self.buttons[i] = Button(self.options[3-i], WIDTH/2, i*(HEIGHT/3) + HEIGHT/6, 2*WIDTH/3, HEIGHT/6)
  end
end

function Menu:draw()
  background(255)

  for i = 0, 2 do
    self.buttons[i]:draw()
  end
end

function Menu:touched(touch)
  if touch.state == ENDED then
    if self.buttons[math.floor(touch.y/(HEIGHT/3))]:touched(touch) then
      return self.buttons[math.floor(touch.y/(HEIGHT/3))].txt
    end
  end
    return 0
end
