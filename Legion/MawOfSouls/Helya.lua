
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Helya", 1042, 1663)
if not mod then return end
mod:RegisterEnableMob(96759)
mod.engageId = 1824

--------------------------------------------------------------------------------
-- Locals
--

local firstTorrent = 0
local afterCorrupted = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{197262, "SAY"}, -- Taint of the Sea
		198495, -- Torrent
		227233, -- Corrupted Below
		196947, -- Submerged
		202088, -- Brackwater Barrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TaintOfTheSea", 197262)
	self:Log("SPELL_CAST_START", "Submerged", 196947)
	self:Log("SPELL_CAST_START", "Torrent", 198495)
	self:Log("SPELL_CAST_START", "CorruptedBelow", 227233)
	self:Log("SPELL_CAST_START", "BrackwaterBarrage", 202088)
end

function mod:OnEngage()
	afterCorrupted = 0
	firstTorrent = 0
 	self:CDBar(202088, 40.5) -- Brackwater Barrage
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TaintOfTheSea(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alert", nil, nil, self:Dispeller("magic"))
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

function mod:Submerged(args)
	self:StopBar(198495) -- Torrent
	firstTorrent = 0
end

function mod:Torrent(args)
	self:CDBar(args.spellId, afterCorrupted == 0 and 11 or 13.5)

	if firstTorrent == 0 then
		self:CDBar(196947, 59, 196947, 20585) -- Wisp Icon for intermission phase / spell_nature_wispsplode / icon 136116
	end

	firstTorrent = 1
	afterCorrupted = 0
	self:Message(args.spellId, "Important", "Warning", CL.incoming:format(args.spellName))
end

function mod:CorruptedBelow()
	afterCorrupted = 1
end

function mod:BrackwaterBarrage(args)
	self:TargetMessage(args.spellId, "Urgent", "Info")
end

