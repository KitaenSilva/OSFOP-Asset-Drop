#==============================================================================
# ■ MenuLuna: Name Input Add-On.
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This allows you to modify the Name Input Processing in RPG Maker much more.
#==============================================================================
module MenuLuna
  module Addon
    module NameInput
		# -----------------------------------------------------------------
    # Change Font Configuration for Window_Name
    # -----------------------------------------------------------------
      WINDOW_NAME[:text_adv] = {
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 128],
        :bold     =>  false,
        :italic   =>  false,
        :font     =>  "VL Gothic",
        :size     =>  24,
      }
		# -----------------------------------------------------------------
    # Change Font Configuration for Window_Input
    # -----------------------------------------------------------------
      WINDOW_INPUT[:text_adv] = {
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 128],
        :bold     =>  false,
        :italic   =>  false,
        :font     =>  "VL Gothic",
        :size     =>  24,
      }
    # -----------------------------------------------------------------
    # Alphabet Table - Image Setting.
		# Once enabled, the alphabet table will be replaced with an image instead.
    # -----------------------------------------------------------------
      WINDOW_INPUT[:table_adv] = {
        :enable   =>  false,
        :filename =>  "Alphabet_Image_Sheet",
        :offset_x =>  12,
        :offset_y =>  12,
        :offset_z =>  2,
      }
    end
  end
end

#==============================================================================
# ▼ Editting anything past this point may potentially result in causing
# computer damage, incontinence, explosion of user's head, coma, death, and/or
# halitosis so edit at your own risk.
#==============================================================================
#==============================================================================
# ■ Window_NameEdit
#==============================================================================

class Window_NameEdit < Window_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_char
  #--------------------------------------------------------------------------
  def draw_char(index)
    rect = item_rect(index)
    rect.x -= 1
    rect.width += 4
    #--- configuration text ---
    hash = setting[:text_adv]
    # font color
    color = hash[:color]
    if color.is_a?(String)
      color = eval(color)
    else
      color = Color.new(color[0], color[1], color[2], color[3])
    end
    contents.font.color = color
    # outline color
    color = hash[:outline]
    if color.is_a?(String)
      color = eval(color)
    else
      color = Color.new(color[0], color[1], color[2], color[3])
    end
    contents.font.out_color = color
    # font
    contents.font.bold = hash[:bold]
    contents.font.italic = hash[:italic]
    contents.font.name = hash[:font]
    contents.font.size = hash[:size]
    #---
    draw_text(rect, @name[index] || "")
  end
  
end # Window_NameEdit

#==============================================================================
# ■ Window_NameInput
#==============================================================================

class Window_NameInput < Window_Selectable
  
  #--------------------------------------------------------------------------
  # overwrite method: refresh
  #--------------------------------------------------------------------------
  def refresh
    contents.clear
    #--- refresh image ---
    return refresh_image if setting[:table_adv][:enable]
    #--- configuration text ---
    hash = setting[:text_adv]
    # font color
    color = hash[:color]
    if color.is_a?(String)
      color = eval(color)
    else
      color = Color.new(color[0], color[1], color[2], color[3])
    end
    contents.font.color = color
    # outline color
    color = hash[:outline]
    if color.is_a?(String)
      color = eval(color)
    else
      color = Color.new(color[0], color[1], color[2], color[3])
    end
    contents.font.out_color = color
    # font
    contents.font.bold = hash[:bold]
    contents.font.italic = hash[:italic]
    contents.font.name = hash[:font]
    contents.font.size = hash[:size]
    #---
    table[@page].size.times {|i| draw_text(item_rect(i), table[@page][i], 1) }
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_image
  #--------------------------------------------------------------------------
  def refresh_image
    @table_sprite = Sprite.new(self.viewport)
    @table_sprite.bitmap = Cache.system(setting[:table_adv][:filename])
    update
  end
  
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias luna_menu_name_input_addon_update update
  def update
    luna_menu_name_input_addon_update
    update_table_image
  end
  
  #--------------------------------------------------------------------------
  # new method: update_table_image
  #--------------------------------------------------------------------------
  def update_table_image
    return unless @table_sprite
    @table_sprite.update
    @table_sprite.x = self.x + setting[:table_adv][:offset_x]
    @table_sprite.y = self.y + setting[:table_adv][:offset_y]
    @table_sprite.z = self.z + setting[:table_adv][:offset_z]
    @table_sprite.viewport = self.viewport
    @table_sprite.opacity = self.openness
    @table_sprite.visible = self.visible
  end
  
  #--------------------------------------------------------------------------
  # alias method: dispose
  #--------------------------------------------------------------------------
  alias luna_menu_name_input_addon_dispose dispose
  def dispose
    luna_menu_name_input_addon_dispose
    dispose_table_image
  end
  
  #--------------------------------------------------------------------------
  # new method: dispose_table_image
  #--------------------------------------------------------------------------
  def dispose_table_image
    return unless @table_sprite
    @table_sprite.dispose
  end
  
end # Window_NameInput