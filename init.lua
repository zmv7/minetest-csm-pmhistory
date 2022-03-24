local storage = minetest.get_mod_storage()
--if not storage:get_string('pmhist') then storage:set_string('pmhist','') end
minetest.register_on_receiving_chat_message(function(message)
if message:match('DM from %S') or message:match('PM from %S') then
storage:set_string('pmhist',storage:get_string('pmhist')..os.date()..'   '..message..'\n\n')
end
end)
minetest.register_chatcommand("pmhist", {
    description = "View PM history",
    func = function(param)
core.show_formspec('pmhist',"size[16,9]textarea[0.2,0;16.1,10;hist;PM History:;"..storage:get_string('pmhist').."]button[7,8.5;2,1;save;Edit]")
end})
core.register_on_formspec_input(function(formname, fields)
	if formname == "pmhist" then
	if fields.save then
		storage:set_string('pmhist',fields.hist)
	end
	end
end)
