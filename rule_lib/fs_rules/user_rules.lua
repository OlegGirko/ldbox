-- Rule file interface version, mandatory.
--
fs_rule_lib_interface_version = "105"
----------------------------------

-- http://stackoverflow.com/a/4991602/337649
function user_file_readable(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function use_outside_path(path)
  table.insert(  emulate_mode_rules, 1,
    {dir = path, rules = { {dir = path, use_orig_path = true}, }, })
end

-- Allow user-defined rules to "overlay" what we've defined here.
-- What is in ~/.lbrules gets executed as if its contents were in this file, on this line.
function run_user_lbrules()
   -- We could call .lbrules via pcall to trap errors but that just hides them from the user
   -- pcall(dofile, home .. '/.lbrules')
   local lbrules = ldbox_user_home_dir .. '/.lbrules'
   if user_file_readable(lbrules) then
      do_file(lbrules)
   end
end
