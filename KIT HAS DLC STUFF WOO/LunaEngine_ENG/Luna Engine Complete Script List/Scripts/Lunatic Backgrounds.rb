#==============================================================================
# ■ MenuLuna: Lunatic Backgrounds
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This section allows you to have custom backgrounds for most RPG Maker Menus.
#==============================================================================
# ■ Lunatic Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#
# Basic Command:
#
# ["$bitmap[Folder, \"FileName\"]", Opacity, Blend_mode, [Plane X, Plane Y]],
# Blend_mode can be 0, 1, 2 for normal, addition and substraction.
# Use Plane X and Plane Y for loop speed by X and Y coordinates.
# Blend_mode and [Plane X, Plane Y] can be removed.
#
# You can use multiple backgrounds. The priority display of the backgrounds is
# similar to the script order, the ones below will be higher than the ones
# listed above it. For example: 
#
# Frame1: [Animated 5 4]Menu_Background.png
# Frame2: [Animated 5 4]Menu_Background_2.png
# Frame3: [Animated 5 4]Menu_Background_3.png
# Frame4: [Animated 5 4]Menu_Background_4.png
# Frame5: [Animated 5 4]Menu_Background_5.png
#
# It means, Frame 5 will appear above 1/2/3/4 and so on.
#
# Background Command Examples:
#
# This setting doesn't work on the Title Screen.
# To use the current map as a background, 
# ["$map_bg", 255],
#
# To use a solid color as a background,
# ["$color[R, G, B]", 255],
#
# To use a horizontal gradient as a background,
# ["$horgrad[R1, G1, B1, R2, G2, B2]", 255],
# 
# To use a vertical gradient as a background,
# ["$vergrad[R1, G1, B1, R2, G2, B2]", 255],
#
# To use an animated background:
# ["$bitmap[System, \"[Animated A B]FileName\"]", 255],
# A is number of frames, B is wait time before changing to the next frame.
#
# Since Filenames are eval'ed, you can do something like below:
# $bitmap[Folder, \"Filename_\"+actor.actor.id.to_s]
# This will load Filename_ActorID base on the current actor's ID
# Only works on Skill/Equip/Status menu
#
#==============================================================================

$imported = {} if $imported.nil?
$imported["YEL-MenuLuna-Background"] = true

module MenuLuna
  module Addon

    module BaseMenu
    # -----------------------------------------------------------------
    # Adds a background to all menu scenes, except in battle.
    # -----------------------------------------------------------------
      BACKGROUND = [
        ["$map_bg", 255],
      ]
    end
    module TitleMenu
    # -----------------------------------------------------------------
    # Adds a background to the Title Screen
    # -----------------------------------------------------------------
      BACKGROUND = [
        
      ]
    end
    # -----------------------------------------------------------------
    # Adds a background to the Main Menu only.
    # -----------------------------------------------------------------
    module MainMenu
      BACKGROUND = [
       
      ]
    end
		# -----------------------------------------------------------------
    # Adds a background to the Item Menu only.
    # -----------------------------------------------------------------
    module ItemMenu
      BACKGROUND = [

      ]
    # -----------------------------------------------------------------
    # Adds a background to the Skill Menu only.
    # -----------------------------------------------------------------
    end
    module SkillMenu
      BACKGROUND = [

      ]
    end
    # -----------------------------------------------------------------
    # Adds a background to the Equip Menu only.
    # -----------------------------------------------------------------
    module EquipMenu
      BACKGROUND = [

      ]
    end
    # -----------------------------------------------------------------
    # Adds a background to the Status Menu only.
    # -----------------------------------------------------------------
    module StatusMenu
      BACKGROUND = [

      ]
    end
    # -----------------------------------------------------------------
    # Adds a background to the Save Menu only.
    # -----------------------------------------------------------------
    module SaveMenu
      BACKGROUND = [
        
      ]
    end
    # -----------------------------------------------------------------
    # Adds a background to the Load Menu only.
    # -----------------------------------------------------------------
    module LoadMenu
      BACKGROUND = [
        
      ]
    end
    # -----------------------------------------------------------------
    # Adds a background to the Shop Menu only.
    # -----------------------------------------------------------------
    module ShopMenu
      BACKGROUND = [

      ]
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
# ■ Plane_Luna
#==============================================================================

class Plane_Luna < Plane
  
  #--------------------------------------------------------------------------
  # set_scroll
  #--------------------------------------------------------------------------
  def set_scroll(x, y)
    @scroll_x = x
    @scroll_y = y
  end
  
  #--------------------------------------------------------------------------
  # update
  #--------------------------------------------------------------------------
  def update
    return if self.bitmap.nil? || self.bitmap.disposed?
    @scroll_x ||= 0
    @scroll_y ||= 0
    self.ox = self.ox + @scroll_x
    self.oy = self.oy + @scroll_y
    super rescue nil
  end
  
end

#==============================================================================
# ■ Scene_Base
#==============================================================================

class Scene_Base
  
  #--------------------------------------------------------------------------
  # new method: create_luna_background
  #--------------------------------------------------------------------------
  def create_luna_background
    setting = background_setting
    setting.each { |bg|
      text = bg[0]; opacity = bg[1]
      blend = bg[2] || 0; plane = !bg[3].nil?
      sprite  = plane ? Plane_Luna.new : Sprite.new
      sprites = nil
      bitmap  = Bitmap.new(Graphics.width, Graphics.height)
      if text =~ /\$bitmap\[(.*)\]/i
        value = $1.scan(/[^, ]+[^,]*/i)
        if value[1] =~ /\[ANIMATED (\d+) (\d+)\].*/i
          sprites = []
          index = @background_sprite.size
          @background_frame[index] = 0
          @background_max[index]   = $1.to_i
          @background_tick[index]  = $2.to_i
          @background_delay[index] = $2.to_i
          (0...@background_max[index]).each do |i|
            sprite = plane ? Plane_Luna.new : Sprite.new
            bitmap  = Bitmap.new(Graphics.width, Graphics.height)
            name  = i == 0 ? eval(value[1]) : eval(value[1]) + "_#{i+1}"
            cache = Cache.cache_extended(value[0], name)
            bitmap.blt(0, 0, cache, cache.rect.clone, opacity)
            sprite.bitmap = bitmap
            sprite.set_scroll(bg[3][0], bg[3][1]) if plane
            sprite.blend_type = blend
            sprite.visible = false if i > 0
            sprites.push(sprite)
          end
        else
          cache = Cache.cache_extended(value[0], eval(value[1]))
          bitmap.blt(0, 0, cache, cache.rect.clone, opacity)
        end
      elsif text =~ /\$map_bg/i
        cache = SceneManager.background_bitmap
        bitmap.blt(0, 0, cache, cache.rect.clone, opacity)
      elsif text =~ /\$color\[(.*)\]/i
        value = $1.scan(/\d+/)
        value.collect! { |i| i.to_i }
        cache = Bitmap.new(Graphics.width, Graphics.height)
        cache.fill_rect(cache.rect, Color.new(value[0], value[1], value[2]))
        bitmap.blt(0, 0, cache, cache.rect.clone, opacity)
      elsif text =~ /\$(.*)grad\[(.*)\]/i
        vertical = $1.downcase == "hor" ? false : true
        value = $2.scan(/\d+/)
        value.collect! { |i| i.to_i }
        color1 = Color.new(value[0], value[1], value[2])
        color2 = Color.new(value[3], value[4], value[5])
        cache = Bitmap.new(Graphics.width, Graphics.height)
        cache.gradient_fill_rect(cache.rect, color1, color2, vertical) 
        bitmap.blt(0, 0, cache, cache.rect.clone, opacity)
      end
      #---
      if sprites
        @background_sprite.push(sprites)
      else
        sprite.bitmap = bitmap
        sprite.set_scroll(bg[3][0], bg[3][1]) if plane
        sprite.blend_type = blend
        @background_sprite.push(sprite)
      end
    }
  end
  
  #--------------------------------------------------------------------------
  # new method: update_luna_background
  #--------------------------------------------------------------------------
  def update_luna_background
    return unless @background_sprite
    if @background_sprite.is_a?(Sprite)
      @background_sprite.update
    elsif @background_sprite.is_a?(Array)
      @background_sprite.each do |sprite|
        sprite.is_a?(Array) ? sprite.each {|s| s.update} : sprite.update
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # new method: update_background_animated
  #--------------------------------------------------------------------------
  def update_background_animated
    return unless @background_tick
    @background_tick.each do |key, val|
      @background_tick[key] -= 1
      if @background_tick[key] <= 0
        @background_tick[key]  = @background_delay[key]
        @background_frame[key] = @background_frame[key] + 1
        @background_frame[key] = @background_frame[key] % @background_max[key]
        @background_sprite[key].each_with_index do |sprite, index|
          if @background_frame[key] == index
            sprite.visible = true
          else
            sprite.visible = false
          end # endif
        end # endeach
      end # endif
    end # endeach
  end
  
  #--------------------------------------------------------------------------
  # new method: dispose_luna_background
  #--------------------------------------------------------------------------
  def dispose_luna_background
    return unless @background_sprite
    if @background_sprite.is_a?(Sprite)
      @background_sprite.bitmap.dispose 
      @background_sprite.dispose
    end
    if @background_sprite.is_a?(Array)
      @background_sprite.each do |sprite|
        if sprite.is_a?(Array)
          sprite.each do |s|
            s.bitmap.dispose
            s.dispose
          end
        else
          sprite.bitmap.dispose
          sprite.dispose
        end
      end
      @background_sprite.clear
    end
  end
  
end # Scene_Base

#==============================================================================
# ■ Scene_Title
#==============================================================================

class Scene_Title < Scene_Base
  
  #--------------------------------------------------------------------------
  # alias method: create_background
  #--------------------------------------------------------------------------
  alias menu_luna_bg_create_background create_background
  def create_background
    return menu_luna_bg_create_background if background_setting.size == 0
    @background_sprite = []
    @background_frame  = {}
    @background_max    = {}
    @background_tick   = {}
    @background_delay  = {}
    create_luna_background
  end
  
  #--------------------------------------------------------------------------
  # alias method: create_foreground
  #--------------------------------------------------------------------------
  alias menu_luna_bg_create_foreground create_foreground
  def create_foreground
    menu_luna_bg_create_foreground if background_setting.size == 0
  end

  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias menu_luna_background_update_basic update_basic
  def update_basic
    menu_luna_background_update_basic
    update_background_animated
    update_luna_background
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: dispose_background
  #--------------------------------------------------------------------------
  def dispose_background
    @sprite1.dispose if @sprite1
    @sprite2.dispose if @sprite2
    dispose_luna_background
  end
  
  #--------------------------------------------------------------------------
  # new method: background_setting
  #--------------------------------------------------------------------------
  def background_setting
    MenuLuna::Addon::TitleMenu::BACKGROUND
  end
  
end # Scene_Title

#==============================================================================
# ■ Scene_MenuBase
#==============================================================================

class Scene_MenuBase < Scene_Base
  
  #--------------------------------------------------------------------------
  # alias method: create_background
  #--------------------------------------------------------------------------
  alias menu_luna_bg_create_background create_background
  def create_background
    return menu_luna_bg_create_background unless background_setting
    @background_sprite = []
    @background_frame  = {}
    @background_max    = {}
    @background_tick   = {}
    @background_delay  = {}
    create_luna_background
  end
    
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias menu_luna_background_update_basic update_basic
  def update_basic
    menu_luna_background_update_basic
    update_background_animated
    update_luna_background
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: dispose_background
  #--------------------------------------------------------------------------
  def dispose_background
    dispose_luna_background
  end
  
  #--------------------------------------------------------------------------
  # new method: background_setting
  #--------------------------------------------------------------------------
  def background_setting
    default = MenuLuna::Addon::BaseMenu::BACKGROUND
    case self.class.name
    when "Scene_Menu"; bmodule = "MainMenu"
    when "Scene_Item"; bmodule = "ItemMenu"
    when "Scene_Skill"; bmodule = "SkillMenu"
    when "Scene_Equip"; bmodule = "EquipMenu"
    when "Scene_Status"; bmodule = "StatusMenu"
    when "Scene_Save"; bmodule = "SaveMenu"
    when "Scene_Load"; bmodule = "LoadMenu"
    when "Scene_Shop"; bmodule = "ShopMenu"
    end
    return [] + default unless bmodule
    return default + eval("MenuLuna::Addon::#{bmodule}::BACKGROUND")
  end
  
  #--------------------------------------------------------------------------
  # new method: actor
  #--------------------------------------------------------------------------
  def actor
    @actor || $game_party.menu_actor
  end
  
  #--------------------------------------------------------------------------
  # alias method: next_actor
  #--------------------------------------------------------------------------
  alias luna_menu_background_next_actor next_actor
  def next_actor
    luna_menu_background_next_actor
    change_background_luna
  end
  
  #--------------------------------------------------------------------------
  # alias method: prev_actor
  #--------------------------------------------------------------------------
  alias luna_menu_background_prev_actor prev_actor
  def prev_actor
    luna_menu_background_prev_actor
    change_background_luna
  end
  
  #--------------------------------------------------------------------------
  # new method: change_background_luna
  #--------------------------------------------------------------------------
  def change_background_luna
    dispose_background
    create_background
    update_basic
  end
  
end # Scene_Menu

#==============================================================================
# ■ Scene_End
#==============================================================================

class Scene_End < Scene_MenuBase
  
  #--------------------------------------------------------------------------
  # overwrite method: create_background
  #--------------------------------------------------------------------------
  def create_background
    super
    return unless @background_sprite
    if @background_sprite.is_a?(Sprite)
      @background_sprite.tone.set(0, 0, 0, 128)
    end
    if @background_sprite.is_a?(Array)
      @background_sprite.each do |sprite|
        if sprite.is_a?(Array)
          sprite.each do |s|
            s.tone.set(0, 0, 0, 128)
          end
        else
          sprite.tone.set(0, 0, 0, 128)
        end
      end
    end
  end
  
end # Scene_End