-- algae

function init()
  print("loaded algae")
  clock.run(function()
    while true do
      get_txi_params()
      redraw()
      clock.sleep(0.1)
    end
  end)
end

function key(n, z)
  if n == 3 and z == 1 then
    reload()
  end
end

function reload()
  norns.script.load("code/algae/algae.lua")
end

function redraw()
  screen.clear()
  screen.level(5)

  screen.move(5, 20)
  screen.font_size(15)
  screen.text("algae")

  screen.font_size(8)

  if norns.crow.connected() then
    screen.move(5, 40)
    screen.text("crowing!")
  end

  screen.move(5, 50)
  screen.text("k3: reload")

  for i = 1, 4 do
    screen.move(55, 20 + i * 10)
    screen.text("txi param " .. i .. ": " .. txi.params[i])
  end

  screen.update()
end

----- TXI -----

txi = {
  params = {},
}

crow.ii.txi.event = function(event, value)
  if event.name == "param" then
    txi.params[event.arg] = value
  end
end

for i = 1, 4 do
  txi.params[i] = 0
end

function get_txi_params()
  for i = 1, 4 do
    crow.ii.txi.get("param", i)
  end
end
