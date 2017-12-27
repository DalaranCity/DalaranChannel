function DC__join (channel, password, frameId, hasVoice)
  JoinPermanentChannel(channel, password, frameId, hasVoice);

  -- update channel color more like a normal guild
  local index = GetChannelName(channel);
  ChangeChatColor("CHANNEL" .. index, 40/255, 255/255, 140/255);

  -- show channel message on main chat frame
  -- TODO: doesn't work on init (when custom channel not joined)
  -- only works when user /reload or logout/relogin after initializing
  -- https://us.battle.net/forums/en/wow/topic/20752045569
  AddChatWindowChannel(1, channel);

  -- enable ColorNameByClass for custom channel
  SetChatColorNameByClass(index, 1);

  -- print channel message
  DEFAULT_CHAT_FRAME:AddMessage("Dalaran: 公会开放频道已加入，输入 /" .. index .. " 即可跨公会聊天", 40/255, 255/255, 140/255);
end

-- TODO: PLAYER_ENTERING_WORLD and PLAYER_LOGIN make custom channel joins
-- immediately on login causes custom channel always the number 1 (/1) channel.
local frameDC = CreateFrame("Frame");
frameDC:RegisterEvent("ZONE_CHANGED_NEW_AREA");

function frameDC:OnEvent (event)
  local name = "Dalaran";

  -- join channel
  DC__join(name, nil, nil, 1);
end

frameDC:SetScript("OnEvent", frameDC.OnEvent);
