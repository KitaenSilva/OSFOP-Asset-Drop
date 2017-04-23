#==============================================================================
# ■ Luna Add-On: Customizable Yanfly Engine Ace Victory EXP Bars
#==============================================================================
# This lets you customize Yanfly's Victory Aftermath Script EXP Bars.
#==============================================================================
module BattleLuna
  module Addon
    module YEA_VICTORY
      EXP_BAR = {
        :offset_x =>  68,
        :offset_y =>  150,
        :offset_z =>  500,
      # -----------------------------------------------------------------
      # Type allows you to set the type of graphic you want to use.
      # 0 - Default bar; 1 - Custom bar; 2 - Custom animated bar.
      # -----------------------------------------------------------------    
        :type     =>  0,
        :vertical =>  false,	# Display vertically? True/False 
                              # Works for type 0 and 1.
        :ani_rate =>  0.02,   # Max is 1.00. Refers to animate speed/rate.
        :level_up =>  :lvup,  # Rule for Level Up popup.
                              # You can create a new one in Damage Popup.
        #---
        :type_0   =>  {
          :back_color =>  [0, 0, 0, 255],
          :color1     =>  [255, 16, 16, 255],
          :color2     =>  [255, 64, 64, 255],
          :outline    =>  [0, 0, 0, 255],
          :length     =>  76,
          :height     =>  12,
        },
        #---
        :type_1   =>  {
          :filename =>  "physbar-fill",
        },
        #---
        :type_2   =>  {
          :filename =>  "Btskin_hp",
          :frames   =>  10,
        },
      }
    end
  end
end

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
  # alias method: self.display_exp
  #--------------------------------------------------------------------------
  class<<self; alias battle_luna_lunavictory_display_exp display_exp; end
  def self.display_exp
    SceneManager.scene.victory_set_exp($game_troop.exp_total)
    battle_luna_lunavictory_display_exp
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: self.gain_exp
  #--------------------------------------------------------------------------
  def self.gain_exp
    # Removed
  end
  
end

#==============================================================================
# ■ SpriteVictory_Bar
#==============================================================================

class SpriteVictory_Bar < Sprite
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize(viewport, window, index = 0)
    super(viewport)
    @window = window
    @index = index
    @battler = $game_party.battle_members[@index]
    @rate = real_rate
    @exp = 0
    @popup = []
    update
  end
  
  #--------------------------------------------------------------------------
  # set_exp
  #--------------------------------------------------------------------------
  def set_exp(exp)
    @exp = exp
  end
  
  #--------------------------------------------------------------------------
  # is_tick?
  #--------------------------------------------------------------------------
  def is_tick?
    @exp > 0
  end
  
  #--------------------------------------------------------------------------
  # update
  #--------------------------------------------------------------------------
  def update
    super
    update_rate
    #---
    self.x = screen_x; self.y = screen_y; self.z = screen_z
    self.ox = self.width / 2
    self.oy = self.height
    self.opacity = real_opacity
    self.visible = @window.visible
    #---
    @popup.each { |p| p.update }
    @popup.each_with_index { |sprite, index|
      next unless sprite.disposed?
      @popup[index] = nil
    }
    @popup.compact!
  end
  
  #--------------------------------------------------------------------------
  # update_rate
  #--------------------------------------------------------------------------
  def update_rate
    return unless is_tick?
    update_exp
    @rate = real_rate
    refresh
  end
  
  #--------------------------------------------------------------------------
  # update_exp
  #--------------------------------------------------------------------------
  def update_exp
    to  = @battler.next_level_exp - @battler.exp
    req = @battler.next_level_exp - @battler.current_level_exp
    rate = [(req * setting[:ani_rate]).floor, to, @exp].min
    @exp -= rate
    level = @battler.level
    @battler.gain_exp(rate)
    return if level == @battler.level
    text = YEA::VICTORY_AFTERMATH::LEVELUP_TEXT
    rule = setting[:level_up]
    @popup.push(Sprite_PopupLuna.new(self.viewport, self, [text,nil], rule))
  end
    
  #--------------------------------------------------------------------------
  # refresh
  #--------------------------------------------------------------------------
  def refresh
    case setting[:type]
    when 0; refresh_type0
    when 1; refresh_type1
    when 2; refresh_type2
    end
  end
  
  #--------------------------------------------------------------------------
  # refresh_type0
  #--------------------------------------------------------------------------
  def refresh_type0
    self.bitmap ||= Bitmap.new(setting_type[:length], setting_type[:height])
    self.bitmap.clear
    #---
    rect = self.bitmap.rect
    color1 = setting_type[:color1]
    color1 = Color.new(color1[0], color1[1], color1[2], color1[3])
    color2 = setting_type[:color2]
    color2 = Color.new(color2[0], color2[1], color2[2], color2[3])
    back_color = setting_type[:back_color]
    back_color = Color.new(back_color[0], back_color[1], back_color[2], back_color[3])
    outline = setting_type[:outline]
    outline = Color.new(outline[0], outline[1], outline[2], outline[3])
    self.bitmap.fill_rect(rect, back_color)
    self.bitmap.fill_rect(rect, outline)
    rect.x += 1; rect.y += 1; rect.width -= 2; rect.height -= 2
    if setting[:vertical]
      rect.height = rect.height * @rate
    else
      rect.width = rect.width * @rate
    end
    self.bitmap.gradient_fill_rect(rect, color1, color2)
  end
  
  #--------------------------------------------------------------------------
  # refresh_type1
  #--------------------------------------------------------------------------
  def refresh_type1
    self.bitmap = Cache.system(setting_type[:filename]) if self.bitmap.nil?
    #---
    width = self.bitmap.width
    height = self.bitmap.height
    if setting[:vertical]
      height = height * @rate
    else
      width = width * @rate
    end
    self.src_rect.set(0, 0, width, height)
  end
  
  #--------------------------------------------------------------------------
  # refresh_type2
  #--------------------------------------------------------------------------
  def refresh_type2
    self.bitmap = Cache.system(setting_type[:filename]) if self.bitmap.nil?
    #---
    frames = setting_type[:frames]
    rate   = 1.0 / frames
    width  = self.bitmap.width / frames
    height = self.bitmap.height
    x      = [(@rate / rate).floor, frames - 1].min * width
    self.src_rect.set(x, 0, width, height)
  end
    
  #--------------------------------------------------------------------------
  # real_rate
  #--------------------------------------------------------------------------
  def real_rate
    e1 = @battler.exp - @battler.current_level_exp
    e2 = @battler.next_level_exp - @battler.current_level_exp
    return e1.to_f / e2
  end
    
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    BattleLuna::Addon::YEA_VICTORY::EXP_BAR
  end
  
  #--------------------------------------------------------------------------
  # setting_type
  #--------------------------------------------------------------------------
  def setting_type
    type = setting[:type]
    setting[eval(":type_#{type}")]
  end
  
  #--------------------------------------------------------------------------
  # screen_x
  #--------------------------------------------------------------------------
  def screen_x
    @window.item_rect(@index).x + @window.spacing + @window.x + setting[:offset_x]
  end
  
  #--------------------------------------------------------------------------
  # screen_y
  #--------------------------------------------------------------------------
  def screen_y
    @window.item_rect(@index).y + @window.spacing + @window.y + setting[:offset_y]
  end
  
  #--------------------------------------------------------------------------
  # screen_z
  #--------------------------------------------------------------------------
  def screen_z
    @window.z + setting[:offset_z]
  end
    
  #--------------------------------------------------------------------------
  # real_opacity
  #--------------------------------------------------------------------------
  def real_opacity
    @window.openness
  end
  
  #--------------------------------------------------------------------------
  # dispose
  #--------------------------------------------------------------------------
  def dispose
    super
    @popup.clear
  end
  
end # SpriteVictory_Bar

#==============================================================================
# ■ Spriteset_Victory
#==============================================================================

class Spriteset_Victory
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize(viewport, window)
    @viewport = viewport
    @window = window
    @sprites = []
    setup_sprites
  end
  
  #--------------------------------------------------------------------------
  # setup_sprites
  #--------------------------------------------------------------------------
  def setup_sprites
    $game_party.battle_members.each_with_index { |actor, index|
      sprite = SpriteVictory_Bar.new(@viewport, @window, index)
      @sprites.push(sprite)
    }
  end
  
  #--------------------------------------------------------------------------
  # dispose
  #--------------------------------------------------------------------------
  def dispose
    @sprites.each { |s| s.dispose }
  end
  
  #--------------------------------------------------------------------------
  # update
  #--------------------------------------------------------------------------
  def update
    @sprites.each { |s| s.update }
  end
  
  #--------------------------------------------------------------------------
  # is_tick?
  #--------------------------------------------------------------------------
  def is_tick?
    @sprites.any? { |s| s.is_tick? }
  end
  
  #--------------------------------------------------------------------------
  # set_exp
  #--------------------------------------------------------------------------
  def set_exp(exp)
    @sprites.each { |s| s.set_exp(exp) }
  end
  
end # Spriteset_Victory

#==============================================================================
# ■ Window_VictoryEXP_Front
#==============================================================================

class Window_VictoryEXP_Front < Window_VictoryEXP_Back
  
  #--------------------------------------------------------------------------
  # draw_actor_exp
  #--------------------------------------------------------------------------
  def draw_actor_exp(actor, rect)
    # Removed
  end
  
end # Window_VictoryEXP_Front

#==============================================================================
# ■ Scene_Battle
#==============================================================================

class Scene_Battle < Scene_Base
  
  #--------------------------------------------------------------------------
  # alias method: create_victory_aftermath_windows
  #--------------------------------------------------------------------------
  alias battle_luna_create_victory_aftermath_windows create_victory_aftermath_windows
  def create_victory_aftermath_windows
    battle_luna_create_victory_aftermath_windows
    window = @victory_exp_window_front
    @victory_spriteset = Spriteset_Victory.new(window.viewport, window)
  end
  
  #--------------------------------------------------------------------------
  # new method: victory_set_exp
  #--------------------------------------------------------------------------
  def victory_set_exp(exp)
    @victory_spriteset.set_exp(exp)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: wait_for_exp_victory
  #--------------------------------------------------------------------------
  def wait_for_exp_victory
    @victory_spriteset.update
    while @victory_spriteset.is_tick?
      update_for_wait
      @victory_spriteset.update
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias battle_luna_yea_victory_update update
  def update
    battle_luna_yea_victory_update
    @victory_spriteset.update
  end
  
  #--------------------------------------------------------------------------
  # alias method: terminate
  #--------------------------------------------------------------------------
  alias battle_luna_yea_victory_terminate terminate
  def terminate
    battle_luna_yea_victory_terminate
    @victory_spriteset.dispose
  end
  
end # Scene_Battle