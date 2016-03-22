MapKnowledge = Class {

  init = function (self)
    self.cells = {}
    self.bounds = {
      left = 0,
      right = 0,
      top = 0,
      bottom = 0
    }
  end

}


function MapKnowledge:get_bounds()
  
end


function MapKnowledge:merge(cells)
  local previous = nil
  local since_previous = 0
  for i = 1, #cells do
    local cell = cells[i]

    if cell.x and cell.y then
      self:set(cell.y, cell.x, cell)

      previous = cell
      since_previous = 0
    elseif previous then
      since_previous = since_previous + 1

      self:set(previous.y, previous.x + since_previous, cell)
    end
  end
end


function MapKnowledge:set(x, y, cell)
  if not self.cells[x] then
    self.cells[x] = {}
  end

  self.cells[x][y] = cell

  -- update bounds
  if x < self.bounds.left then
    self.bounds.left = x
  end

  if x > self.bounds.right then
    self.bounds.right = x
  end

  if y < self.bounds.top then
    self.bounds.top = y
  end

  if y > self.bounds.bottom then
    self.bounds.bottom = y
  end
end


function MapKnowledge:print()
  local line = ''
  for x = self.bounds.left, self.bounds.right do
    for y = self.bounds.top, self.bounds.bottom do
      if self.cells[x] and self.cells[x][y] then
        line = line .. self.cells[x][y].g
      else
        line = line .. ' '
      end
    end
    line = line .. '\n'
  end

  print(line)

  table.insert(history, 1, line)

  return line
end
