
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The MOTHERLODE!! Trash", 1594)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	136934, -- Weapons Tester
	134232, -- Hired Assassin
	130488, -- Mech Jockey
	130661, -- Venture Co. Earthshaper
	130635, -- Stonefury
	133345, -- Feckless Assistant
	133593, -- Expert Technician
	133430, -- Venture Co. Mastermind
	133432, -- Venture Co. Alchemist
	130653, -- Wanton Sapper
	136470, -- Refreshment Vendor
	130435, -- Addled Thug
	137029, -- Ordnance Specialist
	134012, -- Taskmaster Askari 
	133463, -- Venture Co. War Machine
	136643  -- Azerite Extractor
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.tester = "Weapons Tester"
	L.assassin = "Hired Assassin"
	L.jockey = "Mech Jockey"
	L.earthshaper = "Venture Co. Earthshaper"
	L.stonefury = "Stonefury"
	L.assistant = "Feckless Assistant"
	L.technician = "Expert Technician"
	L.mastermind = "Venture Co. Mastermind"
	L.alchemist = "Venture Co. Alchemist"
	L.sapper = "Wanton Sapper"
	L.vendor = "Refreshment Vendor"
	L.extractor = "Azerite Extractor"
	L.thug = "Addled Thug"
	L.specialist = "Ordnance Specialist"
	L.taskmaster = "Taskmaster Askari"
	L.warmachine = "Venture Co. War Machine"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Weapons Tester
		{268846, "TANK"}, -- Echo Blade
		268865, -- Force Cannon
		-- Hired Assassin
		269302, -- Toxic Blades
		-- Mech Jockey
		267433, -- Activate Mech
		281621, -- Concussion Charge
		-- Venture Co. Earthshaper
		268709, -- Earth Shield cast
		268710, -- Earth Shield buff
		-- Stonefury
		268702, -- Furious Quake
		263215, -- Tectonic Barrier
		-- Feckless Assistant
		263066, -- Transfiguration Serum
		263103, -- Blowtorch
		-- Expert Technician
		262540, -- Overcharge
		262554, -- Repair
		-- Venture Co. Mastermind
		262947, -- Azerite Injection
		-- Venture Co. Alchemist
		268797, -- Transmute: Enemy to Goo cast
		{268791, "SAY"}, -- Transmute: Enemy to Goo debuff
		-- Wanton Sapper
		269313, -- Final Blast
		268362, -- Mining Charge
		-- Refreshment Vendor
		{280605, "SAY"}, -- Brain Freeze
		280604, -- Iced Spritzer
		268129, -- Kaja'Cola Refresher
		-- Azerite Extractor
		{268415, "TANK"}, -- Power Through
		-- Addled Thug
		262092, -- Inhale Vapors
		-- Ordnance Specialist
		269090, -- Artillery Barrage
		-- Taskmaster Askari
		{263601, "TANK"}, -- Desperate Measures
		-- Venture Co. War Machine
		{269429, "TANK"}, -- Charged Shot

	}, {
		[268846] = L.tester,
		[269302] = L.assassin,
		[267433] = L.jockey,
		[268709] = L.earthshaper,
		[268702] = L.stonefury,
		[263066] = L.assistant,
		[262540] = L.technician,
		[262947] = L.mastermind,
		[268797] = L.alchemist,
		[269313] = L.sapper,
		[280605] = L.vendor,
		[268415] = L.extractor,
		[262092] = L.thug,
		[269090] = L.specialist,
		[263601] = L.taskmaster,
		[269429] = L.warmachine,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_CAST_START", "EchoBlade", 268846)
	self:Log("SPELL_CAST_START", "ForceCannon", 268865)
	self:Log("SPELL_CAST_START", "ToxicBlades", 269302)
	self:Log("SPELL_CAST_START", "ActivateMech", 267433)
	self:Log("SPELL_CAST_START", "ConcussionCharge", 281621)
	self:Log("SPELL_CAST_START", "EarthShield", 268709)
	self:Log("SPELL_AURA_APPLIED", "EarthShieldApplied", 268710)
	self:Log("SPELL_CAST_START", "FuriousQuake", 268702)
	self:Log("SPELL_CAST_START", "TectonicBarrier", 263215)
	self:Log("SPELL_AURA_APPLIED", "TectonicBarrierApplied", 263215)
	self:Log("SPELL_CAST_START", "TransfigurationSerum", 263066)
	self:Log("SPELL_CAST_START", "Blowtorch", 263103)
	self:Log("SPELL_CAST_START", "Overcharge", 262540)
	self:Log("SPELL_AURA_APPLIED", "OverchargeApplied", 262540)
	self:Log("SPELL_CAST_START", "Repair", 262554)
	self:Log("SPELL_AURA_APPLIED", "AzeriteInjectionApplied", 262947)
	self:Log("SPELL_CAST_START", "TransmuteEnemyToGoo", 268797)
	self:Log("SPELL_AURA_APPLIED", "TransmuteEnemyToGooApplied", 268791)
	self:Log("SPELL_AURA_REMOVED", "TransmuteEnemyToGooRemoved", 268791)
	self:Log("SPELL_CAST_START", "FinalBlast", 269313)
	self:Log("SPELL_CAST_SUCCESS", "MiningCharge", 268362)
	self:Log("SPELL_CAST_START", "IcedSpritzer", 280604)
	self:Log("SPELL_CAST_START", "KajacolaRefresher", 268129)
	self:Log("SPELL_AURA_APPLIED", "BrainFreezeApplied", 280605)
	self:Log("SPELL_AURA_REMOVED", "BrainFreezeRemoved", 280605)
	self:Log("SPELL_CAST_SUCCESS", "PowerThrough", 268415)
	self:Log("SPELL_CAST_START", "InhaleVapors", 262092)
	self:Log("SPELL_CAST_START", "ArtilleryBarrage", 269090)
	self:Log("SPELL_AURA_APPLIED", "DesperateMeasuresApplied", 263601)
	self:Log("SPELL_CAST_START", "ChargedShot", 269429)

	self:Log("SPELL_DAMAGE", "StonefuryInteract", "*")
	self:Log("SWING_DAMAGE", "StonefuryInteract", "*")
	self:Log("SPELL_AURA_APPLIED", "StonefuryAuraApplied", "*")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Weapons Tester
function mod:EchoBlade(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "watchstep")
end

function mod:ForceCannon(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "watchstep")
end

-- Hired Assassin
function mod:ToxicBlades(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

-- Mech Jockey
function mod:ActivateMech(args)
	self:Message2(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

function mod:ConcussionCharge(args)
	self:Message2(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info", "watchstep")
end

-- Venture Co. Earthshaper
function mod:EarthShieldApplied(args)
	if not UnitIsPlayer(args.destName) then
		self:Message2(args.spellId, "red", CL.other:format(args.spellName, args.destName))
		if self:Dispeller("magic", true) then
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:EarthShield(args)
	self:Message2(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

-- Stonefury
do
	local engagedStonefury = {}
	function mod:StonefuryInteract(args)
		if self:MobId(args.sourceGUID) == 130635 then
			engagedStonefury[args.sourceGUID] = true
		elseif self:MobId(args.destGUID) == 130635 then
			engagedStonefury[args.destGUID] = true
		end
	end

	function mod:StonefuryAuraApplied(args)
		local destGUID = args.destGUID
		if self:MobId(destGUID) == 130635 and args.sourceGUID ~= destGUID then
			engagedStonefury[destGUID] = true
		end
	end

	function mod:FuriousQuake(args)
		if engagedStonefury[args.sourceGUID] then
			self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning", "interrupt")
		end
	end
end

do
	local prev = 0
	function mod:TectonicBarrier(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message2(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "warning", "interrupt")
		end
	end
end

function mod:TectonicBarrierApplied(args)
	if not UnitIsPlayer(args.destName) then
		self:Message2(args.spellId, "red", CL.other:format(args.spellName, args.destName))
		if self:Dispeller("magic", true) then
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Feckless Assistant
function mod:TransfigurationSerum(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

function mod:Blowtorch(args)
	self:Message2(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
end

-- Expert Technician
function mod:Overcharge(args)
	self:Message2(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

function mod:Repair(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
end

function mod:OverchargeApplied(args)
	if not UnitIsPlayer(args.destName) then
		self:Message2(args.spellId, "yellow", CL.other:format(args.spellName, args.destName))
		if self:Dispeller("magic", true) then
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Venture Co. Mastermind
function mod:AzeriteInjectionApplied(args)
	if not UnitIsPlayer(args.destName) then
		self:Message2(args.spellId, "red", CL.other:format(args.spellName, args.destName))
		if self:Dispeller("magic", true) then
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

-- Venture Co. Alchemist
function mod:TransmuteEnemyToGoo(args)
	self:Message2(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
	self:TargetBar(args.spellId, 10, args.destName)
end

function mod:TransmuteEnemyToGooApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessage2(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:TransmuteEnemyToGooRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

-- Wanton Sapper
do
	local prev = 0
	function mod:FinalBlast(args)
		local t = args.time
		if t-prev > 1.5 then
			prev = t
			self:Message2(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
	end

	function mod:MiningCharge(args)
		self:Message2(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "info", "watchstep")
	end

end

-- Refreshment Vendor
function mod:BrainFreezeApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessage2(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
		self:TargetBar(args.spellId, 6, args.destName)
	end
end

function mod:BrainFreezeRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:IcedSpritzer(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
end

function mod:KajacolaRefresher(args)
	self:Message2(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

-- Azerite Extractor
function mod:PowerThrough(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm", "watchstep")
end

-- Addled Thug
function mod:InhaleVapors(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm", "interrupt")
end

-- Ordnance Specialist
function mod:ArtilleryBarrage(args)
	self:Message2(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm", "interrupt")
end

-- Taskmaster Askari
function mod:DesperateMeasuresApplied(args)
	if not UnitIsPlayer(args.destName) then
		self:Message2(args.spellId, "red", CL.other:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Venture Co. War Machine
function mod:ChargedShot(args)
	self:Message2(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm")
end