#==============================================================================
# ■ BattleLuna: Horizontal Rows
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This changes how many command per row will be displayed horizontally.
#==============================================================================
module LUNA
	module ROWCT
	ITEMROW = 3
 end
end

#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================
#==============================================================================
# ■ Window_ActorCommand
#==============================================================================
class Window_ActorCommand < Window_Command
  #--------------------------------------------------------------------------
  # overwrite method: col_max
  #--------------------------------------------------------------------------
  def col_max
    [setting[:vertical] ? 1 : item_per_row, 1].max
  end
 
  def item_per_row
    LUNA::ROWCT::ITEMROW
  end
end  
