#==============================================================================
# ■ Different Windowskins for Map and Battles
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This scriptlet allows you to have different windowskins for battle and 
# map. Just in case you need it that way.
#==============================================================================
module LUNA
	module WINSKIN
	# This is the Windowskin for the rest of the game.
	MENU_SKIN = "Window"
	
	# This is the Windowskin when in battle.
	BATTLE_SKIN = "Window" #"Window2"
 end
end
	
class Window_Base < Window
 
  alias quick_add_on_bessy_initialize initialize
  def initialize(x, y, width, height)
    quick_add_on_bessy_initialize(x, y, width, height)
		mskin = LUNA::WINSKIN::MENU_SKIN
    self.windowskin = SceneManager.scene_is?(Scene_Battle) ? battle_windowskin : Cache.system(mskin) 
  end


  def battle_windowskin
	Cache.system(LUNA::WINSKIN::BATTLE_SKIN)
  end
  
end