#==============================================================================
# ■ BattleLuna: Disable Party Commands Window
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Enables/Disables Fight/Escape Window.
#==============================================================================
$imported = {} if $imported.nil?
$imported["YEL-DisablePartyCommands"] = true

#==============================================================================
# ■ BattleLuna
#==============================================================================

module BattleLuna
  module Addon
    PARTY_COMMANDS = {
      :enable      => true,  # Set to false if you want it disabled.
    }
  end
end

#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================

class Scene_Battle < Scene_Base
  
  def prior_command
    if BattleManager.prior_command
      start_actor_command_selection
    else
      start_party_command_selection if BattleLuna::Addon::PARTY_COMMANDS[:enable]
      command_fight unless BattleLuna::Addon::PARTY_COMMANDS[:enable]
    end
  end
  
end # Scene_Battle