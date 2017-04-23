#==============================================================================
# ■ BattleLuna: Actor Command Configuration
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This script allows you to have more option for Battle Command such as:
# * Allows you to have a description for every command.
# * Allows you to have a ring menu command
#==============================================================================

$imported = {} if $imported.nil?
$imported["YEL-BattleActorCommands"] = true

module BattleLuna
  module Addon
    ACTOR_COMMANDS = { # Do not remove this.
		# -----------------------------------------------------------------
    # This section adds a help window for actor commands.
    # -----------------------------------------------------------------
      :help   => {
        :enable => true,	# Enable Actor Command Help? True/False
        :text   =>  {
		# -----------------------------------------------------------------
    # This is the array that handles the command help description.
		# This is also where you can add extra commands to have description.
    # -----------------------------------------------------------------
          "Attack"  =>  "Basic Attack.\nHell yeah!",
          "Special" =>  "Magic Attack.\nF*** yeah!",
				# "Magic"  =>   "This is a secondary Magic Attack!" 
          "Items"   =>  "Open Inventory.\nHoly s***!",
          "Escape"  =>  "Run for your life.\nRun chicken run!",
          "Guard"   =>  "Guard your a**.\nFacepalm!",
        },
      },
		# -----------------------------------------------------------------
    # This determines if you want an image or ring menu add-on for your 
		# actor command. 0 - Disable; 1 - Image-Based; 2 - Spin Command
    # -----------------------------------------------------------------
      :type =>  0, 
			
		# -----------------------------------------------------------------
    # Image Based Commands. This is how we made our Persona 3 GUI video.
    # -----------------------------------------------------------------
      :type_1 =>  {
        :filename   =>  "Skin_ActorWindow",		# Filename of the Image.
        # Filename bases: will be added in following order.
        # Remember to add index at the end of filename for each highlighting
        # index. For example: when highlight index 0, this script will search
        # for Filename_0.
        :base_actor =>  false,  # Filename based on actor ID.
        :base_class =>  false,  # Filename based on class ID.
        :base_index =>  false,  # Filename based on number of indexs.
                                # For example: Actor A has 5 commands, filename
                                # will be Skin_ActorWindow_5.
      },
		# -----------------------------------------------------------------
    # Spin Command. Are you a fan of Ziffee Ring Command? This is basically it.
    # -----------------------------------------------------------------
      :type_2 =>  {
        :radius     =>  40,			# Set a radius for the icons to rotate.
        :cursor     =>  "RollIconCursor",
        :speed      =>  6,      # The higher the number, the slower spinning speed.
        :all_dir    =>  true,   # Set to true to spin commands by all 
                                # LEFT RIGHT UP DOWN.
        :select_angle => 90,    # In degrees.
        :icons      =>  {       # Set the Icon Index for each actor command.
          "Attack"  =>  116,
          "Special" =>  143,
				# "Magic"   =>	117,    
          "Items"   =>  212,
          "Escape"  =>  12,
          "Guard"   =>  506,
          "Heal"    =>  112,
        },
        :selecticon =>  true,   # Use only for custom icon, added to filename
                                # when selecting: _select
		# -----------------------------------------------------------------
    # This modifies the text display in the middle of the ring.
    # -----------------------------------------------------------------
        :text       =>  {
          :enable   =>  true,
          :width    =>  120,
          :height   =>  24,
          :offset_x =>  0,
          :offset_y =>  0,
          :offset_z =>  0,
          :color    =>  [255, 255, 255, 255],
          :outline  =>  [0, 0, 0, 255],
          :bold     =>  true,
          :italic   =>  false,
          :align    =>  1,
          :font     =>  "Times New Roman",
          :size     =>  18,
        },
      },
    } # Do not remove this.
  end # Addon
end # BattleLuna

#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================
#==============================================================================
# ■ Spriteset_SpinCommand
#==============================================================================

class Spriteset_SpinCommand
  
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_accessor :right
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize(viewport, command_window)
    @viewport    = viewport
    @window      = command_window
    @sprites     = []
    @angles      = []
    @list        = []
    @right       = false
    @index       = 0
    #---
    @text_sprite   = Sprite.new(@viewport)
    #---
    cursor = BattleLuna::Addon::ACTOR_COMMANDS[:type_2][:cursor]
    @cursor_sprite = Sprite.new(@viewport)
    @cursor_sprite.bitmap = Cache.system(cursor)
    #---
    update
  end
  
  #--------------------------------------------------------------------------
  # setup
  #--------------------------------------------------------------------------
  def setup(list)
    @sprites.each { |v| v.dispose }
    @sprites.clear
    @angles.clear
    @list.clear
    @index = @window.index
    #---
    @list = list
    #---
    icon_bitmap = Cache.system("Iconset")
    @list.each_with_index { |item, index|
      sprite     = Sprite.new(@viewport)
      #---
      icon_index = icon(item[:name])
      case icon_index.class.name
      when "Fixnum"
        bitmap = Bitmap.new(24, 24)
        rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
        bitmap.blt(0, 0, icon_bitmap, rect)
        sprite.bitmap = bitmap
      when "String"
        sprite.bitmap = Cache.system(icon_index)
      end
      #---
      sprite.ox = sprite.width / 2
      sprite.oy = sprite.height / 2
      sprite.x = x + radius * Math::cos(angle_item * index + start_angle)
      sprite.y = y - radius * Math::sin(angle_item * index + start_angle)
      sprite.z = z
      @angles[index] = 0
      @sprites.push(sprite)
    }
    #---
    set_text(@index)
  end
  
  #--------------------------------------------------------------------------
  # set_index
  #--------------------------------------------------------------------------
  def set_text(index)
    text_setting = BattleLuna::Addon::ACTOR_COMMANDS[:type_2][:text]
    return unless text_setting[:enable]
    @text_sprite.bitmap.dispose if @text_sprite.bitmap
    bitmap = Bitmap.new(text_setting[:width], text_setting[:height])
    #---
    color = text_setting[:color]
    out   = text_setting[:outline]
    bitmap.font.name = text_setting[:font]
    bitmap.font.size = text_setting[:size]
    bitmap.font.bold = text_setting[:bold]
    bitmap.font.italic = text_setting[:italic]
    if color.is_a?(String)
      bitmap.font.color = eval(color)
    else
      bitmap.font.color = Color.new(color[0], color[1], color[2], color[3])
    end
    if out.is_a?(String)
      bitmap.font.out_color = eval(out)
    else
      bitmap.font.out_color = Color.new(out[0], out[1], out[2], out[3])
    end
    bitmap.draw_text(0, 0, bitmap.width, bitmap.height, @list[index][:name], text_setting[:align])
    #---
    @text_sprite.bitmap = bitmap
    @text_sprite.ox = @text_sprite.width / 2
    @text_sprite.oy = @text_sprite.height / 2
  end
  
  #--------------------------------------------------------------------------
  # set_index
  #--------------------------------------------------------------------------
  def set_index(index)
    return if @index == index
    @index = index
    @sprites.each_with_index { |sprite, i|
      @angles[i] = angle_item * speed
    }
    set_text(@index)
  end
  
  #--------------------------------------------------------------------------
  # update
  #--------------------------------------------------------------------------
  def update
    @sprites.each_with_index { |sprite, i| 
      sprite.update
      sprite.opacity = @window.openness
      sprite.visible = @window.visible
      #---
      item = @list[i]
      icon_index = icon(item[:name])
      if icon_index.class.name == "String" 
        if BattleLuna::Addon::ACTOR_COMMANDS[:type_2][:selecticon]
          if i == @index
            sprite.bitmap = Cache.system("#{icon_index}_select")
          else
            sprite.bitmap = Cache.system("#{icon_index}")
          end
        end
      end
    }
    #---
    @text_sprite.update
    @text_sprite.opacity = @window.openness
    @text_sprite.visible = @window.visible
    @text_sprite.x = x
    @text_sprite.y = y
    @text_sprite.z = z
    #---
    @cursor_sprite.update
    @cursor_sprite.opacity = @window.openness
    @cursor_sprite.visible = @window.visible
    @cursor_sprite.x = x
    @cursor_sprite.y = y - radius
    @cursor_sprite.z = z
    @cursor_sprite.ox = @cursor_sprite.width / 2
    @cursor_sprite.oy = @cursor_sprite.height / 2
    #---
    update_spin
  end
  
  #--------------------------------------------------------------------------
  # update_spin
  #--------------------------------------------------------------------------
  def update_spin
    @sprites.each_with_index { |sprite, i|
      @angles[i] = [0, @angles[i] - 1].max
      angle = @angles[i] / speed
      angle = @right ? angle : -angle
      n = (i - @index) * angle_item + angle + start_angle
      sprite.x = x + radius * Math::cos(n)
      sprite.y = y - radius * Math::sin(n)
    }
  end
  
  #--------------------------------------------------------------------------
  # dispose
  #--------------------------------------------------------------------------
  def dispose
    @sprites.each { |sprite| sprite.dispose }
    @text_sprite.dispose
  end
  
  #--------------------------------------------------------------------------
  # icon
  #--------------------------------------------------------------------------
  def icon(name)
    BattleLuna::Addon::ACTOR_COMMANDS[:type_2][:icons][name]
  end
  
  #--------------------------------------------------------------------------
  # x
  #--------------------------------------------------------------------------
  def x
    @window.x + @window.width / 2
  end
  
  #--------------------------------------------------------------------------
  # y
  #--------------------------------------------------------------------------
  def y
    @window.y + @window.height / 2
  end
  
  #--------------------------------------------------------------------------
  # z
  #--------------------------------------------------------------------------
  def z
    @window.z
  end
  
  #--------------------------------------------------------------------------
  # radius
  #--------------------------------------------------------------------------
  def radius
    BattleLuna::Addon::ACTOR_COMMANDS[:type_2][:radius]
  end
  
  #--------------------------------------------------------------------------
  # speed
  #--------------------------------------------------------------------------
  def speed
    BattleLuna::Addon::ACTOR_COMMANDS[:type_2][:speed]
  end
  
  #--------------------------------------------------------------------------
  # angle_item
  #--------------------------------------------------------------------------
  def angle_item
    Math::PI * 2 / [@list.size, 1].max
  end
  
  #--------------------------------------------------------------------------
  # start_angle
  #--------------------------------------------------------------------------
  def start_angle
    result = BattleLuna::Addon::ACTOR_COMMANDS[:type_2][:select_angle]
    result = result * Math::PI / 180.0
    result
  end
  
  #--------------------------------------------------------------------------
  # moving?
  #--------------------------------------------------------------------------
  def moving?
    return @angles.any? { |x| x > 0 }
  end
  
end # Spriteset_SpinCommand

#==============================================================================
# ■ Window_ActorCommand
#==============================================================================

class Window_ActorCommand < Window_Command
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  alias battle_luna_ac_initialize initialize
  def initialize
    battle_luna_ac_initialize
    refresh_custom_commands
  end
  
  #--------------------------------------------------------------------------
  # alias method: init_position
  #--------------------------------------------------------------------------
  alias battle_luna_ac_init_position init_position
  def init_position
    battle_luna_ac_init_position
    init_position_addon
  end
  
  #--------------------------------------------------------------------------
  # alias method: actor_position
  #--------------------------------------------------------------------------
  alias battle_luna_ac_actor_position actor_position
  def actor_position
    battle_luna_ac_actor_position
    actor_position_addon
  end
  
  #--------------------------------------------------------------------------
  # new method: init_position_addon
  #--------------------------------------------------------------------------
  def init_position_addon
    return unless addon_setting[:type] == 1
    @commands_sprite.x = init_screen_x
    @commands_sprite.y = init_screen_y
    @commands_sprite.z = init_screen_z
  end
  
  #--------------------------------------------------------------------------
  # new method: actor_position_addon
  #--------------------------------------------------------------------------
  def actor_position_addon
    return unless addon_setting[:type] == 1
    @commands_sprite.x = destination_x
    @commands_sprite.y = destination_y
    @commands_sprite.z = init_screen_z
  end
  
  #--------------------------------------------------------------------------
  # new method: addon_setting
  #--------------------------------------------------------------------------
  def addon_setting
    BattleLuna::Addon::ACTOR_COMMANDS
  end
  
  #--------------------------------------------------------------------------
  # new method: addon_type1_name
  #--------------------------------------------------------------------------
  def addon_type1_name
    result = addon_setting[:type_1][:filename]
    result += "_#{@actor.actor.id}" if addon_setting[:type_1][:base_actor]
    result += "_#{@actor.class.id}" if addon_setting[:type_1][:base_class]
    result += "_#{item_max}" if addon_setting[:type_1][:base_index]
    result += "_#{index}"
    result
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_custom_commands
  #--------------------------------------------------------------------------
  def refresh_custom_commands
    case addon_setting[:type]
    when 1; refresh_addon_type1
    when 2; refresh_addon_type2
    end
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_addon_type1
  #--------------------------------------------------------------------------
  def refresh_addon_type1
    @commands_sprite ||= Sprite.new(self.viewport)
    return unless @actor
    @commands_sprite.bitmap = Cache.system(addon_type1_name)
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_addon_type2
  #--------------------------------------------------------------------------
  def refresh_addon_type2
    @commands_sprite ||= Spriteset_SpinCommand.new(self.viewport, self)
  end
  
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias battle_luna_ac_update update
  def update
    battle_luna_ac_update
    update_addon
    update_addon_help
  end
  
  #--------------------------------------------------------------------------
  # new method: update_addon
  #--------------------------------------------------------------------------
  def update_addon
    case addon_setting[:type]
    when 1; update_addon_type1
    when 2; update_addon_type2
    end
  end
  
  #--------------------------------------------------------------------------
  # new method: update_addon_type1
  #--------------------------------------------------------------------------
  def update_addon_type1
    return unless @commands_sprite
    refresh_custom_commands
    @commands_sprite.update
    @commands_sprite.opacity = self.openness
    @commands_sprite.visible = self.visible
    self.contents_opacity = 0
    self.arrows_visible = false
  end
  
  #--------------------------------------------------------------------------
  # new method: update_addon_type2
  #--------------------------------------------------------------------------
  def update_addon_type2
    return unless @commands_sprite
    @commands_sprite.update
    self.contents_opacity = 0
    self.arrows_visible = false
  end
  
  #--------------------------------------------------------------------------
  # new method: update_addon_help
  #--------------------------------------------------------------------------
  def update_addon_help
    return unless @help_window
    return unless self.active
    return if @help_window.visible
    return if $game_troop.all_dead?
    @help_window.clear
    @help_window.show
    call_update_help
  end
  
  #--------------------------------------------------------------------------
  # alias method: setup
  #--------------------------------------------------------------------------
  alias battle_luna_ac_setup setup
  def setup(actor)
    battle_luna_ac_setup(actor)
    @commands_sprite.setup(@list) if addon_setting[:type] == 2
    @help_window.clear if @help_window
    @help_window.show if @help_window
    call_update_help
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: index
  #--------------------------------------------------------------------------
  def index=(index)
    super(index)
    return unless @commands_sprite
    return unless addon_setting[:type] == 2
    @commands_sprite.set_index(index)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: cursor_right
  #--------------------------------------------------------------------------
  def cursor_right(wrap = false)
    super(wrap)
    return unless addon_setting[:type] == 2
    @commands_sprite.right = true
    cursor_down(wrap) if addon_setting[:type_2][:all_dir]
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: cursor_left
  #--------------------------------------------------------------------------
  def cursor_left(wrap = false)
    super(wrap)
    return unless addon_setting[:type] == 2
    @commands_sprite.right = false
    cursor_up(wrap) if addon_setting[:type_2][:all_dir]
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: cursor_up
  #--------------------------------------------------------------------------
  def cursor_up(wrap = false)
    super(wrap)
    return unless addon_setting[:type] == 2
    @commands_sprite.right = false
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: cursor_down
  #--------------------------------------------------------------------------
  def cursor_down(wrap = false)
    super(wrap)
    return unless addon_setting[:type] == 2
    @commands_sprite.right = true
  end
  
  #--------------------------------------------------------------------------
  # alias method: col_max
  #--------------------------------------------------------------------------
  alias battle_luna_ac_col_max col_max
  def col_max
    return battle_luna_ac_col_max if addon_setting[:type] != 2
    addon_setting[:type_2][:all_dir] ? 1 : battle_luna_ac_col_max
  end
  
  #--------------------------------------------------------------------------
  # alias method: close
  #--------------------------------------------------------------------------
  alias battle_luna_ac_close close
  def close
    @help_window.hide if @help_window
    @help_window.clear if @help_window
    battle_luna_ac_close
  end
  #--------------------------------------------------------------------------
  # overwrite method: update_help
  #--------------------------------------------------------------------------
  def update_help
    return unless @index >= 0
    @help_window.set_text(addon_setting[:help][:text][@list[@index][:name]])
  end
  
end # Window_ActorCommand

#==============================================================================
# ■ Scene_Battle
#==============================================================================

class Scene_Battle < Scene_Base
  
  #--------------------------------------------------------------------------
  # alias method: create_help_window
  #--------------------------------------------------------------------------
  alias battle_luna_ac_create_help_window create_help_window
  def create_help_window
    battle_luna_ac_create_help_window
    return unless BattleLuna::Addon::ACTOR_COMMANDS[:help][:enable]
    @actor_command_window.help_window = @help_window
  end
  
  #--------------------------------------------------------------------------
  # alias method: start_actor_command_selection
  #--------------------------------------------------------------------------
  alias battle_luna_ac_start_actor_command_selection start_actor_command_selection
  def start_actor_command_selection
    battle_luna_ac_start_actor_command_selection
    @actor_command_window.call_update_help
  end
  
end # Scene_Battle