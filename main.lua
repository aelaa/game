world = {}
local image

-- third parties
local anim8 = require('lib/anim8')

-- local
local menu = require('menu')
local game = require('game')

function love.load()

  world.current = 'game'
  world.time_factor = 1

  world['player'] = {}

  player = world.player

  player.x = love.graphics.getWidth() / 2
  player.y = love.graphics.getHeight() / 2
  player.state = 'waiting'

  image = love.graphics.newImage('resources/player_waiting.png')
  local g = anim8.newGrid(32, 32, image:getWidth(), image:getHeight())
  player.animation = anim8.newAnimation(g('1-7',1), 0.1)

  player.speed = 200
  player.gravity = -500
  player.ground = player.y
  player.y_velocity = 0
  player.jump_height = -300
end

function love.update(dt)
  -- if state.current == 'menu' then
  --   menu.update(dt)
  -- elseif state.current == 'game' then
  --   game.update(dt)
  -- end
  if love.keyboard.isDown('d') then
    if world.player.state ~= 'walking' then
      image = love.graphics.newImage('resources/player_walking.png')
      local g = anim8.newGrid(32, 32, image:getWidth(), image:getHeight())
      world.player.animation = anim8.newAnimation(g('1-6',1), 0.05)
      world.player.state = 'walking'
      world.player.direction = 0
    end

    player.x = player.x + (player.speed * dt)
  end

  if love.keyboard.isDown('a') then
    if world.player.state ~= 'walking' then
      image = love.graphics.newImage('resources/player_walking.png')
      local g = anim8.newGrid(32, 32, image:getWidth(), image:getHeight())
      world.player.animation = anim8.newAnimation(g('1-6',1), 0.05):flipH()
      world.player.state = 'walking'
      world.player.direction = 1
    end

    player.x = player.x - (player.speed * dt)
  end

  if not love.keyboard.isDown('a', 'd') then
    if world.player.state ~= 'waiting' then
      image = love.graphics.newImage('resources/player_waiting.png')
      local g = anim8.newGrid(32, 32, image:getWidth(), image:getHeight())
      world.player.animation = anim8.newAnimation(g('1-6',1), 0.1)
      if world.player.direction == 1 then
        world.player.animation = world.player.animation:flipH()
      end

      world.player.state = 'waiting'
    end
  end

  player.animation:update(dt)
end

function love.draw()
  player.animation:draw(image, player.x, player.y, 0, 4, 4)
  -- if state.current == 'menu' then
  --   menu.draw()
  -- elseif state.current == 'game' then
  --   game.draw()
  -- end
end
