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


function MapKnowledge:merge(cells)
    local previous = nil
    local since_previous = 0
    for i = 1, #cells do
        local cell = cells[i]

        if cell.x and cell.y then
            self:set(cell.x, cell.y, cell)

            previous = cell
            since_previous = 0
        elseif previous then
            since_previous = since_previous + 1

            cell.x = previous.x + since_previous
            cell.y = previous.y
            self:set(previous.x + since_previous, previous.y, cell)
        end
    end
end


function MapKnowledge:set(x, y, cell)
    if not self.cells[x] then
        self.cells[x] = {}
    end

    if self.cells[x][y] then
        cell = table.merge(self.cells[x][y], cell)
    end

    -- Reset fg/bg
    if cell.t.fg and type(cell.t.fg) == 'table' then
        cell.t.fg.value = nil
    end

    if cell.t.bg and type(cell.t.bg) == 'table' then
        cell.t.bg.value = nil
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
    for y = self.bounds.top, self.bounds.bottom do
        for x = self.bounds.left, self.bounds.right do

            if self.cells[x] and self.cells[x][y] and self.cells[x][y].g then
                line = line .. self.cells[x][y].g
            else
                line = line .. '-'
            end

        end
        line = line .. '\n'
    end

    print(line)

    table.insert(history, 1, line)

    return line
end


function MapKnowledge:visible(cell)
    if (cell.t) then
        cell.t.bg = enums.prepare_bg_flags(cell.t.bg or 0)
        return not cell.t.bg.UNSEEN and not cell.t.bg.MM_UNSEEN
    end

    return false;
end
