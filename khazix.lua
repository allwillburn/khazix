

if FileExist(COMMON_PATH.."MixLib.lua") then
 require('MixLib')
else
 PrintChat("MixLib not found. Please wait for download.")
 DownloadFileAsync("https://raw.githubusercontent.com/VTNEETS/NEET-Scripts/master/MixLib.lua", COMMON_PATH.."MixLib.lua", function() PrintChat("Downloaded MixLib. Please 2x F6!") return end)
end





require("DamageLib")





GetLevelPoints = function(unit) return GetLevel(unit) - (GetCastLevel(unit,0)+GetCastLevel(unit,1)+GetCastLevel(unit,2)+GetCastLevel(unit,3)) end
local SetDCP, SkinChanger = 0

local KhazixMenu = Menu("Khazix", "Khazix")





KhazixMenu:SubMenu("LaneClear", "LaneClear")
KhazixMenu.LaneClear:Boolean("Q", "Use Q", true)
KhazixMenu.LaneClear:Boolean("W", "Use W", true)
KhazixMenu.LaneClear:Boolean("E", "Use E", true)
KhazixMenu.LaneClear:Boolean("RHydra", "Use RHydra", true)
KhazixMenu.LaneClear:Boolean("Tiamat", "Use Tiamat", true)



OnTick(function (myHero)
	local target = GetCurrentTarget()
        local YGB = GetItemSlot(myHero, 3142)
	local RHydra = GetItemSlot(myHero, 3074)
	local Tiamat = GetItemSlot(myHero, 3077)
        local Gunblade = GetItemSlot(myHero, 3146)
        local BOTRK = GetItemSlot(myHero, 3153)
        local Cutlass = GetItemSlot(myHero, 3144)
        local Randuins = GetItemSlot(myHero, 3143)

	
        
       




      if Mix:Mode() == "LaneClear" then
      	  for _,closeminion in pairs(minionManager.objects) do
	        if KhazixMenu.LaneClear.Q:Value() and Ready(_Q) and ValidTarget(closeminion, 325) then
	        	CastTargetSpell(closeminion, _Q)
                end

                if KhazixMenu.LaneClear.W:Value() and Ready(_W) and ValidTarget(closeminion, 275) then
	        	CastSkillShot(_W, closeminion)
	        end

                if KhazixMenu.LaneClear.E:Value() and Ready(_E) and ValidTarget(closeminion, 700) then
	        	CastSkillShot(_E, closeminion)
	        end

                if KhazixMenu.LaneClear.Tiamat:Value() and ValidTarget(closeminion, 350) then
			CastSpell(Tiamat)
		end
	
		if KhazixMenu.LaneClear.RHydra:Value() and ValidTarget(closeminion, 400) then
                        CastTargetSpell(closeminion, RHydra)
      	        end
          
         end
		
       
     end         
	
end)








print('<font color = "#01DF01"><b>Khazix</b> <font color = "#01DF01">by <font color = "#01DF01"><b>Allwillburn</b> <font color = "#01DF01">Loaded!')




