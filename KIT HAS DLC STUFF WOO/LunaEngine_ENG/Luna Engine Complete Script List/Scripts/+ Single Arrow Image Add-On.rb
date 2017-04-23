#==============================================================================
# ■ BattleLuna: Customize Skill/Item List Add-On
#==============================================================================
# This script is to display a single image for the arrow keys/scrollbar.
# It is not required and only should be added if you need it.
#==============================================================================
#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================

class Window_BattleItem < Window_ItemList
  #--------------------------------------------------------------------------
  # new method: update_custom_arrow
  #--------------------------------------------------------------------------
  def update_custom_arrow
    return if @arrow_sprite_up.nil? || @arrow_sprite_down.nil?
    return if BattleLuna::Addon::ITEM_WINDOW[:arrow][:filename] == ""
    self.arrows_visible = false
    #---
    setting = BattleLuna::Addon::ITEM_WINDOW[:arrow]
    @arrow_sprite_up.x = self.x + setting[:offset_x_up]
    @arrow_sprite_up.y = self.y + setting[:offset_y_up]
    @arrow_sprite_up.z = self.z
    @arrow_sprite_down.x = self.x + setting[:offset_x_down]
    @arrow_sprite_down.y = self.y + setting[:offset_y_down]
    @arrow_sprite_down.z = self.z
    @arrow_sprite_up.visible = true#self.top_row > 0
    @arrow_sprite_down.visible = self.item_max > 1
  end
  #--------------------------------------------------------------------------
  # new method: refresh_arrow
  #--------------------------------------------------------------------------
  def refresh_arrow
    arrow = BattleLuna::Addon::ITEM_WINDOW[:arrow][:filename]
    bitmap = Cache.system(arrow)
    width = bitmap.width
    height = bitmap.height
    @arrow_sprite_up = Sprite.new(self.viewport)
    @arrow_sprite_up.bitmap = Bitmap.new(32, 32)#Cache.system(arrow)
    @arrow_sprite_up.visible = false
    @arrow_sprite_down = Sprite.new(self.viewport)
    @arrow_sprite_down.bitmap = Cache.system(arrow)
    @arrow_sprite_down.visible = false
  end
end
class Window_BattleSkill < Window_SkillList
    #--------------------------------------------------------------------------
  # new method: update_custom_arrow
  #--------------------------------------------------------------------------
  def update_custom_arrow
    return if @arrow_sprite_up.nil? || @arrow_sprite_down.nil?
    return if BattleLuna::Addon::SKILL_WINDOW[:arrow][:filename] == ""
    self.arrows_visible = false
    #---
    setting = BattleLuna::Addon::SKILL_WINDOW[:arrow]
    @arrow_sprite_up.x = self.x + setting[:offset_x_up]
    @arrow_sprite_up.y = self.y + setting[:offset_y_up]
    @arrow_sprite_up.z = self.z - 1
    @arrow_sprite_down.x = self.x + setting[:offset_x_down]
    @arrow_sprite_down.y = self.y + setting[:offset_y_down]
    @arrow_sprite_down.z = self.z - 1
    @arrow_sprite_up.visible = true
    @arrow_sprite_down.visible = self.item_max > 1
  end
  #--------------------------------------------------------------------------
  # new method: refresh_arrow
  #--------------------------------------------------------------------------
  def refresh_arrow
    arrow = BattleLuna::Addon::SKILL_WINDOW[:arrow][:filename]
    bitmap = Cache.system(arrow)
    width = bitmap.width
    height = bitmap.height
    @arrow_sprite_up = Sprite.new(self.viewport)
    @arrow_sprite_up.bitmap = Bitmap.new(32, 32)#Cache.system(arrow)
    @arrow_sprite_up.visible = false
    @arrow_sprite_down = Sprite.new(self.viewport)
    @arrow_sprite_down.bitmap = Cache.system(arrow)
    @arrow_sprite_down.visible = false
  end
end