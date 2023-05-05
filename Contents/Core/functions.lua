-- File: Functions.lua
-- What's for: We use this file for the functions of the addon.

-- get the version from the toc file (tag: #Version)
local BLESSING_CURRENT_VERSION = GetAddOnMetadata("Blessing", "Version");

-- get the description from the toc file (tag: #Notes)
local BLESSING_DESCRIPTION = GetAddOnMetadata("Blessing", "Notes");

local BlessingCommand = CreateFrame("Frame");

BlessingCommand:RegisterEvent("ADDON_LOADED");

-- Slash Commands
SLASH_BLESSINGCMD1 = '/blessing';
SLASH_BLESSINGCMD2 = '/bsg';


-- Slash command arguments dectection
function SlashCmdList.BLESSINGCMD(msg, editbox)
   --Since there is a sensitive case detection, we convert
	-- everything in lowercase
	if (msg ~= nil) then
	   msg = string.lower(msg);
	end
	
	if (msg == "help") then
	   print("/bsg help -----------------------------------------");
		print("You can use either /blessing or /bsg as main command.");
	   print("/bsg version: Display the version of this addon.");
		print("/bsg description: Display the description of this addon.");
		print("/bsg isEnable: Check if the addon is enabled or not.");
		print("/bsg enable/on: Enable Blessing.");
		print("/bsg disable/off: Disable Blessing.");
		print("/bsg ui: Display the window settings.");
		print("----------------------------------------- /bsg help");
	
	-- display the version of the addon
	elseif (msg == "version") then
	   print("Blessing version: " .. BLESSING_CURRENT_VERSION);
	
	elseif (msg == "description") then
	   print("Blessing\'s description: " .. BLESSING_DESCRIPTION);
	
	elseif (msg == "isenable") or (msg == "isenabled") then
	   print("Is Blessing enabled? " .. BlessingPrefs["BlessingEnable"]);
	
	elseif (msg == "enable") or (msg == "on") then
	   BlessingFunctionEnable();
	elseif (msg == "disable") or (msg == "off") then
	   BlessingFunctionDisable();
	
	elseif (msg == "ui") then
	   InterfaceOptionsFrame_OpenToCategory(Blessing.panel);
		-- we have to do it a second time, since the first time it won't
		-- open the good panel...
		InterfaceOptionsFrame_OpenToCategory(Blessing.panel);
	
	else

	end
		
end
-- end function SlashCmdList_BLESSING

-- Enable addon, only if the option is on
function BlessingFunctionEnable()
	BlessingPrefs['BlessingEnable'] = "yes";
	print("Blessing enabled");
end

-- Disable addonn only if the option if off
function BlessingFunctionDisable()
	BlessingPrefs['BlessingEnable'] = "no";
	print("Blessing disabled");
end



-- Loading
function BlessingCommand:OnEvent(event)
	-- when addons are loaded
		if (event == "ADDON_LOADED") then
				-- initialization
				if (BLESSING_VERSION == nil) then
						BLESSING_VERSION = BLESSING_CURRENT_VERSION;
				end
				
				if (BlessingPrefs == nil) then
						print("Initialization");
						BlessingDefaultLoadingPrefsEnable();
				end
				-- initialization over
				
				-- is the user had an old version?
				-- Check if we have to update some old variables.
				if (BLESSING_VERSION ~= BLESSING_CURRENT_VERSION) then
						-- we clean everything
						print("Updating saved variables...");
						BlessingFunctionUpdateSavedVariables();
						print("Updating terminated");
				end
				
				-- just a simple text to make the user aware that everything
				-- is loaded and and how to use the addon
				if (BlessingVarTmp == nil) then
						BlessingVarTmp = 1;
						print("Blessing Loaded - use \'/blessing help\' for more help");
				end
				
					
					
		end -- ((event == "ADDON_LOADED")
end -- function BlessingCommand:OnEvent



-- put Blessing with the default mode, everything is enabled
function BlessingDefaultLoadingPrefsEnable()
   BlessingPrefs = {
		['BlessingEnable'] = "yes",
		['BlessingLanguage'] = "enUS",
	};
   print("Blessing \"default\" mode activated");
end

function BlessingDefaultLoadingPrefsDisable()
   BlessingPrefs = {
		['BlessingEnable'] = "no",
		['BlessingLanguage'] = "enUS",
	};
   --print("Blessing \"default\" mode activated");
end

function BlessingCommand:OnEvent(event)
   -- When addon is loaded
	if (event == "ADDON_LOADED") then
	   if (BLESSING_VERSION == nil) then
		   BLESSING_VERSION = BLESSING_CURRENT_VERSION
		end
		
		if (BlessingPrefs == nil) then
		   print("Blessing: Initialization...");
			BlessingDefaultLoadingPrefsEnable();
		end
	end -- (event == "ADDON_LOADED")
end -- function BlessingCommand:OnEvent



BlessingCommand:SetScript("OnEvent", BlessingCommand.OnEvent);
