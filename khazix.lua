

if FileExist(COMMON_PATH.."MixLib.lua") then
 require('MixLib')
else
 PrintChat("MixLib not found. Please wait for download.")
 DownloadFileAsync("https://raw.githubusercontent.com/VTNEETS/NEET-Scripts/master/MixLib.lua", COMMON_PATH.."MixLib.lua", function() PrintChat("Downloaded MixLib. Please 2x F6!") return end)
end


if GetObjectName(GetMyHero()) ~= "Khazix" then return end


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



KhazixMenu:SubMenu("KillSteal", "KillSteal")
KhazixMenu.KillSteal:Boolean("Q", "KS w Q", true)
KhazixMenu.KillSteal:Boolean("W", "KS w W", true)
KhazixMenu.KillSteal:Boolean("E", "KS w E", true)

KhazixMenu:SubMenu("AutoIgnite", "AutoIgnite")
KhazixMenu.AutoIgnite:Boolean("Ignite", "Ignite if killable", true)

KhazixMenu:SubMenu("Drawings", "Drawings")
KhazixMenu.Drawings:Boolean("DQ", "Draw Q Range", true)

KhazixMenu:SubMenu("SkinChanger", "SkinChanger")
KhazixMenu.SkinChanger:Boolean("Skin", "UseSkinChanger", true)
KhazixMenu.SkinChanger:Slider("SelectedSkin", "Select A Skin:", 1, 0, 4, 1, function(SetDCP) HeroSkinChanger(myHero, SetDCP)  end, true)

OnTick(function (myHero)
	local target = GetCurrentTarget()
        local YGB = GetItemSlot(myHero, 3142)
	local RHydra = GetItemSlot(myHero, 3074)
	local Tiamat = GetItemSlot(myHero, 3077)
        local Gunblade = GetItemSlot(myHero, 3146)
        local BOTRK = GetItemSlot(myHero, 3153)
        local Cutlass = GetItemSlot(myHero, 3144)
        local Randuins = GetItemSlot(myHero, 3143)

	
        
       


         --AUTO IGNITE
	for _, enemy in pairs(GetEnemyHeroes()) do
		
		if GetCastName(myHero, SUMMONER_1) == 'SummonerDot' then
			 Ignite = SUMMONER_1
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end

		elseif GetCastName(myHero, SUMMONER_2) == 'SummonerDot' then
			 Ignite = SUMMONER_2
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end
		end

	end

        for _, enemy in pairs(GetEnemyHeroes()) do
                
                if IsReady(_Q) and ValidTarget(enemy, 325) and KhazixMenu.KillSteal.Q:Value() and GetHP(enemy) < getdmg("Q",enemy) then
		         if target ~= nil then 
                                      CastTargetSpell(target, _Q)
		         end
                end 
                
                if IsReady(_W) and ValidTarget(enemy, 275) and KhazixMenu.KillSteal.W:Value() and GetHP(enemy) < getdmg("W",enemy) then
		                      CastSkillShot(_W, target)

                if IsReady(_E) and ValidTarget(enemy, 700) and KhazixMenu.KillSteal.E:Value() and GetHP(enemy) < getdmg("E",enemy) then
		                      CastSkillShot(_E, target)
  
                end
      end

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

OnDraw(function (myHero)
        
         if KhazixMenu.Drawings.DE:Value() then
		DrawCircle(GetOrigin(myHero), 700, 0, 200, GoS.Black)
	end

end)





local function SkinChanger()
	if KhazixMenu.SkinChanger.UseSkinChanger:Value() then
		if SetDCP >= 0  and SetDCP ~= GlobalSkin then
			HeroSkinChanger(myHero, SetDCP)
			GlobalSkin = SetDCP
		end
        end
end


print('<font color = "#01DF01"><b>Khazix</b> <font color = "#01DF01">by <font color = "#01DF01"><b>Allwillburn</b> <font color = "#01DF01">Loaded!')




