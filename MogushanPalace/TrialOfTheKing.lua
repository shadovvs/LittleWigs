
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Trial of the King", 885, 708)
-- Xin the Weaponmaster, Haiyan the Unstoppable, Ming the Cunning, Kuai the Brute, Mu'Shiba
mod:RegisterEnableMob(61884, 61445, 61444, 61442, 61453)

local canEnable = true

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	--A Saurok runs down a hidden set of stairs with some of the treasure!
	L.win_emote = "treasure"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
	119922, {"ej:6017", "ICON"},
	{"ej:6024", "ICON"}, {"ej:6025", "ICON", "SAY", "FLASHSHAKE"}, "ej:6026",
	"bosskill",
	}, {
	[119922] = "ej:6015", --Kuai
	["ej:6024"] = "ej:6023", --Haiyan
	bosskill = "general",
	}
end

function mod:VerifyEnable()
	return canEnable
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TraumaticBlow", 123655)

	self:Log("SPELL_AURA_APPLIED", "Ravage", 119946)
	self:Log("SPELL_AURA_REMOVED", "RavageOver", 119946)

	self:Log("SPELL_AURA_APPLIED", "Conflag", 120160)
	self:Log("SPELL_AURA_REMOVED", "ConflagOver", 120160)

	self:Log("SPELL_CAST_START", "Shockwave", 119922)

	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Log("SPELL_DAMAGE", "MeteorHit", 120196)
	self:Log("SPELL_MISSED", "MeteorHit", 120196)

	self:Emote("Win", L["win_emote"])
end

function mod:OnWin()
	canEnable = false
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TraumaticBlow(player, spellId, _, _, spellName)
	if self:Healer() then
		self:TargetMessage("ej:6026", spellName, player, "Positive", spellId)
		self:Bar("ej:6026", CL["other"]:format(spellName, player), 5, spellId)
	end
end

function mod:Ravage(player, spellId, _, _, spellName)
	self:TargetMessage("ej:6017", spellName, player, "Attention", spellId)
	self:Bar("ej:6017", CL["other"]:format(spellName, player), 11, spellId)
	self:PrimaryIcon("ej:6017", player)
end

function mod:RavageOver()
	self:PrimaryIcon("ej:6017")
end

function mod:Conflag(player, spellId, _, _, spellName)
	self:TargetMessage("ej:6024", spellName, player, "Attention", spellId)
	self:Bar("ej:6024", CL["other"]:format(spellName, player), 5, spellId)
	self:SecondaryIcon("ej:6024", player)
end

function mod:ConflagOver()
	self:SecondaryIcon("ej:6024")
end

function mod:Shockwave(_, spellId, _, _, spellName)
	self:Message(spellId, CL["cast"]:format(spellName), "Urgent", spellId, "Alarm")
	self:Bar(spellId, CL["cast"]:format(spellName), 2, spellId)
end

--|TInterface\\Icons\\spell_fire_meteorstorm.blp:20|tHaiyan the Unstoppable targets |cFFFF0000PLAYER|r with a |cFFFF0000|Hspell:120195|h[Meteor]|h|r!
function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, player)
	if msg:find("meteorstorm") then
		local meteor = GetSpellInfo(120195)
		self:TargetMessage("ej:6025", meteor, player, "Important", 120195, "Alert")
		self:PrimaryIcon("ej:6025", player)
		if UnitIsUnit(player, "player") then
			self:FlashShake("ej:6025")
			self:Say("ej:6025", CL["say"]:format(meteor))
			self:Bar("ej:6025", CL["you"]:format(meteor), 5, 120195)
		else
			self:Bar("ej:6025", CL["other"]:format(meteor, player), 5, 120195)
		end
	end
end

function mod:MeteorHit()
	self:PrimaryIcon("ej:6025")
end
