AddCSLuaFile()

ENT.Type      = "anim"
ENT.Base      = "base_anim"

ENT.PrintName = "Monster Box"
ENT.Category  = "Portal 2"
ENT.Spawnable = true

-- Defaults (Hammer KeyValues can override)
ENT.StartAsBox          = true
ENT.BoxSwitchSpeed      = 1.0   -- multiplier: 2.0 = twice as fast, 0.5 = half speed
ENT.AllowSilentDissolve = false
ENT.BecomeMonsterOnDrop = true

local boxmdl = "models/npcs/monsters/monster_a_box.mdl"
local outmdl = "models/npcs/monsters/monster_a.mdl"

local function clampNumber(n, minv, maxv, fallback)
	n = tonumber(n)
	if not n then return fallback end
	if n < minv then return minv end
	if n > maxv then return maxv end
	return n
end

function ENT:GetTimerName(suffix)
	return ("monsterbox_%d_%s"):format(self:EntIndex(), suffix)
end

function ENT:OnRemove()
	-- Clean up timers
	timer.Remove(self:GetTimerName("to_box"))
	timer.Remove(self:GetTimerName("to_monster"))
	timer.Remove(self:GetTimerName("shortcircuit_done"))
end

-- Hammer KeyValues / Outputs
function ENT:KeyValue(key, value)
	if key == "OnFizzled" then
		self:StoreOutput(key, value)
		return
	end

	if key == "StartAsBox" then
		self.StartAsBox = tobool(value)
	elseif key == "BoxSwitchSpeed" then
		self.BoxSwitchSpeed = clampNumber(value, 0.1, 10, 1.0)
	elseif key == "AllowSilentDissolve" then
		self.AllowSilentDissolve = tobool(value)
	end
end

-- Helpers: physics + animation
function ENT:InitPhysics()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass(120)
		phys:EnableGravity(true)
		phys:EnableDrag(true)
		phys:SetDamping(0.2, 0.2)
		phys:Wake()
	end
end

function ENT:LookupSeq(seqName)
	local seq = self:LookupSequence(seqName)
	if not seq or seq < 0 then return nil end
	return seq
end

function ENT:PlaySeq(seqName, playbackRate)
	local seq = self:LookupSeq(seqName)
	if not seq then return false end

	self:ResetSequence(seq)
	self:SetCycle(0)
	self:SetPlaybackRate(playbackRate or 1)

	return true
end

function ENT:GetSeqDuration(seqName)
	local seq = self:LookupSeq(seqName)
	if not seq then return 0 end

	local dur = self:SequenceDuration(seq)
	if not dur or dur <= 0 then return 0 end

	-- If you ever change playback rate, divide by it. We default to 1.
	local rate = self:GetPlaybackRate()
	if not rate or rate <= 0 then rate = 1 end

	-- BoxSwitchSpeed is a “speed multiplier” for transitions
	local speed = clampNumber(self.BoxSwitchSpeed, 0.1, 10, 1.0)

	return (dur / rate) / speed
end

function ENT:Initialize()
	if CLIENT then return end

	-- Mark so global hooks can identify us without hardcoding classname
	self.IsMonsterBoxEntity = true

	if self.StartAsBox then
		self:SetModel(boxmdl)
		self:InitPhysics()
		self:PlaySeq("hermit_idle", 1)
		self.IsBoxMode = true
	else
		self:SetModel(outmdl)
		self:InitPhysics()
		-- Pick a sane default loop on monster
		self:PlaySeq("idle", 1)
		self.IsBoxMode = false
	end
end

-- Mode changes
function ENT:BecomeBox()
	if not IsValid(self) then return end
	if self.IsBoxMode then
		-- Already box: just ensure loop
		self:PlaySeq("hermit_idle", 1)
		return
	end

	-- We are currently monster model (outmdl). Play hermit_in then swap to box model.
	self:PlaySeq("hermit_in", 1)

	local delay = self:GetSeqDuration("hermit_in")
	if delay <= 0 then delay = 0.1 end

	timer.Create(self:GetTimerName("to_box"), delay, 1, function()
		if not IsValid(self) then return end

		self:SetModel(boxmdl)
		self:InitPhysics()
		self:PlaySeq("hermit_idle", 1)
		self.IsBoxMode = true
	end)
end

function ENT:BecomeMonster()
	if not IsValid(self) then return end
	if not self.IsBoxMode then
		-- Already monster: just ensure loop
		self:PlaySeq("idle", 1)
		return
	end

	-- We are currently box model. Switch to monster model first, then play hermit_out.
	self:SetModel(outmdl)
	self:InitPhysics()

	self:PlaySeq("hermit_out", 1)
	self.IsBoxMode = false

	local delay = self:GetSeqDuration("hermit_out")
	if delay <= 0 then delay = 0.1 end

	timer.Create(self:GetTimerName("to_monster"), delay, 1, function()
		if not IsValid(self) then return end
		self:PlaySeq("idle", 1)
	end)
end

function ENT:DoShortcircuit()
	if not IsValid(self) then return end

	-- shortcircuit exists only on the box model (per your list)
	if not self.IsBoxMode then
		-- If you want: auto-switch to box first, then shortcircuit.
		self:BecomeBox()
		return
	end

	if not self:PlaySeq("shortcircuit", 1) then
		-- Fallback
		self:PlaySeq("hermit_idle", 1)
		return
	end

	local delay = self:GetSeqDuration("shortcircuit")
	if delay <= 0 then delay = 0.5 end

	timer.Create(self:GetTimerName("shortcircuit_done"), delay, 1, function()
		if not IsValid(self) then return end
		-- Return to box idle loop
		self:PlaySeq("hermit_idle", 1)
	end)
end

-- Dissolve (normal + silent)
function ENT:DoDissolve(silent)
	if not IsValid(self) then return end

	if silent then
		if not self.AllowSilentDissolve then return end
		self:TriggerOutput("OnFizzled", self, self)
		self:Remove()
		return
	end

	local dissolver = ents.Create("env_entity_dissolver")
	if not IsValid(dissolver) then
		self:TriggerOutput("OnFizzled", self, self)
		self:Remove()
		return
	end

	dissolver:SetPos(self:GetPos())
	dissolver:Spawn()
	dissolver:Activate()

	local targetName = "monsterbox_dissolve_" .. self:EntIndex()
	self:SetName(targetName)

	dissolver:SetKeyValue("target", targetName)
	dissolver:SetKeyValue("dissolvetype", "0")

	self:TriggerOutput("OnFizzled", self, self)
	dissolver:Fire("Dissolve", targetName, 0)
	dissolver:Fire("Kill", "", 1)
end

-- Inputs from Hammer / other entities
function ENT:AcceptInput(name, activator, caller, data)
	if name == "BecomeBox" then
		self:BecomeBox()
		return true
	elseif name == "BecomeMonster" then
		self:BecomeMonster()
		return true
	elseif name == "BecomeShortcircuit" then
		self:DoShortcircuit()
		return true
	elseif name == "Dissolve" then
		self:DoDissolve(false)
		return true
	elseif name == "SilentDissolve" then
		self:DoDissolve(true)
		return true
	end

	return false
end

-- Global gravgun behavior (defined once; no Think spam, no per-entity hook leaks)
if SERVER then
	hook.Add("GravGunOnPickedUp", "MonsterBox_GravPick", function(ply, ent)
		if not IsValid(ent) or not ent.IsMonsterBoxEntity then return end
		ent:BecomeBox()
	end)

	hook.Add("GravGunOnDropped", "MonsterBox_GravDrop", function(ply, ent)
		if not IsValid(ent) or not ent.IsMonsterBoxEntity then return end
		if ent.BecomeMonsterOnDrop then
			ent:BecomeMonster()
		end
	end)
end
