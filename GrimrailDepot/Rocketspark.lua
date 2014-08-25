
--------------------------------------------------------------------------------
-- Module Declaration
--

if not BigWigs.isWOD then return end -- XXX compat
local mod, CL = BigWigs:NewBoss("Rocketspark and Borka", 993, 1138)
mod:RegisterEnableMob(77816, 77803) -- Borka, Rocketspark

--------------------------------------------------------------------------------
-- Locals
--

local deathCount = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.enrage = "Enrage"
	L.enrage_desc = "When Rocketspark or Borka is killed, the other will enrage."
	L.enrage_icon = 26662
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		161090, 161087, "enrage", "bosskill",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_CAST_START", "MadDash", 161090)
	self:Log("SPELL_CAST_START", "Slam", 161087)

	self:Death("Deaths", 74787, 7803) -- Borka, Rocketspark
end

function mod:OnEngage()
	deathCount = 0
	self:CDBar(161090, 29.5) -- Mad Dash
end

--------------------------------------------------------------------------------
-- Event Handlers
--


function mod:MadDash(args)
	self:Message(args.spellId, "Important", "Alert")
	self:CDBar(args.spellId, 43)
	self:Bar(args.spellId, 3, CL.cast:format(args.spellName))
end

function mod:Slam(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.incoming:format(args.spellName))
end

function mod:Deaths(args)
	deathCount = deathCount + 1
	if deathCount > 1 then
		self:Win()
	else
		if args.mobId == 74787 then -- Borka
			self:StopBar(161090) -- Mad Dash
			self:Message("enrage", "Attention", "Info", CL.other:format(self:SpellName(26662), (EJ_GetSectionInfo(9430))), 26662)
		else -- Rocketspark
			self:Message("enrage", "Attention", "Info", CL.other:format(self:SpellName(26662), (EJ_GetSectionInfo(9433))), 26662)
		end
	end
end
