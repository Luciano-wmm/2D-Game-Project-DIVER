require "collision"

screenWidth = love.graphics.getWidth()
screenHeight = love.graphics.getHeight()

function love.load()
  math.randomseed(os.time())

  score = 0

  imgBackground = love.graphics.newImage("img/background.png")

  fonts = {}
  fonts.large = love.graphics.newFont("fonts/Gamer.ttf", 36)

  
  starSound = love.audio.newSource("sounds/coin.ogg", "static")
  sharkSound = love.audio.newSource("sounds/bite.mp3", "static")


  -- DIVER
  imgDiver = love.graphics.newImage("img/diver.png")

  diver ={
    posX = 100,
    posY = 100,
    w = 200,
    h = 96,
    speed = 500
  }

  -- STARFISH
  delayStar = 3
  timeNewStar = delayStar
  imgStar = love.graphics.newImage("img/star.png")
  stars = {}

  -- SHARK
  delayShark = 3
  timeNewShark = delayShark
  imgShark = love.graphics.newImage("img/shark.png")
  sharks = {}
end


function love.update(dt)
  diverMovement(dt)
  star(dt)
  shark(dt)
end


function love.draw()
  love.graphics.draw(imgBackground)
  
  love.graphics.setFont(fonts.large)
  love.graphics.print("DIVER: " .. score, 10, 10)

  -- DIVER
  love.graphics.draw(imgDiver, diver.posX, diver.posY, 0, 1, 1, imgDiver:getWidth()/2, imgDiver:getHeight()/2)
  --love.graphics.print((diver.h + diver.posY), 10, 45)

  -- STARFISHS
  for i, star in ipairs(stars) do
    love.graphics.draw(imgStar, star.x, star.y, 0, 1, 1, imgStar:getWidth()/2, imgStar:getHeight()/2)
    --love.graphics.print(star.y, 10, 550)
  end

  -- SHARKS
  for i, shark in ipairs(sharks) do
    love.graphics.draw(imgShark, shark.x, shark.y, -0.1, 1, 1, imgShark:getWidth()/2, imgShark:getHeight()/2)
    --love.graphics.print((shark.h + shark.y), 10, 25)
  end
end

function diverMovement(dt)
  if love.keyboard.isDown("up") then
    if diver.posY > (0 + imgDiver:getHeight()/2) then
      diver.posY = diver.posY - diver.speed * dt
    end
  end
  if love.keyboard.isDown("down") then
    if diver.posY < (screenHeight - imgDiver:getHeight()/2) then
      diver.posY = diver.posY + diver.speed * dt
    end
  end
end 

function star(dt)
  timeNewStar = timeNewStar - (1 * dt)
  if timeNewStar < 0 then
  timeNewStar = delayStar
    randomNumber = math.random(10, love.graphics.getHeight() - ((imgStar:getHeight()/2)+10))
    newStar = {y = randomNumber, x = 800, img = imgStar}
    table.insert(stars, newStar)
  end
  
  for i, star in ipairs(stars) do
    star.x = star.x - (250 * dt)
    if star.x < 0 then
      table.remove(stars, i)
    end
  end

  for i, star in ipairs(stars) do
    if AABB(diver.posX, diver.posY, diver.w/2, diver.h/2, star.x, star.y, imgStar:getWidth(), imgStar:getHeight()) then
      table.remove(stars, i)
      score = score + 1
      starSound:play()
    end
  end
end 

function shark(dt)
  timeNewShark = timeNewShark - (1 * dt)
  if timeNewShark < 0 then
    timeNewShark = delayShark
    randomNumber = math.random(10, love.graphics.getHeight() - ((imgShark:getHeight()/2)+10))
    newShark = {y = randomNumber, x = 800, img = imgShark}
    table.insert(sharks, newShark)
  end
  
  for i, shark in ipairs(sharks) do
    shark.x = shark.x - (350 * dt)
    if shark.x < 0 then
      table.remove(sharks, i)
    end
  end

  for i, shark in ipairs(sharks) do
    if AABB(diver.posX, diver.posY - (imgDiver:getHeight()/2), diver.w, diver.h, shark.x, shark.y - (imgShark:getHeight()/2), imgShark:getWidth(), imgShark:getHeight()) then
      table.remove(sharks, i)
      score = score - 1
      sharkSound:play()      
    end
  end
end 