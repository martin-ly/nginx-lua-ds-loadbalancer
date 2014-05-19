module("sched.ip_hash",package.seeall)

local config=require "config"
local http_servers_num=#config.http_servers

local function get_user_ip()
    local user_ip = ngx.req.get_headers()["X-Real-IP"]
    if user_ip == nil then
       user_ip = ngx.req.get_headers()["x_forwarded_for"]
    end
    if user_ip == nil then
       user_ip = ngx.var.remote_addr
    end
    return user_ip
end

function get_selected_server()
    local user_ip=get_user_ip()
    local user_ip_table={}
    for i in string.gmatch(user_ip, [=[[^\.]+]=]) do
        user_ip_table[#user_ip_table+1]=i
    end
    local selected_num=user_ip_table[4]%http_servers_num+1
    local selected_server=config.http_servers[selected_num]
    return selected_server
end
