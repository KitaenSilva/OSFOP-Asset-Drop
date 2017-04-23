#==============================================================================
# ■ BattleLuna: Enemy Target Window Config
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This allows you to customize the enemy target window. It only appears whenever
# you select a target.
#==============================================================================
$imported = {} if $imported.nil?
$imported["YEL-BattleLuna-EnemyTargetWindow"] = true

module BattleLuna
  module Addon
    ENEMY_TARGET_WINDOW = {
      :enable =>  true,		# Enable Enemy Target Window? True/False
      # -----------------------------------------------------------------
      # :x refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move to the left, while 
      # Positive values mean they would move to the right.
      # -----------------------------------------------------------------
      :x      =>  0,
      # -----------------------------------------------------------------
      # :y refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move up, while 
      # Positive values mean they would move to the down.
      # -----------------------------------------------------------------
      :y      =>  248,
      # -----------------------------------------------------------------
      # :z refers to the item’s display priority. Think of it as layers when 
      # you use an image program or when mapping in RPG Maker. The higher the 
      # value, the higher it will be drawn/drawn above other items.
      # -----------------------------------------------------------------
      :z      =>  300,
      :width  =>  640,  # Change the width of the window.
      :height =>  48,   # Change the height of the window.
      # -----------------------------------------------------------------
      # This refers to the spacing between the window border and the contents.
      # ----------------------------------------------------------------- 
      :padding    =>  12,	
      :col_max    =>  2,	# Amount of Columns when displaying target names.
      # ----------------------------------------------------------------- 
      # Set alignment settings.
      # 0 = Left/Default, 1 = Center, 2 = Right
      # -----------------------------------------------------------------   
      :align      =>  0,
      # -----------------------------------------------------------------
      # Set a Background Display Type:
      # 0 - Windowskin; 1 - Gradient Background; 2 - Picture
      # -----------------------------------------------------------------
      :back_type  =>  0,      
      # ----------------------------------------------------------------- 
      # This allows you to set a variable to change the skin of this particular    
      # section of the menu. The default is Variable 1. Remember that it reads 
      # it as a string (e.g. $game_variables[1] = “Menu_Green”).
      # -----------------------------------------------------------------   
      :background_variable => 1, 
        
      # Type 0 settings (Windowskin)
      :type_0     =>  { 
        :skin     => "Window", # Name of the Windowskin
        :opacity  => 255,      # Change the transparency of the window.
                               # 0 = Transparent, 255 = Solid    
      },
        
      # -----------------------------------------------------------------   
      # Type 1 settings (Gradient Background)
      # color1 = refers to the first color of the gradient. ([R,G,B,A])
      # color2 = refers to the second color of the gradient. ([R,G,B,A])
      # normal_color refers to the color of your default windowskin.
      # ----------------------------------------------------------------- 
      :type_1     =>  {
        :color1   =>  [0, 0, 0, 128],
        :color2   =>  [0, 0, 0, 128],
        :vertical =>  false,
      },
        
      # -----------------------------------------------------------------   
      # Type 2 settings (Picture Background)
      # :picture = Name of the Picture located in Graphics/System folder.
      # :opacity = Transparency of the picture. 0 = Transparent, 255 = Solid  
      # -----------------------------------------------------------------   
      # BG Type 2 settings
      :type_2     =>  {
        :picture  =>  "", # Graphics/System
        :opacity  =>  255,
        :offset_x =>  0,
        :offset_y =>  0,
      },
    } # ENEMY_TARGET_WINDOW
  end
end

#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================

#==============================================================================
# ■ Window_BattleEnemy
#==============================================================================

class Window_BattleEnemy < Window_Selectable
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  alias battle_luna_enetar_initialize initialize
  def initialize(info_viewport)
    battle_luna_enetar_initialize(info_viewport)
    @info_viewport = nil
    init_position
    update_padding
    create_contents
    refresh_background
    update
  end

  #--------------------------------------------------------------------------
  # overwrite method: update
  #--------------------------------------------------------------------------
  def update
    super
    self.x = self.y = 999 unless setting[:enable]
    update_highlight
  end
  
  #--------------------------------------------------------------------------
  # new method: update_highlight
  #--------------------------------------------------------------------------
  def update_highlight
    return unless self.active
    return unless enemy
    enemy.sprite_effect_type = :whiten
    return unless @cursor_all
    $game_troop.alive_members.each { |enemy|
      enemy.sprite_effect_type = :whiten
    }
  end
  
  #--------------------------------------------------------------------------
  # new method: init_position
  #--------------------------------------------------------------------------
  def init_position
    self.x = screen_x
    self.y = screen_y
    self.z = screen_z
    self.width = window_width
    self.height = window_height
  end
  
  #--------------------------------------------------------------------------
  # window_width
  #--------------------------------------------------------------------------
  def window_width
    [setting[:width], standard_padding * 2 + line_height].max
  end
  
  #--------------------------------------------------------------------------
  # window_height
  #--------------------------------------------------------------------------
  def window_height
    [setting[:height], standard_padding * 2 + line_height].max
  end
  
  #--------------------------------------------------------------------------
  # standard_padding
  #--------------------------------------------------------------------------
  def standard_padding
    setting[:padding]
  end
  
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    BattleLuna::Addon::ENEMY_TARGET_WINDOW
  end
  
  #--------------------------------------------------------------------------
  # screen_x
  #--------------------------------------------------------------------------
  def screen_x
    setting[:x]
  end
  
  #--------------------------------------------------------------------------
  # screen_y
  #--------------------------------------------------------------------------
  def screen_y
    setting[:y]
  end
  
  #--------------------------------------------------------------------------
  # screen_z
  #--------------------------------------------------------------------------
  def screen_z
    setting[:z]
  end
  
  #--------------------------------------------------------------------------
  # new method: setting_type
  #--------------------------------------------------------------------------
  def setting_type
    type = setting[:back_type]
    setting[eval(":type_#{type}")]
  end
    
  #--------------------------------------------------------------------------
  # overwrite method: dispose
  #--------------------------------------------------------------------------
  def dispose
    super
    @bg_sprite.dispose if @bg_sprite
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: col_max
  #--------------------------------------------------------------------------
  def col_max
    setting[:enable] ? setting[:col_max] : 1
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: show
  #--------------------------------------------------------------------------
  def show
    select(0)
    super
  end
    
  #--------------------------------------------------------------------------
  # alias method: cursor_right
  #--------------------------------------------------------------------------
  alias battle_luna_enetar_cursor_right cursor_right
  def cursor_right(wrap = false)
    return cursor_down(wrap) unless setting[:enable]
    battle_luna_enetar_cursor_right(wrap)
  end
  
  #--------------------------------------------------------------------------
  # alias method: cursor_left
  #--------------------------------------------------------------------------
  alias battle_luna_enetar_cursor_left cursor_left
  def cursor_left(wrap = false)
    return cursor_up(wrap) unless setting[:enable]
    battle_luna_enetar_cursor_left(wrap)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_item
  # Compatible with YEA - Ace Battle Engine
  #--------------------------------------------------------------------------
  if $imported["YEA-BattleEngine"]
  def draw_item(index)
    change_color(normal_color)
    name = $game_troop.alive_members[index].name
    draw_text(item_rect_for_text(index), name)
  end
  end
  
end # Window_BattleEnemy