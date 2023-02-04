local find = string.find
local lower = string.lower

local PlayerName = UnitName("vacuus")



--Responses to triggered keywords
-- eventually there will be a UI where users can select the classes they want for each role and those will be loaded into the responses.
local responses = {
   [1] = "GrpF: Currently the group is looking for <class>,<class>. Please /w me back your class and gearscore in the following format to recieve an invite: grpf spec class gearscore",       
   [2] = "GrpF: Currently the group is looking for <class>,<class>. Please /w me back your class and gearscore in the following format to recieve an invite: grpf spec class gearscore",  
   [3] = "GrpF: Currently the group is looking for <class>,<class>. Please /w me back your class and gearscore in the following format to recieve an invite: grpf spec class gearscore",    
}

--Trigger keywords. Use lower case.
--You can map several triggers to the same response by using the same number as value.
local triggers = {
   ["dps"] = 1,    --Maps to table responses index 1 ("Some auto-response")
   ["tank"] = 2,    --Maps to table responses index 2
   ["heal"] = 3,    --Maps to table responses index 3
}

local function EventHandler(self, event, message, author)

   --Loop through all triggers and check if message contains any of them
   for trigger, responseID in pairs(triggers) do    
      if message:lower():find(trigger) then
         --Trigger keyword found in message, send back response
         SendChatMessage(responses[responseID], "WHISPER", nil, author)
         
         break --Don't send more than 1 response even if several triggers were found in the message
      end
   end

   if message:lower():find("grpf")  then
    playerInfo = { }
    --Trigger keyword found in message, send back response
    count = 1
    for info in string.gmatch(message, "%S+") do

        --TODO: add author to the mix in some way so we dont overwrite with multiple /w
        if info:lower() ~= "grpf" then
	    table.insert(playerInfo, count, tostring(info)) --insert the current information into our table at the current index of count
            count = count + 1
        end

    end 
    SendChatMessage(playerInfo[1], "WHISPER", nil, author)
 end
end

local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_WHISPER")
f:SetScript("OnEvent", EventHandler)