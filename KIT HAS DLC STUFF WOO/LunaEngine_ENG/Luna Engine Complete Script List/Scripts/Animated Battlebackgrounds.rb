#==============================================================================
# ■ BattleLuna: Animated Battlebaks
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Adds an Enemy HP Bar whenever you select an enemy target.
# Put all the images in Graphics/System
#==============================================================================
# ■ Lunatic Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Name your battleback file name like this:
# [SCROLL X Y]YourFileName
# with X is scroll speed X
# with Y is scroll speed Y
# X, Y can be negative: [SCROLL -1 -5]YourFileName
#==============================================================================

#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================

#==============================================================================
# ■ Plane
#==============================================================================

class Plane
  
  #--------------------------------------------------------------------------
  # check method: update
  #--------------------------------------------------------------------------
  unless Plane.instance_methods.include?(:update)
  def update
  end
  end
  
end # Plane

#==============================================================================
# ■ Spriteset_Battle
#==============================================================================

class Spriteset_Battle
  
  #--------------------------------------------------------------------------
  # alias method: create_battleback1
  #--------------------------------------------------------------------------
  alias battle_luna_scrbb_create_battleback1 create_battleback1
  def create_battleback1
    if battleback1_name =~ /\[SCROLL (-?\d+) (-?\d+)\](.*)/i
      create_scroll_battleback1($1.to_i, $2.to_i)
    else
      battle_luna_scrbb_create_battleback1
    end
  end
  
  #--------------------------------------------------------------------------
  # new method: create_scroll_battleback1
  #--------------------------------------------------------------------------
  def create_scroll_battleback1(scroll_x, scroll_y)
    @back1_sprite = Plane.new(@viewport1)
    @back1_sprite.bitmap = battleback1_bitmap
    @back1_sprite.z = 0
    @back1_scroll = [scroll_x, scroll_y]
  end
  
  #--------------------------------------------------------------------------
  # alias method: create_battleback2
  #--------------------------------------------------------------------------
  alias battle_luna_scrbb_create_battleback2 create_battleback2
  def create_battleback2
    if battleback2_name =~ /\[SCROLL (\d+) (\d+)\](.*)/i
      create_scroll_battleback2($1.to_i, $2.to_i)
    else
      battle_luna_scrbb_create_battleback2
    end
  end
  
  #--------------------------------------------------------------------------
  # new method: create_scroll_battleback2
  #--------------------------------------------------------------------------
  def create_scroll_battleback2(scroll_x, scroll_y)
    @back2_sprite = Plane.new(@viewport1)
    @back2_sprite.bitmap = battleback2_bitmap
    @back2_sprite.z = 1
    @back2_scroll = [scroll_x, scroll_y]
  end
  
  #--------------------------------------------------------------------------
  # alias method: update_battleback1
  #--------------------------------------------------------------------------
  alias battle_luna_scrbb_update_battleback1 update_battleback1
  def update_battleback1
    battle_luna_scrbb_update_battleback1
    return unless @back1_sprite.is_a?(Plane)
    @back1_sprite.ox += @back1_scroll[0]
    @back1_sprite.oy += @back1_scroll[1]
  end

  #--------------------------------------------------------------------------
  # alias method: update_battleback2
  #--------------------------------------------------------------------------
  alias battle_luna_scrbb_update_battleback2 update_battleback2
  def update_battleback2
    battle_luna_scrbb_update_battleback1
    return unless @back2_sprite.is_a?(Plane)
    @back2_sprite.ox += @back2_scroll[0]
    @back2_sprite.oy += @back2_scroll[1]
  end
  
end # Spriteset_Battle