#==============================================================================
# ■ Luna Add-On: Customizable Yanfly Engine Ace Victory
#==============================================================================
# This lets you customize Yanfly's Victory Aftermath Script graphically.
#==============================================================================

$imported = {} if $imported.nil?
$imported["YEL-YEAVictory"] = true
#==============================================================================
# ■ BattleLuna
#==============================================================================

module BattleLuna
  module Addon
    module YEA_VICTORY
    
      CORE = { # Begin CORE
        :message      =>  false,  # Enable/Disable Victory Quotes
        :spoil        =>  false,  # Set this to false to disable spoil window.
        :lvup         =>  false,  # Set this to false to disable levelup window.
        :spoil_with_exp => false, # Show spoil window with EXP window
        :wait_exp     =>  true,   # Set this to true to wait for EXP tick.
        :hide_hud     =>  true,   # Hide HUD when victory.
      } # End CORE
      
      TITLE_WINDOW = { # Begin TITLE_WINDOW
        :enable       =>  false,
        :x            =>  0,
        :y            =>  0,
        :z            =>  300,
        :width        =>  640,
        :height       =>  48,
        :back_type    =>  0, # 0 - normal window, 1 - gradient, 2 - picture
        :background_variable => 1, # Set a Variable to change Window
        
        # BG Type 0 settings
        :type_0     =>  { 
          :opacity  => 255, 
        },
          
        # BG Type 1 settings
        :type_1     =>  {
          :color1   =>  [0, 0, 0, 128],
          :color2   =>  [0, 0, 0, 128],
          :vertical =>  false,
        },
          
        # BG Type 2 settings
        :type_2     =>  {
          :picture  =>  "Actor_Commands", # Graphics/System
          :opacity  =>  255,
          :offset_x =>  0,
          :offset_y =>  0,
        },
      } # End TITLE_WINDOW
      
      WINDOW_EXP = {
        :x      =>  0,
        :y      =>  0,
        :z      =>  300,
        :width  =>  640,
        :height =>  416,
        :padding     => 0,
        :item_rect   => {
          # X, Y Offset for members.
          :x       =>  0,
          :y       =>  0,
          :width   =>  154,
          :height  =>  392,
          :spacing =>  8,
        },
        #---
        :back_type  =>  0,      # 0 - normal window, 1 - gradient, 2 - picture
        :background_variable => 1, # Set a Variable to change Window
         
        # BG Type 0 settings
        :type_0     =>  { 
          :opacity  => 255, 
        },
          
        # BG Type 1 settings
        :type_1     =>  {
          :color1   =>  [243, 134, 48, 255],
          :color2   =>  [243, 134, 48, 255],
          :vertical =>  false,
        },
          
        # BG Type 2 settings
        :type_2     =>  {
          :picture  =>  "commandpane", # Graphics/System
          :opacity  =>  255,
          :offset_x =>  0,
          :offset_y =>  0,
        },
      } # End WINDOW_COMMANDS.
      
      WINDOW_SPOILS = {
        :x            =>  0,
        :y            =>  72,
        :z            =>  300,
        :width        =>  640,
        :height       =>  344,
        :item_height  =>  24,
        :column       =>  2,
        :padding      =>  12,
        :back_type    =>  0, # 0 - normal window, 1 - gradient, 2 - picture
        :background_variable => 1, # Set a Variable to change Window
        
        # BG Type 0 settings
        :type_0     =>  { 
          :opacity  => 255, 
        },
          
        # BG Type 1 settings
        :type_1     =>  {
          :color1   =>  [0, 0, 0, 128],
          :color2   =>  [0, 0, 0, 128],
          :vertical =>  false,
        },
         
        # BG Type 2 settings
        :type_2     =>  {
          :picture  =>  "Actor_Commands", # Graphics/System
          :opacity  =>  255,
          :offset_x =>  0,
          :offset_y =>  0,
        },
      } # End WINDOW_SPOILS
      
    end
  end # Addon
end # BattleLuna

#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================

#==============================================================================
# ■ BattleManager
#==============================================================================

module BattleManager
  
  #--------------------------------------------------------------------------
  # alias method: self.set_victory_text
  #--------------------------------------------------------------------------
  class<<self; alias battle_luna_lunavictory_set_victory_text set_victory_text; end
  def self.set_victory_text(actor, type)
    victory_hide_all
    battle_luna_lunavictory_set_victory_text(actor, type)
  end
  
  #--------------------------------------------------------------------------
  # new method: self.victory_hide_all
  #--------------------------------------------------------------------------
  def self.victory_hide_all
    hide_status = BattleLuna::Addon::YEA_VICTORY::CORE[:hide_hud]
    SceneManager.scene.help_window.hide
    SceneManager.scene.actor_command_window.deactivate.hide
    SceneManager.scene.message_window.hide
    SceneManager.scene.status_window.hide if hide_status
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: self.display_exp
  #--------------------------------------------------------------------------
  def self.display_exp
    spoil_with_exp = BattleLuna::Addon::YEA_VICTORY::CORE[:spoil_with_exp]
    SceneManager.scene.show_victory_display_exp
    gain_drop_items_luna if spoil_with_exp
    actor = $game_party.random_target
    @victory_actor = actor
    victory_hide_all
    SceneManager.scene.wait_for_exp_victory
    set_victory_text(@victory_actor, :win)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: self.gain_exp
  #--------------------------------------------------------------------------
  def self.gain_exp
    lvup = BattleLuna::Addon::YEA_VICTORY::CORE[:lvup]
    $game_party.all_members.each do |actor|
      temp_actor = Marshal.load(Marshal.dump(actor))
      actor.gain_exp($game_troop.exp_total)
      next if actor.level == temp_actor.level
      next unless lvup
      SceneManager.scene.show_victory_level_up(actor, temp_actor)
      set_victory_text(actor, :level)
      wait_for_message
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: self.gain_drop_items
  #--------------------------------------------------------------------------
  def self.gain_drop_items
    spoil_with_exp = BattleLuna::Addon::YEA_VICTORY::CORE[:spoil_with_exp]
    spoil          = BattleLuna::Addon::YEA_VICTORY::CORE[:spoil]
    return if spoil_with_exp
    drops = []
    $game_troop.make_drop_items.each do |item|
      $game_party.gain_item(item, 1)
      drops.push(item)
    end
    return unless spoil
    SceneManager.scene.show_victory_spoils($game_troop.gold_total, drops)
    set_victory_text(@victory_actor, :drops)
    wait_for_message
  end
  
  #--------------------------------------------------------------------------
  # new method: self.gain_drop_items_luna
  #--------------------------------------------------------------------------
  def self.gain_drop_items_luna
    drops = []
    $game_troop.make_drop_items.each do |item|
      $game_party.gain_item(item, 1)
      drops.push(item)
    end
    SceneManager.scene.show_victory_spoils_luna($game_troop.gold_total, drops)
  end
  
end # BattleManager

#==============================================================================
# ■ Window_VictoryTitle
#==============================================================================

class Window_VictoryTitle < Window_Base
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize
    super(screen_x, screen_y, window_width, window_height)
    self.z = screen_z
    self.openness = 0
    refresh_background
    update
  end
  
  #--------------------------------------------------------------------------
  # refresh
  #--------------------------------------------------------------------------
  def refresh(message = "")
    contents.clear
    draw_text(0, 0, contents.width, line_height, message, 1)
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
  # setting
  #--------------------------------------------------------------------------
  def setting
    BattleLuna::Addon::YEA_VICTORY::TITLE_WINDOW
  end
  
  #--------------------------------------------------------------------------
  # screen_x
  #--------------------------------------------------------------------------
  def screen_x
    setting[:enable] ? setting[:x] : 999
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
  # new method: refresh_background
  #--------------------------------------------------------------------------
  def refresh_background
    type = setting[:back_type]
    case type
    when 1; refresh_type1
    when 2; refresh_type2
    end
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_type1
  #--------------------------------------------------------------------------
  def refresh_type1
    return if @bg_sprite
    @bg_sprite = Sprite.new(nil)
    bitmap = Bitmap.new(window_width, window_height)
    color1 = setting_type[:color1]
    color1 = Color.new(color1[0], color1[1], color1[2], color1[3])
    color2 = setting_type[:color2]
    color2 = Color.new(color2[0], color2[1], color2[2], color2[3])
    bitmap.gradient_fill_rect(bitmap.rect, color1, color2, setting_type[:vertical])
    @bg_sprite.bitmap = bitmap
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_type2
  #--------------------------------------------------------------------------
  def refresh_type2
    return if @bg_sprite
    @bg_sprite = Sprite.new(nil)
    @bg_sprite.bitmap = Cache.system(setting_type[:picture])
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: update
  #--------------------------------------------------------------------------
  def update
    super
    type = setting[:back_type]
    case type
    when 0; update_type0
    when 1; update_type1
    when 2; update_type2
    end    
  end
  
  #--------------------------------------------------------------------------
  # new method: update_type0
  #--------------------------------------------------------------------------
  def update_type0
    self.opacity = setting_type[:opacity]
  end
  
  #--------------------------------------------------------------------------
  # new method: update_type1
  #--------------------------------------------------------------------------
  def update_type1
    @bg_sprite.update
    @bg_sprite.x = self.x
    @bg_sprite.y = self.y
    @bg_sprite.z = self.z - 1
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  #--------------------------------------------------------------------------
  # new method: update_type2
  #--------------------------------------------------------------------------
  def update_type2
    @bg_sprite.update
    @bg_sprite.x = self.x + setting_type[:offset_x]
    @bg_sprite.y = self.y + setting_type[:offset_y]
    @bg_sprite.z = self.z - 1
    @bg_sprite.opacity = setting_type[:opacity]
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: dispose
  #--------------------------------------------------------------------------
  def dispose
    super
    @bg_sprite.dispose if @bg_sprite
  end
  
end # Window_VictoryTitle

#==============================================================================
# ■ Window_VictoryEXP_Back
#==============================================================================

class Window_VictoryEXP_Back < Window_Selectable
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0, window_width, window_height)
    self.openness = 0
    init_position
    refresh_background
    update
  end
  
  #--------------------------------------------------------------------------
  # new method: init_position
  #--------------------------------------------------------------------------
  def init_position
    self.x = init_screen_x
    self.y = init_screen_y
    self.z = init_screen_z
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: window_width
  #--------------------------------------------------------------------------
  def window_width
    [setting[:width], standard_padding * 2 + line_height].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: window_height
  #--------------------------------------------------------------------------
  def window_height
    [setting[:height], standard_padding * 2 + line_height].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: standard_padding
  #--------------------------------------------------------------------------
  def standard_padding
    [setting[:padding], 0].max
  end
  
  #--------------------------------------------------------------------------
  # new method: init_screen_x
  #--------------------------------------------------------------------------
  def init_screen_x
    eval(setting[:x].to_s)
  end
  
  #--------------------------------------------------------------------------
  # new method: init_screen_y
  #--------------------------------------------------------------------------
  def init_screen_y
    eval(setting[:y].to_s)
  end
  
  #--------------------------------------------------------------------------
  # new method: init_screen_z
  #--------------------------------------------------------------------------
  def init_screen_z
    eval(setting[:z].to_s)
  end
  
  #--------------------------------------------------------------------------
  # new method: setting
  #--------------------------------------------------------------------------
  def setting
    BattleLuna::Addon::YEA_VICTORY::WINDOW_EXP
  end
  
  #--------------------------------------------------------------------------
  # new method: setting_type
  #--------------------------------------------------------------------------
  def setting_type
    type = setting[:back_type]
    setting[eval(":type_#{type}")]
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_background
  #--------------------------------------------------------------------------
  def refresh_background
    type = setting[:back_type]
    case type
    when 0; refresh_type0
    when 1; refresh_type1
    when 2; refresh_type2
    end
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_type0
  #--------------------------------------------------------------------------
  def refresh_type0
    # Workground.
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_type1
  #--------------------------------------------------------------------------
  def refresh_type1
    return if @bg_sprite
    @bg_sprite = Sprite.new(nil)
    bitmap = Bitmap.new(window_width, window_height)
    color1 = setting_type[:color1]
    color1 = Color.new(color1[0], color1[1], color1[2], color1[3])
    color2 = setting_type[:color2]
    color2 = Color.new(color2[0], color2[1], color2[2], color2[3])
    bitmap.gradient_fill_rect(bitmap.rect, color1, color2, setting_type[:vertical])
    @bg_sprite.bitmap = bitmap
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_type2
  #--------------------------------------------------------------------------
  def refresh_type2
    return if @bg_sprite
    @bg_sprite = Sprite.new(nil)
    @bg_sprite.bitmap = Cache.system(setting_type[:picture])
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: update
  #--------------------------------------------------------------------------
  def update
    super
    type = setting[:back_type]
    case type
    when 0; update_type0
    when 1; update_type1
    when 2; update_type2
    end    
  end
  
  #--------------------------------------------------------------------------
  # new method: update_type0
  #--------------------------------------------------------------------------
  def update_type0
    self.opacity = setting_type[:opacity]
  end
  
  #--------------------------------------------------------------------------
  # new method: update_type1
  #--------------------------------------------------------------------------
  def update_type1
    @bg_sprite.update
    @bg_sprite.x = self.x
    @bg_sprite.y = self.y
    @bg_sprite.z = self.z - 1
    @bg_sprite.opacity = self.openness
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  #--------------------------------------------------------------------------
  # new method: update_type2
  #--------------------------------------------------------------------------
  def update_type2
    @bg_sprite.update
    @bg_sprite.x = self.x + setting_type[:offset_x]
    @bg_sprite.y = self.y + setting_type[:offset_y]
    @bg_sprite.z = self.z - 1
    @bg_sprite.opacity = [setting_type[:opacity], self.openness].min
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end

  #--------------------------------------------------------------------------
  # item_rect
  #--------------------------------------------------------------------------
  def item_rect(index)
    rsetting = setting[:item_rect]
    rect = Rect.new
    rect.width = rsetting[:width]
    rect.height = rsetting[:height]
    rect.x = index % col_max * (rsetting[:width] + spacing) + rsetting[:x]
    rect.y = index / col_max * rsetting[:height] + rsetting[:y]
    return rect
  end
  
  #--------------------------------------------------------------------------
  # spacing
  #--------------------------------------------------------------------------
  def spacing
    setting[:item_rect][:spacing]
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: dispose
  #--------------------------------------------------------------------------
  def dispose
    super
    @bg_sprite.dispose if @bg_sprite
  end
  
  #--------------------------------------------------------------------------
  # new method: texts
  #--------------------------------------------------------------------------
  def texts(index, actor, contents, rect)
    BattleLuna::Addon::YEA_VICTORY.exp_text(index, actor, contents, rect)
  end
  
  #--------------------------------------------------------------------------
  # alias method: draw_item
  #--------------------------------------------------------------------------
  alias battle_luna_draw_item draw_item
  def draw_item(index)
    clear_item(index)
    rect = item_rect(index)
    actor = $game_party.battle_members[index]
    return battle_luna_draw_item(index) if texts(index, actor, contents, rect).nil?
    reset_font_settings
    texts(index, actor, contents, rect).each { |hash|
      next unless hash
      text  = hash[0]
      pos   = hash[1]
      align = hash[2] || [0, 0]
      color = hash[3]
      font  = hash[4] || ["", 0]
      height = [line_height, font[1]].max
      align[0] = [align[0], rect.width].min if align.is_a?(Array)
      if text =~ /\$bitmap\[(.*)\]/i
        value = $1.scan(/[^, ]+[^,]*/i)
        bitmap = Cache.cache_extended(value[0], value[1])
        opacity = align.is_a?(Array) ? 255 : align
        rect = color.nil? ? bitmap.rect.clone : Rect.new(color[0], color[1], color[2], color[3])
        contents.blt(pos[0], pos[1], bitmap, rect, opacity)
      elsif text =~ /\$icon\[(\d+)\]/i
        draw_icon($1.to_i, pos[0], pos[1], align)
      elsif text =~ /\$color\[(.*)\]/i
        value = $1.scan(/\d+/)
        value.collect! { |i| i.to_i }
        opacity = align.is_a?(Array) ? 255 : align
        cache = Bitmap.new(color[0], color[1])
        cache.fill_rect(cache.rect, Color.new(value[0], value[1], value[2]))
        contents.blt(pos[0], pos[1], cache, cache.rect.clone, opacity)
      elsif text =~ /\$(.*)grad\[(.*)\]/i
        vertical = $1.downcase == "hor" ? false : true
        value = $2.scan(/\d+/)
        value.collect! { |i| i.to_i }
        opacity = align.is_a?(Array) ? 255 : align
        color1 = Color.new(value[0], value[1], value[2])
        color2 = Color.new(value[3], value[4], value[5])
        cache = Bitmap.new(color[0], color[1])
        cache.gradient_fill_rect(cache.rect, color1, color2, vertical) 
        contents.blt(pos[0], pos[1], cache, cache.rect.clone, opacity)
      else
        contents.font.name = font[0]
        contents.font.size = font[1]
        contents.font.bold = font[2]
        contents.font.italic = font[3]
        contents.font.color = Color.new(color[0], color[1], color[2], color[3] || 255)
        contents.font.outline = color[4].nil? ? true : color[4]
        draw_text(pos[0], pos[1], align[0], height, text, align[1])
      end
    }
  end
    
end # Window_VictoryEXP_Back

#==============================================================================
# ■ Window_VictorySpoils
#==============================================================================

class Window_VictorySpoils < Window_ItemList
    
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #-------------------------------------------------------------------------- 
  def initialize
    super(screen_x, screen_y, window_width, window_height)
    init_position
    refresh_background
    hide
    update
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
  # new method: window_width
  #--------------------------------------------------------------------------
  def window_width
    [setting[:width], standard_padding * 2 + line_height].max
  end
  
  #--------------------------------------------------------------------------
  # new method: window_height
  #--------------------------------------------------------------------------
  def window_height
    [setting[:height], standard_padding * 2 + line_height].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: standard_padding
  #--------------------------------------------------------------------------
  def standard_padding
    [setting[:padding], 0].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: window_height
  #--------------------------------------------------------------------------
  def col_max
    [1, setting[:column]].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: item_height
  #--------------------------------------------------------------------------
  def item_height
    [line_height, setting[:item_height]].max
  end
  
  #--------------------------------------------------------------------------
  # new method: setting
  #--------------------------------------------------------------------------
  def setting
    BattleLuna::Addon::YEA_VICTORY::WINDOW_SPOILS
  end
  
  #--------------------------------------------------------------------------
  # new method: screen_x
  #--------------------------------------------------------------------------
  def screen_x
    setting[:x]
  end
  
  #--------------------------------------------------------------------------
  # new method: screen_y
  #--------------------------------------------------------------------------
  def screen_y
    setting[:y]
  end
  
  #--------------------------------------------------------------------------
  # new method: screen_z
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
  # new method: refresh_background
  #--------------------------------------------------------------------------
  def refresh_background
    type = setting[:back_type]
    case type
    when 1; refresh_type1
    when 2; refresh_type2
    end
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_type1
  #--------------------------------------------------------------------------
  def refresh_type1
    return if @bg_sprite
    @bg_sprite = Sprite.new(nil)
    bitmap = Bitmap.new(window_width, window_height)
    color1 = setting_type[:color1]
    color1 = Color.new(color1[0], color1[1], color1[2], color1[3])
    color2 = setting_type[:color2]
    color2 = Color.new(color2[0], color2[1], color2[2], color2[3])
    bitmap.gradient_fill_rect(bitmap.rect, color1, color2, setting_type[:vertical])
    @bg_sprite.bitmap = bitmap
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_type2
  #--------------------------------------------------------------------------
  def refresh_type2
    return if @bg_sprite
    @bg_sprite = Sprite.new(nil)
    @bg_sprite.bitmap = Cache.system(setting_type[:picture])
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: update
  #--------------------------------------------------------------------------
  def update
    super
    type = setting[:back_type]
    case type
    when 0; update_type0
    when 1; update_type1
    when 2; update_type2
    end    
  end
  
  #--------------------------------------------------------------------------
  # new method: update_type0
  #--------------------------------------------------------------------------
  def update_type0
    self.opacity = setting_type[:opacity]
  end
  
  #--------------------------------------------------------------------------
  # new method: update_type1
  #--------------------------------------------------------------------------
  def update_type1
    @bg_sprite.update
    @bg_sprite.x = self.x
    @bg_sprite.y = self.y
    @bg_sprite.z = self.z - 1
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  #--------------------------------------------------------------------------
  # new method: update_type2
  #--------------------------------------------------------------------------
  def update_type2
    @bg_sprite.update
    @bg_sprite.x = self.x + setting_type[:offset_x]
    @bg_sprite.y = self.y + setting_type[:offset_y]
    @bg_sprite.z = self.z - 1
    @bg_sprite.opacity = setting_type[:opacity]
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: dispose
  #--------------------------------------------------------------------------
  def dispose
    super
    @bg_sprite.dispose if @bg_sprite
  end
  
  #--------------------------------------------------------------------------
  # alias method: include?
  #--------------------------------------------------------------------------
  alias menu_luna_include? include?
  def include?(item)
    category_enable = MenuLuna::ItemMenu::WINDOW_CATEGORY[:enable]
    category_enable ? menu_luna_include?(item) : true
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: select_last
  #--------------------------------------------------------------------------
  def select_last
    last = $game_party.last_item.object
    last ? select(@data.index($game_party.last_item.object)) : select(0)
  end
  
  #--------------------------------------------------------------------------
  # new method: texts
  #--------------------------------------------------------------------------
  def texts(item, contents, rect)
    BattleLuna::Addon::YEA_VICTORY.spoil_text(item, contents, rect)
  end
  
  #--------------------------------------------------------------------------
  # alias method: draw_item
  #--------------------------------------------------------------------------
  alias battle_luna_draw_item draw_item
  def draw_item(index)
    clear_item(index)
    item = @data[index]
    if item
      rect = item_rect(index)
      return battle_luna_draw_item(index) if texts(item, contents, rect).nil?
      reset_font_settings
      texts(item, contents, rect).each { |hash|
        next unless hash
        text  = hash[0]
        pos   = hash[1]
        align = hash[2] || [0, 0]
        color = hash[3]
        font  = hash[4] || ["", 0]
        height = [line_height, font[1]].max
        align[0] = [align[0], rect.width].min if align.is_a?(Array)
        if text =~ /\$bitmap\[(.*)\]/i
          value = $1.scan(/[^, ]+[^,]*/i)
          bitmap = Cache.cache_extended(value[0], value[1])
          opacity = align.is_a?(Array) ? 255 : align
          bw = bitmap.width; bh = bitmap.height
          rect = color.nil? ? bitmap.rect.clone : Rect.new(eval(color[0].to_s), eval(color[1].to_s), eval(color[2].to_s), eval(color[3].to_s))
          contents.blt(pos[0], pos[1], bitmap, rect, opacity)
        elsif text =~ /\$icon\[(\d+)\]/i
          draw_icon($1.to_i, pos[0], pos[1], align)
        elsif text =~ /\$color\[(.*)\]/i
          value = $1.scan(/\d+/)
          value.collect! { |i| i.to_i }
          opacity = align.is_a?(Array) ? 255 : align
          cache = Bitmap.new(color[0], color[1])
          cache.fill_rect(cache.rect, Color.new(value[0], value[1], value[2]))
          contents.blt(pos[0], pos[1], cache, cache.rect.clone, opacity)
        elsif text =~ /\$(.*)grad\[(.*)\]/i
          vertical = $1.downcase == "hor" ? false : true
          value = $2.scan(/\d+/)
          value.collect! { |i| i.to_i }
          opacity = align.is_a?(Array) ? 255 : align
          color1 = Color.new(value[0], value[1], value[2])
          color2 = Color.new(value[3], value[4], value[5])
          cache = Bitmap.new(color[0], color[1])
          cache.gradient_fill_rect(cache.rect, color1, color2, vertical) 
          contents.blt(pos[0], pos[1], cache, cache.rect.clone, opacity)
        else
          contents.font.name = font[0]
          contents.font.size = font[1]
          contents.font.bold = font[2]
          contents.font.italic = font[3]
          contents.font.color = Color.new(color[0], color[1], color[2], color[3] || 255)
          contents.font.outline = color[4].nil? ? true : color[4]
          draw_text(pos[0], pos[1], align[0], height, text, align[1])
        end
      }
    end
  end
  
  #--------------------------------------------------------------------------
  # make
  #--------------------------------------------------------------------------
  def make(gold, drops)
    @gold = gold
    @drops = drops
    refresh
  end
  
  #--------------------------------------------------------------------------
  # make_item_list
  #--------------------------------------------------------------------------
  def make_item_list
    @data = []
    items = {}
    weapons = {}
    armours = {}
    @goods = {}
    for item in @drops
      case item
      when RPG::Item
        items[item] = 0 if items[item].nil?
        items[item] += 1
      when RPG::Weapon
        weapons[item] = 0 if weapons[item].nil?
        weapons[item] += 1
      when RPG::Armor
        armours[item] = 0 if armours[item].nil?
        armours[item] += 1
      end
    end
    items = items.sort { |a,b| a[0].id <=> b[0].id }
    weapons = weapons.sort { |a,b| a[0].id <=> b[0].id }
    armours = armours.sort { |a,b| a[0].id <=> b[0].id }
    for key in items; @goods[key[0]] = key[1]; @data.push(key[0]); end
    for key in weapons; @goods[key[0]] = key[1]; @data.push(key[0]); end
    for key in armours; @goods[key[0]] = key[1]; @data.push(key[0]); end
  end
  
end # Window_VictorySpoils

#==============================================================================
# ■ Scene_Battle
#==============================================================================

class Scene_Battle < Scene_Base
  
  #--------------------------------------------------------------------------
  # new method: message_window
  #--------------------------------------------------------------------------
  def message_window
    @message_window
  end
  
  #--------------------------------------------------------------------------
  # new method: show_victory_spoils_luna
  #--------------------------------------------------------------------------
  def show_victory_spoils_luna(gold, drops)
    @victory_level_window.hide
    @victory_level_skills.hide
    #---
    text = YEA::VICTORY_AFTERMATH::TOP_SPOILS
    @victory_title_window.refresh(text)
    #---
    @victory_spoils_window.show
    @victory_spoils_window.make(gold, drops)
  end
  
  #--------------------------------------------------------------------------
  # new method: wait_for_exp_victory
  #--------------------------------------------------------------------------
  def wait_for_exp_victory
    @victory_exp_window_front.update
    update_for_wait until @victory_exp_window_front.complete_ticks?
  end
  
end # Scene_Battle