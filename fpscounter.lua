FPSCounter = {
    _fps = 0,
    _lastUpdate = 0
}

function FPSCounter:draw()
    Colors.BLACK:set()
    Fonts.DIAGNOSTICS:set()
    love.graphics.print("FPS: " .. self._fps, 2, 0)
end

function FPSCounter:update(dt)
    local seconds = os.time()

    if (seconds > self._lastUpdate) then
        self._fps = math.floor((1 / dt))
        self._lastUpdate = seconds
    end
end