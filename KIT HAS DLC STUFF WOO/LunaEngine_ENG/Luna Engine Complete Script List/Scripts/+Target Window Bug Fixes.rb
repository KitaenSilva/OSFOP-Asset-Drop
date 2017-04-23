#==============================================================================
# ■ BattleLuna: Enemy Target Window Bug Fixes
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Fixes issues with Enemy Target Window.
#==============================================================================
#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================
class Window_BattleEnemy < Window_Selectable
  #--------------------------------------------------------------------------
  # * Get Enemy Object
  #--------------------------------------------------------------------------
  def enemy ; @data[@index] end
  #--------------------------------------------------------------------------
  # * Draw Item
  #--------------------------------------------------------------------------
  def draw_item(index)
    change_color(normal_color)
    draw_text(item_rect_for_text(index), @data[index].name)
  end    
end