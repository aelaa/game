local game = {}

local function update(dt)
  dt = dt * player.time_factor

  if love.keyboard.isDown('space') then
    if player.y_velocity == 0 then
      player.y_velocity = player.jump_height
    end
  end

  if love.keyboard.isDown('d') then
    player.x = player.x + (player.speed * dt)
  elseif love.keyboard.isDown('a') then
    player.x = player.x - (player.speed * dt)
  end

  if math.abs(player.x - enemy.x) < 100 then
    player.time_factor = 0.2
    state.attack = 1
  else
    player.time_factor = 1
    state.attack = 0
  end

  if player.y_velocity ~= 0 then
    player.y = player.y + player.y_velocity * dt
    player.y_velocity = player.y_velocity - player.gravity * dt
  end

  if player.y > player.ground then
    player.y_velocity = 0
    player.y = player.ground
  end

  if state.attack == 1 then
    if love.keyboard.isDown('j') then
      enemy.img = love.graphics.newImage('hurt.png')
    end
  end
end

local function draw()
  love.graphics.setColor(255,255,255)

  love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
  love.graphics.draw(player.img, player.x, player.y, 0,1,1,0,64)
  love.graphics.draw(enemy.img, enemy.x, enemy.y, 0,1,1,0,64)
end

game.update = update
game.draw = draw

return game
