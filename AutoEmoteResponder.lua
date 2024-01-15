-- AutoEmoteResponder.lua

--search strings
local search = {
	AGREE="agrees",
	AMAZE="amazed",
	ANGRY="anger",
	APOLOGIZE="apologizes",
	APPLAUD="applauds",
	ATTACKTARGET="attack",
	BARK="barks",
	BASHFUL="bashful",
	BECKON="beckons",
	BEG="begs",
	BELCH="burps",
	BITE="bites",
	BLANK="blankly",
	BLINK="blinks",
	BLOOD="blood",
	BLUSH="blushes",
	BOGGLE="boggles",
	BONK="bonks",
	BOOP="boops",
	BORED="bored",
	BOUNCE="bounces",
	BOW="bows",
	BRANDISH="brandishes",
	BRAVO="bravo",
	BRB="back",
	BURP="burp",
	BYE="goodbye",
	CACKLE="cackles",
	CALM="calm",
	CAT="catty!",
	CHALLENGE="duel.",
	CHARGE="charge",
	CHEER="cheers",
	CHEW="eat",
	CHICKEN="Chicken!",
	CHUCKLE="chuckles",
	CLAP="claps excitedly",
	COLD="cold",
	COMFORT="comforts",
	COMMEND="commends",
	CONFUSED="confused",
	CONGRATS="congratulates",
	COUGH="cough",
	COWER="cowers",
	CRACK="crack",
	CRINGE="cringes",
	CRY="cries",
	CUDDLE="cuddles",
	CURIOUS="curious",
	CURTSEY="curtsies",
	DANCE="dances",
	DING="DING!",
	DISAPPOINTED="disappointment",
	DOOM="doom",
	DRINK="a drink",
	DROOL="drool.",
	DUCK="ducks",
	EXCITED="talks excitedly",
	EYE="eyes",
	FACEPALM="palm.",
	FART="farts",
	FEAR="fear",
	FEAST="eat",
	FIDGET="fidgets",
	FLEE="flee!",
	FLEX="flexes",
	FLIRT="flirts",
	FLOP="flops",
	FOLLOWME="follow.",
	FOOD="hungry",
	GASP="gasps",
	GAZE="gazes",
	GIGGLE="giggles",
	GLAD="very happy",
	GLARE="glares",
	GLOAT="gloats",
	GOLFCLAP="claps for",
	GOLFCLAP="unimpressed",
	GOODBYE="goodbye",
	GREET="greets",
	GRIN="grins",
	GROAN="groans",
	GROVEL="grovels",
	GROWL="growls",
	GUFFAW="guffaw!",
	HAIL="hails",
	HEALME="healing",
	HELLO="hello!",
	HELPME="help",
	HIGHFIVE="five!",
	HUG="hugs",
	IMPATIENT="fidgets",
	INCOMING="incoming",
	INSULT="ogre.",
	INTRODUCE="introduces",
	JK="kidding!",
	KISS="kiss.",
	KNEEL="kneels",
	KNUCKLES="knuckles",
	LAUGH="laughs",
	LAY="lies",
	LICK="licks",
	LISTEN="listens",
	LOST="lost.",
	LOVE="loves",
	MAD="mad",
	MASSAGE="massages",
	MERCY="mercy.",
	MOAN="moans",
	MOCK="mocks",
	MOO="moos",
	MOON="moons",
	MOURN="mourns",
	NO="NO.",
	NOD="nods",
	NOSEPICK="picks",
	PANIC="panics.",
	PAT="pats",
	PEER="peers",
	PITY="pity.",
	PLEAD="pleads with you.",
	POINT="points",
	POKE="pokes",
	PONDER="ponders",
	POUNCE="pounces",
	PRAISE="praise",
	PRAY="prayer",
	PURR="purrs",
	PUZZLED="puzzled",
	QUESTION="questions",
	RAISE="you and raises",
	READY="ready!",
	REAR="rear",
	REGRET="regret",
	ROAR="roars",
	ROFL="floor",
	ROLLEYES="eyes at",
	RUDE="rude",
	SAD="NOTARGET",
	SALUTE="salutes",
	SCARED="scared",
	SCRATCH="scratch",
	SERIOUS="serious.",
	SEXY="sexy",
	SHIMMY="shimmies",
	SHIVER="shivers",
	SHOO="shoos",
	SHRUG="shrugs",
	SHY="shyly",
	SIGH="sighs",
	SILLY="joke.",
	SLAP="slaps",
	SMACK="smacks",
	SMELL="smells",
	SMILE="smiles at",
	SMIRK="smirks",
	SNARL="snarles",
	SNEEZE="sneezes",
	SNICKER="snickers",
	SNIFF="sniffs",
	SNUB="snubs",
	SOOTHE="soothes",
	SPIT="spits",
	STARE="stares you",
	SURPRISED="surprised",
	SURRENDER="surrenders",
	TALK="talk things",
	TALKEX="SAME AS EXCITED",
	TAP="taps",
	TAUNT="taunting",
	TEASE="teases",
	THANK="thanks",
	THINK="thinks about",
	THIRSTY="thirsty.",
	TICKLE="tickles",
	TIRED="tired.",
	TRAIN="train",
	VETO="vetoes",
	VICTORY="victory",
	VIOLIN="violin",
	WAIT="wait.",
	WAVE="waves at",
	WELCOME="welcomes",
	WHINE="whines",
	WHISTLE="whistles",
	WHOA="blown away",
	WINK="winks",
	WORK="works",
	YAWN="yawns",
	YW="happy to help"
}

-- Initialize the AutoEmoteResponder table
AutoEmoteResponder = {}
AutoEmoteResponder.UIElements = {}
AutoEmoteResponder.frame = CreateFrame("Frame")

-- Initialize the settings table immediately
AutoEmoteResponderSettings = AutoEmoteResponderSettings or {}


-- Create and sort a list of emote keys
local sortedEmoteKeys = {}
for emote in pairs(search) do
    table.insert(sortedEmoteKeys, emote)
end
table.sort(sortedEmoteKeys)


function AutoEmoteResponder_CreateOptionsFrame()
    local OptionsFrame = CreateFrame("Frame", "AutoEmoteResponderOptionsFrame", UIParent, "BasicFrameTemplateWithInset")
    OptionsFrame:SetSize(460, 500)  -- Adjust height as needed
    OptionsFrame:SetPoint("CENTER", 0, 100)
    OptionsFrame:SetMovable(true)
    OptionsFrame:EnableMouse(true)
    OptionsFrame:RegisterForDrag("LeftButton")
    OptionsFrame:SetScript("OnDragStart", OptionsFrame.StartMoving)
    OptionsFrame:SetScript("OnDragStop", OptionsFrame.StopMovingOrSizing)
    OptionsFrame:Hide()

    OptionsFrame.title = OptionsFrame:CreateFontString(nil, "OVERLAY")
    OptionsFrame.title:SetFontObject("GameFontHighlight")
    OptionsFrame.title:SetPoint("TOP", OptionsFrame.TitleBg, "TOP", 5, -2)
    OptionsFrame.title:SetText("Auto Emote Responder Options Window")

    local OptionsScrollFrame = CreateFrame("ScrollFrame", "AutoEmoteResponderOptionsScrollFrame", OptionsFrame, "UIPanelScrollFrameTemplate")
    OptionsScrollFrame:SetSize(420, 460)
    OptionsScrollFrame:SetPoint("TOP", OptionsFrame, "TOP", -10, -30)

-- Define tableLength function
	local function tableLength(table)
    local count = 0
    for _ in pairs(table) do 
        count = count + 1 
    end
    return count
	end

-- Scroll child frame where elements are actually placed
	local ScrollChild = CreateFrame("Frame")
	local totalHeight = 30 * tableLength(search)
	ScrollChild:SetSize(430, totalHeight)  -- Adjust height based on the number of elements
	OptionsScrollFrame:SetScrollChild(ScrollChild)

-- Create headers
    local headerEmoteName = ScrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    headerEmoteName:SetPoint("TOPLEFT", ScrollChild, "TOPLEFT", 10, 0)
    headerEmoteName:SetText("Emote")

    local headerResponseEmote = ScrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    headerResponseEmote:SetPoint("TOP", ScrollChild, "TOP", 0, 0)
    headerResponseEmote:SetText("Response Emote")

    local headerTargetSender = ScrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    headerTargetSender:SetPoint("TOPRIGHT", ScrollChild, "TOPRIGHT", -10, 0)
    headerTargetSender:SetText("Target?")
	

-- Create Emotes within Options Frame
local yOffset = -25
local responseEmoteWidth = 250  -- Width of the responseEmote EditBox
local checkBoxWidth = 30  -- Approximate width of the CheckButton (adjust as needed)



for _, emote in ipairs(sortedEmoteKeys) do
    -- Emote Name
    local emoteName = ScrollChild:CreateFontString(nil, "OVERLAY")
    emoteName:SetFontObject("GameFontNormal")
    emoteName:SetPoint("TOPLEFT", ScrollChild, "TOPLEFT", 10, yOffset)
    emoteName:SetText(emote)

    -- Response Emote EditBox
    local responseEmote = CreateFrame("EditBox", nil, ScrollChild, "InputBoxTemplate")
    responseEmote:SetSize(responseEmoteWidth, 20)
    responseEmote:SetPoint("TOP", ScrollChild, "TOP", 25, yOffset + 5)
    responseEmote:SetAutoFocus(false)
    responseEmote:SetScript("OnEnterPressed", function(self)
        AutoEmoteResponderSettings[emote] = self:GetText()
        self:ClearFocus()
    end)

    -- Target Sender Checkbox
    local targetSender = CreateFrame("CheckButton", nil, ScrollChild, "UICheckButtonTemplate")
    targetSender:SetPoint("TOPRIGHT", ScrollChild, "TOPRIGHT", -10, yOffset + 10)
    targetSender:SetChecked(AutoEmoteResponderSettings[emote .. "TargetSender"] or false)
    targetSender:SetScript("OnClick", function(self)
        AutoEmoteResponderSettings[emote .. "TargetSender"] = self:GetChecked()
    end)
    
    -- Load each field with relevant info
    RefreshOptionsFrame()
    
    -- Give a unique name to responseEmote and targetSender
    AutoEmoteResponder.UIElements["ResponseEmote_" .. emote] = responseEmote
    AutoEmoteResponder.UIElements["TargetSender_" .. emote] = targetSender

    yOffset = yOffset - 30  -- Adjust spacing as needed
end

-- Initialize the close function for OptionsFrame
local function SaveAndCloseOptionsFrame()
    for emote, _ in pairs(search) do
        local responseEmote = AutoEmoteResponder.UIElements["ResponseEmote_" .. emote]
        local targetSender = AutoEmoteResponder.UIElements["TargetSender_" .. emote]

        if responseEmote and targetSender then
            AutoEmoteResponderSettings[emote] = responseEmote:GetText()
            AutoEmoteResponderSettings[emote .. "TargetSender"] = targetSender:GetChecked()
        end
    end
    OptionsFrame:Hide()
end

-- Set the script for hiding the frame to also save the settings
OptionsFrame:SetScript("OnHide", SaveAndCloseOptionsFrame)

return OptionsFrame
	
end


local function OnAddonLoaded()
    for emote, _ in pairs(search) do
        AutoEmoteResponderSettings[emote] = AutoEmoteResponderSettings[emote] or "DefaultResponse"
        AutoEmoteResponderSettings[emote.."TargetSender"] = AutoEmoteResponderSettings[emote.."TargetSender"] or false
    end
    -- Now safe to create the options frame
    AutoEmoteResponder_CreateOptionsFrame()
end

-- Register for events
AutoEmoteResponder.frame:RegisterEvent("CHAT_MSG_TEXT_EMOTE")
AutoEmoteResponder.frame:RegisterEvent("ADDON_LOADED")

-- Event handler function
AutoEmoteResponder.frame:SetScript("OnEvent", function(self, event, msg, player, arg1, arg2, ...)
    if event == "ADDON_LOADED" and arg1 == "AutoEmoteResponder" then
        OnAddonLoaded()
    elseif event == "CHAT_MSG_TEXT_EMOTE" then
        AutoEmoteResponder_OnEvent(self, event, msg, player, arg1, arg2, ...)
    end
end)

-- Slash Command Registration
SLASH_AUTOEMOTES1 = "/autoemote"
SLASH_AUTOEMOTES2 = "/ae"
SLASH_AUTOEMOTESTEST1 = "/aeme"

SlashCmdList["AUTOEMOTES"] = function(msg)
    if AutoEmoteResponderOptionsFrame:IsShown() then
        AutoEmoteResponderOptionsFrame:Hide()
    else
        RefreshOptionsFrame()
        AutoEmoteResponderOptionsFrame:Show()
    end
end

SlashCmdList["AUTOEMOTESTEST"] = function(msg)
    AutoEmoteResponderTest()
end

function AutoEmoteResponderTest()
	SendChatMessage("is testing things", "EMOTE", nil)
end


-- Event handler function for responding to emotes
function AutoEmoteResponder_OnEvent(self, event, msg, player, ...)
    if event == "CHAT_MSG_TEXT_EMOTE" then
        local args = {...}
		local msg1 = args[1]
		local sender = player
		local misc = args[3]
		local meCheck = "me"
        local playerName = UnitName("player")

        -- Check for matching Emote
		if (string.find(msg, "you", 1, true) or string.find(msg, playerName, 1, true) or string.find(msg, "your", 1, true)) then
            for emoteKey, emoteString in pairs(search) do
                if string.find(msg, emoteString, 1, true) then
                    local responseEmote = AutoEmoteResponderSettings[emoteKey]
                    if responseEmote then
						if string.find(responseEmote, "me", 1, true) then
							local meResponse = string.sub(responseEmote, 3, -1)
							if AutoEmoteResponderSettings[emoteKey .. "TargetSender"] then
								local meResponseSender = meResponse
								local mePlayer = {}
								meResponseSender = string.gsub(meResponseSender, "PLAYER", function(mePlayer2) table.insert(mePlayer, mePlayer2) return sender end)
								SendChatMessage(meResponseSender, "EMOTE", nil)
							else
							SendChatMessage(meResponse, "EMOTE", nil)
							end
						elseif AutoEmoteResponderSettings[emoteKey .. "TargetSender"] then
							print(responseEmote .. " sender found")
							DoEmote(responseEmote,sender)
						else
							print(responseEmote .. " no target found")
							DoEmote(responseEmote,"none")
						end
					break
					end
				end
			end
		end
	end
end


function RefreshOptionsFrame()
    for emote, _ in pairs(search) do
        local responseEmote = AutoEmoteResponder.UIElements["ResponseEmote_" .. emote]
        local targetSender = AutoEmoteResponder.UIElements["TargetSender_" .. emote]

        if responseEmote and targetSender then
            -- Only set text and checked state if the settings already exist
            if AutoEmoteResponderSettings[emote] then
                responseEmote:SetText(AutoEmoteResponderSettings[emote])
            end
            if AutoEmoteResponderSettings[emote .. "TargetSender"] ~= nil then
                targetSender:SetChecked(AutoEmoteResponderSettings[emote .. "TargetSender"])
            end
        end
    end
end

-- Create and set up the options frame
local optionsFrame = AutoEmoteResponder_CreateOptionsFrame()
