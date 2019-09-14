SMSocket = {}
SMSocket.__index = SMSocket

function SMSocket:new()
    local sm_socket = {}
    setmetatable(sm_socket, SMSocket)

    return sm_socket
end

function SMSocket:get_input()
end

function SMSocket:send_state()
end