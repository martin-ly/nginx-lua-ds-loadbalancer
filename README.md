nginx-lua-ds-loadbalancer
=========================

一个HTTP负载均衡器，基于openresty/lua-nginx-module和liseen/lua-resty-http

A http loadbalancer which is based on openresty/lua-nginx-module and liseen/lua-resty-http


将代码放在位于nginx根目录下的lua/ds_lb/下

Put the code into the directory lua/ds_lb which is located in the root directory of the nginx


在nginx.conf的http段中添加如下配置：

Add the config below to the http seg in nginx.conf:

    lua_package_path "/u/nginx/lua/ds_lb/?.lua;;";
    lua_need_request_body on;
    init_by_lua_file lua/ds_lb/init.lua;
    
    resolver 8.8.8.8;
    resolver_timeout 5s;
    
在nginx.conf的location段中添加如下配置：

Add the config below to the location seg in nginx.conf:

        location / {
            content_by_lua_file lua/ds_lb/lb.lua;
        }
        

负载均衡器的配置在config.lua中

You can config loadbalancer with the file config.lua


可以自己定制调度策略，只需在sched文件夹下创建相关的调度策略文件，在其中提供get_selected_server()函数即可

You can custom your sched strategy by just creating the sched file in the "sched" directory,and provide the function get_selected_server()
