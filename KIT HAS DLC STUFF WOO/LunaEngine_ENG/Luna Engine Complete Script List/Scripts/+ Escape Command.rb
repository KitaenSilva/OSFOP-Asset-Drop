#==============================================================================
# ■ BattleLuna: Escape Command Settings
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This script allows you to change how escape works.
# :party indicates that the entire party's 
# :actor indicates you want it as an individual actor turn.
#==============================================================================
$imported = {} if $imported.nil?
$imported["YEL-BattleEscapeCommand"] = true

module BattleLuna
  module Addon
    ESCAPE_COMMAND = { # Begin ESCAPE_COMMAND
      :usage       => :actor,     # Set to :party if you want skip party turn.
                                  # Set to :actor to treat escape as an action.
    } # End ESCAPE_COMMAND
  end # Addon
end # BattleLuna

#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================

#==============================================================================
# ■ Game_Action
#==============================================================================

class Game_Action
  
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_accessor :escape
  
  #--------------------------------------------------------------------------
  # alias method: valid?
  #--------------------------------------------------------------------------
  alias battle_luna_ec_valid? valid?
  def valid?
    battle_luna_ec_valid? || @escape
  end
  
  #--------------------------------------------------------------------------
  # alias method: clear
  #--------------------------------------------------------------------------
  alias battle_luna_ec_clear clear
  def clear
    battle_luna_ec_clear
    @escape = false
  end
  
end # Game_Action

#==============================================================================
# ■ Window_ActorCommand
#==============================================================================

class Window_ActorCommand < Window_Command
  
  #--------------------------------------------------------------------------
  # alias method: make_command_list
  #--------------------------------------------------------------------------
  alias battle_luna_ec_make_command_list make_command_list
  def make_command_list
    return unless @actor
    battle_luna_ec_make_command_list
    add_escape_command
  end
  
  #--------------------------------------------------------------------------
  # new method: add_escape_command
  #--------------------------------------------------------------------------
  def add_escape_command
    add_command(Vocab::escape, :escape, BattleManager.can_escape?)
  end
  
end # Window_ActorCommand

#==============================================================================
# ■ Scene_Battle
#==============================================================================

class Scene_Battle < Scene_Base
  
  #--------------------------------------------------------------------------
  # alias method: create_actor_command_window
  #--------------------------------------------------------------------------
  alias battle_luna_ec_create_actor_command_window create_actor_command_window
  def create_actor_command_window
    battle_luna_ec_create_actor_command_window
    @actor_command_window.set_handler(:escape, method(:command_luna_escape))
  end
  
  #--------------------------------------------------------------------------
  # new method: command_luna_escape
  #--------------------------------------------------------------------------
  def command_luna_escape
    party_escape = BattleLuna::Addon::ESCAPE_COMMAND[:usage] == :party
    if party_escape
      command_escape
    else
      BattleManager.actor.input.clear
      BattleManager.actor.input.escape = true
      next_command
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: execute_action
  #--------------------------------------------------------------------------
  alias battle_luna_ec_execute_action execute_action
  def execute_action
    current_action = @subject.current_action
    if current_action.item.nil? && current_action.escape
      BattleManager.process_escape
    else
      battle_luna_ec_execute_action
    end
  end
  
end # Scene_Battle