#==============================================================================
# ■ BattleLuna: Customize Skill/Item List
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This is allows you to customize the skill/item list in battle. Such as
# changing the amount of columns, adds arrow(s) when you have a lot of in the
# list, etc.
#==============================================================================

$imported = {} if $imported.nil?
$imported["YEL-BattleItemList"] = true

module BattleLuna
  module Addon
# -----------------------------------------------------------------
# This section modifies Skill Window's List.
# -----------------------------------------------------------------
    SKILL_WINDOW = { 
      :col_max     => 2,		# Maximum amount of Columns.
      :item_height => 24,		# Height of each item displayed.
      :arrow       => { 	  # Adds an arrow when there's too many items. 
        :filename  => "Menu_Arrows", # Set to "" to disable
        :offset_x_up  => 0,
        :offset_y_up  => 0,
        :offset_x_down  => 0,
        :offset_y_down  => 0,
      },
    } # End SKILL_WINDOW
# -----------------------------------------------------------------
# This section modifies Item Window's List.
# -----------------------------------------------------------------
    ITEM_WINDOW = { 
      :col_max     => 2,		# Maximum amount of Columns.
      :item_height => 24,		# Height of each item displayed.
      :arrow       => { 	  # Adds an arrow when there's too many items.
        :filename  => "Menu_Arrows", # Set to "" to disable
        :offset_x_up  => 0,
        :offset_y_up  => 0,
        :offset_x_down  => 0,
        :offset_y_down  => 0,
      },
    } # End ITEM_WINDOW
  end # Addon
end # BattleLuna

#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================
#==============================================================================
# ■ Window_BattleSkill
#==============================================================================

class Window_BattleSkill < Window_SkillList
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #-------------------------------------------------------------------------- 
  alias battle_luna_sil_initialize initialize
  def initialize(help_window, info_viewport)
    battle_luna_sil_initialize(help_window, info_viewport)
    refresh_arrow
    update
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: col_max
  #--------------------------------------------------------------------------
  def col_max
    [BattleLuna::Addon::SKILL_WINDOW[:col_max], 1].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: item_height
  #--------------------------------------------------------------------------
  def item_height
    [BattleLuna::Addon::SKILL_WINDOW[:item_height], 1].max
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
    @arrow_sprite_up.bitmap = Cache.system(arrow)
    @arrow_sprite_up.src_rect.set(0, 0, width / 2, height)
    @arrow_sprite_up.visible = false
    @arrow_sprite_down = Sprite.new(self.viewport)
    @arrow_sprite_down.bitmap = Cache.system(arrow)
    @arrow_sprite_down.src_rect.set(width / 2, 0, width / 2, height)
    @arrow_sprite_down.visible = false
  end
  
  #--------------------------------------------------------------------------
  # alias method: update_cursor
  #--------------------------------------------------------------------------
  alias battle_luna_sil_update_cursor update_cursor
  def update_cursor
    battle_luna_sil_update_cursor
    update_custom_arrow
  end
  
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
    @arrow_sprite_up.visible = self.top_row > 0
    @arrow_sprite_down.visible = self.bottom_row < row_max - 1
  end
  
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias battle_luna_sil_update update
  def update
    battle_luna_sil_update
    @arrow_sprite_up.update if @arrow_sprite_up
    @arrow_sprite_down.update if @arrow_sprite_down
    if !self.visible || self.openness < 255
      @arrow_sprite_up.visible = false if @arrow_sprite_up
      @arrow_sprite_down.visible = false if @arrow_sprite_down
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: dispose
  #--------------------------------------------------------------------------
  alias battle_luna_sil_dispose dispose
  def dispose
    battle_luna_sil_dispose
    @arrow_sprite_up.dispose if @arrow_sprite_up
    @arrow_sprite_down.dispose if @arrow_sprite_down
  end
  
end # Window_BattleSkill

#==============================================================================
# ■ Window_BattleItem
#==============================================================================

class Window_BattleItem < Window_ItemList
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #-------------------------------------------------------------------------- 
  alias battle_luna_sil_initialize initialize
  def initialize(help_window, info_viewport)
    battle_luna_sil_initialize(help_window, info_viewport)
    refresh_arrow
    update
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: col_max
  #--------------------------------------------------------------------------
  def col_max
    [BattleLuna::Addon::ITEM_WINDOW[:col_max], 1].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: item_height
  #--------------------------------------------------------------------------
  def item_height
    [BattleLuna::Addon::ITEM_WINDOW[:item_height], 1].max
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
    @arrow_sprite_up.bitmap = Cache.system(arrow)
    @arrow_sprite_up.src_rect.set(0, 0, width / 2, height)
    @arrow_sprite_up.visible = false
    @arrow_sprite_down = Sprite.new(self.viewport)
    @arrow_sprite_down.bitmap = Cache.system(arrow)
    @arrow_sprite_down.src_rect.set(width / 2, 0, width / 2, height)
    @arrow_sprite_down.visible = false
  end
  
  #--------------------------------------------------------------------------
  # alias method: update_cursor
  #--------------------------------------------------------------------------
  alias battle_luna_sil_update_cursor update_cursor
  def update_cursor
    battle_luna_sil_update_cursor
    update_custom_arrow
  end
  
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
    @arrow_sprite_up.visible = self.top_row > 0
    @arrow_sprite_down.visible = self.bottom_row < row_max - 1
  end
  
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias battle_luna_sil_update update
  def update
    battle_luna_sil_update
    @arrow_sprite_up.update if @arrow_sprite_up
    @arrow_sprite_down.update if @arrow_sprite_down
    if !self.visible || self.openness < 255
      @arrow_sprite_up.visible = false if @arrow_sprite_up
      @arrow_sprite_down.visible = false if @arrow_sprite_down
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: dispose
  #--------------------------------------------------------------------------
  alias battle_luna_sil_dispose dispose
  def dispose
    battle_luna_sil_dispose
    @arrow_sprite_up.dispose if @arrow_sprite_up
    @arrow_sprite_down.dispose if @arrow_sprite_down
  end
  
end # Window_BattleItem