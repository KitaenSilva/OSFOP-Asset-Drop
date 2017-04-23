#==============================================================================
# ■ BattleLuna: Enemy HP Bars Add-On
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Adds an Enemy HP Bar whenever you select an enemy target.
# Put all the images in Graphics/System
#==============================================================================
# ■ Lunatic Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Notetags Guide:
#    Put them inside Enemy Notes Box. 
#
# 1, <enemy hp main: Filename>
#    Change Main filename for Enemy.
# 2, <enemy hp bar: Filename, Frame>
#    Change HP bar filename for Type 2.
# 3, <enemy hp bar: Filename>
#    Change HP bar filename for Type 1.
# 4, <enemy hp main offset: X, Y>
#    Change Main offset.
# 5, <enemy hp bar offset: X, Y>
#    Change HP Bar offset.
#
#==============================================================================
$imported = {} if $imported.nil?
$imported["YEL-BattleLuna-EnemyHPBars"] = true

module BattleLuna
  module Addon
    ENEMY_HP_BARS = {
	#--------------------------------------------------------------------------
  # * Main Settings for the Enemy HP Bar Add-On
  #--------------------------------------------------------------------------
      :main       =>  {
        :enable   =>  true,				 # Enable Enemy HP Bars Add-On? True/False
        :offset_x =>  0,					 # Offset in X Position from the enemy battler.
        :offset_y =>  0,					 # Offset in Y Position from the enemy battler.
        :offset_z =>  10,					 # Offset in Z Position from the enemy battler.
        :filename =>  "Skin_Main", # Picture Filename
      }, # End main.
      
	#--------------------------------------------------------------------------
  # * Enemy HP Bar Settings
  #--------------------------------------------------------------------------
      :hp_bar     =>  {
        :enable   =>  true,				 # Enable Enemy HP Bars? True/False
        :offset_x =>  0,					 # Offset in X Position from the main settings.
        :offset_y =>  0,					 # Offset in Y Position from the main settings.
        :offset_z =>  100,				 # Offset in Z Position from the main settings.
		  # -----------------------------------------------------------------
      # Type allows you to set the type of graphic you want to use.
      # 0 - Default bar; 1 - Custom bar; 2 - Custom animated bar.
      # -----------------------------------------------------------------       
        :type     =>  0,
        :vertical =>  false,			 # Display vertically? True/False 
																	 # Works for type 0 and 1.
        #---
        :type_0   =>  {
        # ----------------------------------------------------------------- 
        # Set the color for the bar background. [R,G,B,A]
        # You can also use normal_color to use the default windowskin colors.
        # -----------------------------------------------------------------        
          :back_color =>  [0, 0, 0, 255],
        # -----------------------------------------------------------------   
        # color1 = refers to the first color of the gradient. ([R,G,B,A])
        # color2 = refers to the second color of the gradient. ([R,G,B,A])
        # normal_color refers to the color of your default windowskin.
        # -----------------------------------------------------------------  
          :color1     =>  [255, 16, 16, 255],
          :color2     =>  [255, 64, 64, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # -----------------------------------------------------------------   
          :outline    =>  [0, 0, 0, 255],
          :length     =>  76,					 	  # Width/Length of the bar.
          :height     =>  12,  					  # Height of the bar.
        # ----------------------------------------------------------------- 
        # This section allows you to customize the "HP" Vocab display.
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # ----------------------------------------------------------------- 
          :offset_x =>  220,
          :offset_y =>  -14,
          :offset_z =>  5,
        # ----------------------------------------------------------------- 
        # Set the color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default font color.
        # -----------------------------------------------------------------  
          :tcolor   =>  [255, 255, 255, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # ----------------------------------------------------------------- 
          :toutline =>  [0, 0, 0, 255],
          :bold     =>  true,							 # Enable Bold? True/False
          :italic   =>  false,						 # Enable Italic? True/False
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  0,
          :font     =>  "VL Gothic",			 # Set Font type.
          :size     =>  24,       			   # Set Font Size
          :text     =>  "HP",     			   # Change "HP" Vocab.
        },
        #---
        :type_1   =>  {
          :filename =>  "physbar-fill",    # Custom HP Bar Filename.
        },
        #---
        :type_2   =>  {
          :filename =>  "Btskin_hp",			 # Custom Frame-based MP Bar Filename.
          :frames   =>  10,                # Amount of animation frames.
        },
      }, # End hp_bar.
    }
  end
end
#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================
#==============================================================================
# ■ Regular Expression
#==============================================================================

module REGEXP
  module LUNA_ENEMY_HP_BARS
    MAIN_NAME = /<enemy hp main:[ ]*(.*)>/i
    
    HP_FRAMENAME = /<enemy hp bar:[ ]*(.*),[ ]*(\d+)>/i
    HP_FILENAME = /<enemy hp bar:[ ]*(.*)>/i
    
    HP_MAIN_OFFSET = /<enemy hp main offset:[ ]*(\d+),[ ]*(\d+)>/i
    HP_BAR_OFFSET = /<enemy hp bar offset:[ ]*(\d+),[ ]*(\d+)>/i
  end # LUNA_ENEMY_HP_BARS
end # REGEXP

#==============================================================================
# ■ DataManager
#==============================================================================

module DataManager
    
  #--------------------------------------------------------------------------
  # alias method: load_database
  #--------------------------------------------------------------------------
  class <<self; alias load_database_luna_ehpba load_database; end
  def self.load_database
    load_database_luna_ehpba
    initialize_luna_ehpba
  end
  
  #--------------------------------------------------------------------------
  # new method: initialize_luna_ehpba
  #--------------------------------------------------------------------------
  def self.initialize_luna_ehpba
    groups = [$data_enemies]
    groups.each { |group|
      group.each { |obj|
        next if obj.nil?
        obj.initialize_luna_ehpba
      }
    }
  end
  
end # DataManager

#==============================================================================
# ■ RPG::BaseItem
#==============================================================================

class RPG::BaseItem
  
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_accessor :ehpb_main
  attr_accessor :ehpb_frame
  attr_accessor :ehpb_filename
  attr_accessor :ehpb_main_offset
  attr_accessor :ehpb_bar_offset

  #--------------------------------------------------------------------------
  # new method: initialize_luna_ehpba
  #--------------------------------------------------------------------------
  def initialize_luna_ehpba
    setting = BattleLuna::Addon::ENEMY_HP_BARS
    @ehpb_main = setting[:main][:filename]
    @ehpb_frame = [setting[:hp_bar][:type_2][:filename], setting[:hp_bar][:type_2][:frames]]
    @ehpb_filename = setting[:hp_bar][:type_1][:filename]
    @ehpb_bar_offset = [setting[:hp_bar][:offset_x], setting[:hp_bar][:offset_y]]
    @ehpb_main_offset = [setting[:main][:offset_x], setting[:main][:offset_y]]
    self.note.split(/[\r\n]+/).each { |line|
      case line
      when REGEXP::LUNA_ENEMY_HP_BARS::MAIN_NAME
        @ehpb_main = $1
      when REGEXP::LUNA_ENEMY_HP_BARS::HP_FRAMENAME
        @ehpb_frame = [$1, $2.to_i]
      when REGEXP::LUNA_ENEMY_HP_BARS::HP_FILENAME
        @ehpb_filename = $1
      when REGEXP::LUNA_ENEMY_HP_BARS::HP_MAIN_OFFSET
        @ehpb_main_offset = [$1.to_i, $2.to_i]
      when REGEXP::LUNA_ENEMY_HP_BARS::HP_BAR_OFFSET
        @ehpb_bar_offset = [$1.to_i, $2.to_i]
      end
    }
  end
  
end # RPG::BaseItem

#==============================================================================
# ■ Game_Enemy
#==============================================================================

class Game_Enemy < Game_Battler
  
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_accessor :targeted
  
end # Game_Enemy

#==============================================================================
# ■ Window_BattleActor
#==============================================================================

class Window_BattleEnemy < Window_Selectable
  
  #--------------------------------------------------------------------------
  # alias method: update_highlight
  #--------------------------------------------------------------------------
  alias battle_luna_ehpba_update_highlight update_highlight rescue false
  def update_highlight
    reset_targeted
    return unless self.active
    return unless enemy
    battle_luna_ehpba_update_highlight rescue false
    enemy.targeted = true
    return unless @cursor_all
    $game_troop.alive_members.each { |enemy| enemy.targeted = true }
  end
  
  #--------------------------------------------------------------------------
  # new method: reset_targeted
  #--------------------------------------------------------------------------
  def reset_targeted
    $game_troop.alive_members.each { |enemy| enemy.targeted = false }
  end

end # Window_BattleEnemy

#==============================================================================
# ■ SpriteEnemy_Bar
#==============================================================================

class SpriteEnemy_Bar < SpriteHUD_Bar
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize(viewport, spriteset, symbol)
    @real_opacity = 0
    super(viewport, spriteset, symbol)
  end
  
  #--------------------------------------------------------------------------
  # refresh_type1
  #--------------------------------------------------------------------------
  def refresh_type1
    self.bitmap = Cache.system(@battler.enemy.ehpb_filename) if self.bitmap.nil?
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
    self.bitmap = Cache.system(@battler.enemy.ehpb_frame[0]) if self.bitmap.nil?
    #---
    frames = @battler.enemy.ehpb_frame[1]
    rate   = 1.0 / frames
    width  = self.bitmap.width / frames
    height = self.bitmap.height
    x      = (@rate / rate).floor * width
    self.src_rect.set(x, 0, width, height)
  end
  
  #--------------------------------------------------------------------------
  # update
  #--------------------------------------------------------------------------
  def update
    return unless setting[:enable]
    #---
    super
    update_opacity
  end
  
  #--------------------------------------------------------------------------
  # update_opacity
  #--------------------------------------------------------------------------
  def update_opacity
    if @battler.targeted
      @real_opacity += [32, 255 - @real_opacity].min
    else
      @real_opacity -= [32, @real_opacity].min
    end
  end
  
  #--------------------------------------------------------------------------
  # update_rate
  #--------------------------------------------------------------------------
  def update_rate
    rate = (@rate - real_rate).abs
    @rate += @rate > real_rate ? -rate : rate
    refresh if rate > 0
  end
  
  #--------------------------------------------------------------------------
  # screen_x
  #--------------------------------------------------------------------------
  def screen_x
    (@spriteset.x || 0) + @battler.enemy.ehpb_bar_offset[0]
  end
  
  #--------------------------------------------------------------------------
  # screen_y
  #--------------------------------------------------------------------------
  def screen_y
    (@spriteset.y || 0) + @battler.enemy.ehpb_bar_offset[1]
  end
  
  #--------------------------------------------------------------------------
  # screen_z
  #--------------------------------------------------------------------------
  def screen_z
    (@spriteset.z || 0) + setting[:offset_z]
  end
  
  #--------------------------------------------------------------------------
  # text_x
  #--------------------------------------------------------------------------
  def text_x
    (@spriteset.x || 0) + setting_type[:offset_x]
  end
  
  #--------------------------------------------------------------------------
  # text_y
  #--------------------------------------------------------------------------
  def text_y
    (@spriteset.y || 0) + setting_type[:offset_y]
  end
  
  #--------------------------------------------------------------------------
  # text_z
  #--------------------------------------------------------------------------
  def text_z
    (@spriteset.z || 0) + setting_type[:offset_z]
  end
  
  #--------------------------------------------------------------------------
  # real_opacity
  #--------------------------------------------------------------------------
  def real_opacity
    @real_opacity
  end
  
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    BattleLuna::Addon::ENEMY_HP_BARS[@symbol]
  end
  
end # SpriteEnemy_Bar

#==============================================================================
# ■ SpriteEnemy_Main
#==============================================================================

class SpriteEnemy_Main < SpriteHUD_Main
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize(viewport, spriteset)
    @real_opacity = 0
    super(viewport, spriteset)
  end
  
  #--------------------------------------------------------------------------
  # init_visible
  #--------------------------------------------------------------------------
  def init_visible
    # Remove
  end
  
  #--------------------------------------------------------------------------
  # update
  #--------------------------------------------------------------------------
  def update
    return unless setting[:enable]
    #---
    super
    update_opacity
  end
  
  #--------------------------------------------------------------------------
  # update_highlight
  #--------------------------------------------------------------------------
  def update_highlight
    # Remove
  end
  
  #--------------------------------------------------------------------------
  # update_tone
  #--------------------------------------------------------------------------
  def update_tone
    # Remove
  end
  
  #--------------------------------------------------------------------------
  # update_opacity
  #--------------------------------------------------------------------------
  def update_opacity
    if @battler.targeted
      @real_opacity += [32, 255 - @real_opacity].min
    else
      @real_opacity -= [32, @real_opacity].min
    end
  end
  
  #--------------------------------------------------------------------------
  # main_change?
  #--------------------------------------------------------------------------
  def real_name
    result = @battler.enemy.ehpb_main
    result
  end
  
  #--------------------------------------------------------------------------
  # screen_x
  #--------------------------------------------------------------------------
  def screen_x
    (@spriteset.x || 0) + @battler.enemy.ehpb_main_offset[0]
  end
  
  #--------------------------------------------------------------------------
  # screen_y
  #--------------------------------------------------------------------------
  def screen_y
    (@spriteset.y || 0) + @battler.enemy.ehpb_main_offset[1]
  end
  
  #--------------------------------------------------------------------------
  # screen_z
  #--------------------------------------------------------------------------
  def screen_z
    @spriteset.z || 0 + setting[:offset_z]
  end
    
  #--------------------------------------------------------------------------
  # real_opacity
  #--------------------------------------------------------------------------
  def real_opacity
    @real_opacity
  end
  
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    BattleLuna::Addon::ENEMY_HP_BARS[:main]
  end
  
end # SpriteEnemy_Main

#==============================================================================
# ■ Sprite_Battler
#==============================================================================

class Sprite_Battler < Sprite_Base
  
  #--------------------------------------------------------------------------
  # alias method: update_bitmap
  #--------------------------------------------------------------------------
  alias battle_luna_ehpba_update_bitmap update_bitmap
  def update_bitmap
    return if @battler.battler_name == ""
    battle_luna_ehpba_update_bitmap
    return if @battler.actor?
    @hp_bar ||= SpriteEnemy_Bar.new(self.viewport, self, :hp_bar)
    @hp_main ||= SpriteEnemy_Main.new(self.viewport, self)
    @hp_bar.update
    @hp_main.update
  end
  
  #--------------------------------------------------------------------------
  # alias method: dispose
  #--------------------------------------------------------------------------
  alias battle_luna_ehpba_dispose dispose
  def dispose
    battle_luna_ehpba_dispose
    @hp_bar.dispose if @hp_bar
    @hp_main.dispose if @hp_main
  end
  
end # Sprite_Battler