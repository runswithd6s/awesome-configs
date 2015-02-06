require("lfs") 
-- Retrieved from: http://awesome.naquadah.org/wiki/Autostart#The_native_lua_way
-- {{{ Run programm once
local function processwalker()
   local function yieldprocess()
      for dir in lfs.dir("/proc") do
        -- All directories in /proc containing a number, represent a process
        if tonumber(dir) ~= nil then
          local f, err = io.open("/proc/"..dir.."/cmdline")
          if f then
            local cmdline = f:read("*all")
            f:close()
            if cmdline ~= "" then
              coroutine.yield(cmdline)
            end
          end
        end
      end
    end
    return coroutine.wrap(yieldprocess)
end

local function run_once(process, cmd)
   assert(type(process) == "string")
   local regex_killer = {
      ["+"]  = "%+", ["-"] = "%-",
      ["*"]  = "%*", ["?"]  = "%?" }

   for p in processwalker() do
      if p:find(process:gsub("[-+?*]", regex_killer)) then
   return
      end
   end
   return awful.util.spawn(cmd or process)
end
-- }}}

-- Run-once apps
-- Single Argument
run_once("google-chrome")
run_once("/home/cwalstrom/bin/urxvtc")
run_once("xscreensaver")
run_once("thunderbird")
run_once("emacs")

-- Other examples
--run_once("pidgin")
--run_once("vmware")
--run_once("emacs --daemon")
--run_once("/usr/lib/vino/vino-server")
--run_once("sqldeveloper")
--run_once("/opt/bin/spoon.sh")
--run_once("/opt/bin/mulemq-manager.sh")
-- Use the second argument, if the programm you wanna start, 
-- differs from the what you want to search.
--run_once("redshift", "nice -n19 redshift -l 51:14 -t 5700:4500")
