$imported = {} if $imported.nil?
$imported["YEL-BattleLuna-ActiveBattlerDisplay"] = true
#==============================================================================
# ■ BattleLuna: Active Battler Display
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Show an image of the active actor/battler whenever choosing a command. 
# Based on Etrian Odyssey. 
#==============================================================================
# ■ Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# In Graphics/Picture Folder, set your image filename as ActorName_battler.
#==============================================================================
module LUNA
	module BATTLERDISPLAY
	PICTURE_NUMBER = 1
 end
end

#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================
class Scene_Battle < Scene_Base
  #--------------------------------------------------------------------------
  # * Start Actor Command Selection
  #--------------------------------------------------------------------------
  alias picturebattlers_start_actor_command_selection start_actor_command_selection
  def start_actor_command_selection
    picturebattlers_start_actor_command_selection
    $game_troop.screen.pictures[LUNA::BATTLERDISPLAY::PICTURE_NUMBER].show(BattleManager.actor.name + "_battler", 1, 570, 240, 100.0, 100.0,255, 0)
  end
  #--------------------------------------------------------------------------
  # * Start Turn
  #--------------------------------------------------------------------------
  alias picturebattlers_turn_start turn_start
  def turn_start
    $game_troop.screen.pictures[1].erase if$game_troop.screen.pictures[1]
    picturebattlers_turn_start
  end
end