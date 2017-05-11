state = {}

local menu = require('menu')
local game = require('game')

function love.load()
  platform.width = love.graphics.getWidth()
  platform.height = love.graphics.getHeight()

  platform.x = 0
  platform.y = platform.height / 2

  player.x = love.graphics.getWidth() / 2
  player.y = love.graphics.getHeight() / 2
  player.img = love.graphics.newImage('player.png')

  enemy.x = love.graphics.getWidth() / 2 + 200
  enemy.y = love.graphics.getHeight() / 2
  enemy.img = love.graphics.newImage('player.png')
  state.attack = 0

  player.speed = 200
  player.gravity = -500
  player.ground = player.y
  player.y_velocity = 0
  player.jump_height = -300
  player.time_factor = 1

  state.current = 'game'
end

function love.update(dt)
  if state.current == 'menu' then
    menu.update(dt)
  elseif state.current == 'game' then
    game.update(dt)
  end
end

function love.draw()
  if state.current == 'menu' then
    menu.draw()
  elseif state.current == 'game' then
    game.draw()
  end
end
