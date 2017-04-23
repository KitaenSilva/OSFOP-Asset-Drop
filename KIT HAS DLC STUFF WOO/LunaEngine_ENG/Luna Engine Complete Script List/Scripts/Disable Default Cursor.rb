#==============================================================================
# ■ BattleLuna: Disable Default Cursor
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This section disables cursor on very specific windows in battle.
# Set the values to true if you want to disable the cursor.
#==============================================================================

module BattleLuna
  module WINDOWS
    
    # for party commands window
    WINDOW_COMMANDS[:party_commands][:cursor] = false
    # for actor commands window
    WINDOW_COMMANDS[:actor_commands][:cursor] = false
    # for skill window
    WINDOW_GUI[:skill_window][:cursor] = false
    # for item window
    WINDOW_GUI[:item_window][:cursor] = false
    
  end
end

#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================
#==============================================================================
# ■ Window_PartyCommand
#==============================================================================

class Window_PartyCommand < Window_Command
  
  #--------------------------------------------------------------------------
  # alias method: update_cursor
  #--------------------------------------------------------------------------
  alias battle_luna_ddc_update_cursor update_cursor
  def update_cursor
    setting[:cursor] ? battle_luna_ddc_update_cursor : cursor_rect.empty
    ensure_cursor_visible
  end
  
end # Window_PartyCommand

#==============================================================================
# ■ Window_ActorCommand
#==============================================================================

class Window_ActorCommand < Window_Command
  
  #--------------------------------------------------------------------------
  # alias method: update_cursor
  #--------------------------------------------------------------------------
  alias battle_luna_ddc_update_cursor update_cursor
  def update_cursor
    setting[:cursor] ? battle_luna_ddc_update_cursor : cursor_rect.empty
    ensure_cursor_visible
  end
  
end # Window_ActorCommand

#==============================================================================
# ■ Window_BattleSkill
#==============================================================================

class Window_BattleSkill < Window_SkillList
  
  #--------------------------------------------------------------------------
  # alias method: update_cursor
  #--------------------------------------------------------------------------
  alias battle_luna_ddc_update_cursor update_cursor
  def update_cursor
    setting[:cursor] ? battle_luna_ddc_update_cursor : cursor_rect.empty
    ensure_cursor_visible
  end
  
end # Window_BattleSkill

#==============================================================================
# ■ Window_BattleItem
#==============================================================================

class Window_BattleItem < Window_ItemList
  
  #--------------------------------------------------------------------------
  # alias method: update_cursor
  #--------------------------------------------------------------------------
  alias battle_luna_ddc_update_cursor update_cursor
  def update_cursor
    setting[:cursor] ? battle_luna_ddc_update_cursor : cursor_rect.empty
    ensure_cursor_visible
  end
  
end # Window_BattleItem