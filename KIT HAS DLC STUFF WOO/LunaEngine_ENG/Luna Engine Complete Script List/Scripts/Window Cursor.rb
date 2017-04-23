#==============================================================================
# ■ MenuLuna: Window Cursor 
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This allows you to have custom static or animated cursor for your menus.
#==============================================================================
# ■ Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Be sure to turn on/off default cursor in Luna Menu Configuration depending on
# how you want your cursor to be displayed.
#
# All images should be put in Graphics/System
# The cursor sheet should be arranged horizontally.
#==============================================================================

$imported = {} if $imported.nil?
$imported["YEL-MenuLuna-CustomCursor"] = true

# -----------------------------------------------------------------
# This section adds a custom cursor is for unlisted windows in this script.
# -----------------------------------------------------------------
module MenuLuna
  module OtherMenu
    CUSTOM_CURSOR = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
  end
# -----------------------------------------------------------------
# This section adds a custom cursor is for the main menu
# -----------------------------------------------------------------
  module MainMenu
    STATUS_WINDOW ||= {} # compatible line
    STATUS_WINDOW[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
    WINDOW_COMMANDS ||= {} # compatible line
    WINDOW_COMMANDS[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
  end
# -----------------------------------------------------------------
# This section adds a custom cursor is for the item menu
# -----------------------------------------------------------------  
  module ItemMenu
    WINDOW_CATEGORY ||= {} # compatible line
    WINDOW_CATEGORY[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
    WINDOW_ITEM ||= {} # compatible line
    WINDOW_ITEM[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
    STATUS_WINDOW ||= {} # compatible line
    STATUS_WINDOW[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
  end
# -----------------------------------------------------------------
# This section adds a custom cursor is for the skill menu
# -----------------------------------------------------------------  
  module SkillMenu
    WINDOW_CATEGORY ||= {} # compatible line
    WINDOW_CATEGORY[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
    WINDOW_ITEM ||= {} # compatible line
    WINDOW_ITEM[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
    STATUS_WINDOW ||= {} # compatible line
    STATUS_WINDOW[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
  end
# -----------------------------------------------------------------
# This section adds a custom cursor is for the save menu
# -----------------------------------------------------------------  
  module SaveMenu
    WINDOW_SAVE ||= {} # compatible line
    WINDOW_SAVE[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
  end
# -----------------------------------------------------------------
# This section adds a custom cursor is for the equip menu
# -----------------------------------------------------------------  
  module EquipMenu
    WINDOW_COMMANDS ||= {} # compatible line
    WINDOW_COMMANDS[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
    WINDOW_ITEM ||= {} # compatible line
    WINDOW_ITEM[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
    WINDOW_SLOT ||= {} # compatible line
    WINDOW_SLOT[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
  end
# -----------------------------------------------------------------
# This section adds a custom cursor is for the shop menu
# -----------------------------------------------------------------
  module ShopMenu
    WINDOW_COMMANDS ||= {} # compatible line
    WINDOW_COMMANDS[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
    WINDOW_CATEGORY ||= {} # compatible line
    WINDOW_CATEGORY[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
    WINDOW_ITEM_BUY ||= {} # compatible line
    WINDOW_ITEM_BUY[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
    WINDOW_ITEM_SELL ||= {} # compatible line
    WINDOW_ITEM_SELL[:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
  end
end

# -----------------------------------------------------------------
# This section adds a custom cursor is for the battle menu
# -----------------------------------------------------------------
module BattleLuna
  module WINDOWS
    WINDOW_COMMANDS ||= {} # compatible line
    
    WINDOW_COMMANDS[:party_commands] ||= {} # compatible line
    WINDOW_COMMANDS[:party_commands][:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
    
    WINDOW_COMMANDS[:actor_commands] ||= {} # compatible line
    WINDOW_COMMANDS[:actor_commands][:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
    
    WINDOW_GUI ||= {} # compatible line
    
    WINDOW_GUI[:skill_window] ||= {} # compatible line
    WINDOW_GUI[:skill_window][:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
    }
    
    WINDOW_GUI[:item_window] ||= {} # compatible line
    WINDOW_GUI[:item_window][:custom_cursor] = {
      :enable   => true,	        # Enable Cursor? True/False
      :cursor   => "Skin_Cursor", # Cursor filename
      :frame    => 7,             # Amount of Frames
      :offset_x => 0,							# Adjust X value without affecting the base X.						
      :offset_y => 4,							# Adjust Y value without affecting the base Y.
      :fps      => 4,             # Wait time before changing to the next frame.
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
# ■ Sprite_Cursor
#==============================================================================

class Sprite_Cursor < Sprite
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize(window)
    super(nil)
    @window = window
    @frame  = 0
    @tick   = setting[:fps]
    self.visible = false
    refresh
    update
  end
  
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    @window.setting[:custom_cursor] || @window.setting_custom_cursor
  end
  
  #--------------------------------------------------------------------------
  # refresh
  #--------------------------------------------------------------------------
  def refresh
    self.bitmap = Cache.system(setting[:cursor])
    #---
    @sx = self.bitmap.width / setting[:frame]
    @sy = self.bitmap.height
    #---
    self.src_rect.set(0, 0, @sx, @sy)
  end
  
  #--------------------------------------------------------------------------
  # update
  #--------------------------------------------------------------------------
  def update
    super
    update_frame
    update_visible
    return if self.opacity <= 0 || !self.visible
    update_position unless @window.is_a?(Window_SaveFile)
    update_position_save if @window.is_a?(Window_SaveFile)
  end
  
  #--------------------------------------------------------------------------
  # update_visible
  #--------------------------------------------------------------------------
  def update_visible
    if @window.is_a?(Window_SaveFile)
      self.opacity = @window.openness
      self.viewport = @window.viewport
      self.visible = @window.selected
      self.visible = false unless @window.visible
    else
      self.opacity = @window.openness
      self.viewport = @window.viewport
      self.visible = @window.index >= 0 && !@window.cursor_all && @window.active
      self.visible = false unless @window.visible
    end
  end
  
  #--------------------------------------------------------------------------
  # update_frame
  #--------------------------------------------------------------------------
  def update_frame
    @tick -= 1
    return unless @tick <= 0
    @tick  = setting[:fps]
    @frame = (@frame + 1) % setting[:frame]
    self.src_rect.set(@frame * @sx, 0, @sx, @sy)
  end
  
  #--------------------------------------------------------------------------
  # update_position
  #--------------------------------------------------------------------------
  def update_position
    self.x = @window.item_rect(@window.index).x + @window.x + setting[:offset_x]
    self.y = @window.item_rect(@window.index).y + @window.y + setting[:offset_y]
    self.x = self.x - @window.ox
    self.y = self.y - @window.oy
    self.z = @window.z + 1
  end
  
  #--------------------------------------------------------------------------
  # update_position_save
  #--------------------------------------------------------------------------
  def update_position_save
    self.x = @window.x + setting[:offset_x]
    self.y = @window.y + setting[:offset_y]
    self.z = @window.z + 1
  end
  
end # Sprite_Cursor

#==============================================================================
# ■ Window_Selectable
#==============================================================================

class Window_Selectable < Window_Base
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  alias luna_menu_custom_cursor_initialize initialize
  def initialize(x, y, width, height)
    luna_menu_custom_cursor_initialize(x, y, width, height)
    init_luna_cursor
  end
  
  #--------------------------------------------------------------------------
  # new method: setting
  #--------------------------------------------------------------------------
  def setting
    return {}
  end
  
  #--------------------------------------------------------------------------
  # new method: setting_custom_cursor
  #--------------------------------------------------------------------------
  def setting_custom_cursor
    MenuLuna::OtherMenu::CUSTOM_CURSOR
  end
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  def init_luna_cursor
    cursor_setting = setting[:custom_cursor] || setting_custom_cursor
    return unless cursor_setting[:enable]
    #---
    @custom_cursor = Sprite_Cursor.new(self)
  end
  
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias luna_menu_custom_cursor_update update
  def update
    luna_menu_custom_cursor_update
    update_custom_cursor
  end
  
  #--------------------------------------------------------------------------
  # new method: update_custom_cursor
  #--------------------------------------------------------------------------
  def update_custom_cursor
    # If Custom Cursor is not nil or disposed
    if !@custom_cursor.nil? and !@custom_cursor.disposed?
      # Update Custom Cursor
      @custom_cursor.update if @custom_cursor
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: dispose
  #--------------------------------------------------------------------------
  alias luna_menu_custom_cursor_dispose dispose
  def dispose
    luna_menu_custom_cursor_dispose
    dispose_custom_cursor
  end
  
  #--------------------------------------------------------------------------
  # new method: dispose_custom_cursor
  #--------------------------------------------------------------------------
  def dispose_custom_cursor
    @custom_cursor.dispose if @custom_cursor
  end
  
end # Window_Selectable

#==============================================================================
# ■ Window_MenuStatusLuna
#==============================================================================

class Window_MenuStatusLuna < Window_MenuStatus
  
  #--------------------------------------------------------------------------
  # new method: setting_custom_cursor
  #--------------------------------------------------------------------------
  def setting_custom_cursor
    MenuLuna::MainMenu::STATUS_WINDOW[:custom_cursor]
  end
  
end # Window_MenuStatusLuna

#==============================================================================
# ■ Window_ItemMenuActor
#==============================================================================

class Window_ItemMenuActor < Window_MenuActor
  
  #--------------------------------------------------------------------------
  # new method: setting_custom_cursor
  #--------------------------------------------------------------------------
  def setting_custom_cursor
    MenuLuna::ItemMenu::STATUS_WINDOW[:custom_cursor]
  end
  
end # Window_ItemMenuActor

#==============================================================================
# ■ Window_SkillMenuActor
#==============================================================================

class Window_SkillMenuActor < Window_MenuActor
  
  #--------------------------------------------------------------------------
  # new method: setting_custom_cursor
  #--------------------------------------------------------------------------
  def setting_custom_cursor
    MenuLuna::SkillMenu::STATUS_WINDOW[:custom_cursor]
  end
  
end # Window_SkillMenuActor

#==============================================================================
# ■ Window_SaveFile
#==============================================================================

class Window_SaveFile < Window_Base
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  alias luna_menu_custom_cursor_initialize initialize
  def initialize(*args)
    luna_menu_custom_cursor_initialize(*args)
    init_luna_cursor
  end
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  def init_luna_cursor
    cursor_setting = setting[:custom_cursor] || setting_custom_cursor
    return unless cursor_setting[:enable]
    #---
    @custom_cursor = Sprite_Cursor.new(self)
  end
  
  #--------------------------------------------------------------------------
  # new method: setting_custom_cursor
  #--------------------------------------------------------------------------
  def setting_custom_cursor
    MenuLuna::SaveMenu::WINDOW_SAVE[:custom_cursor]
  end
  
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias luna_menu_custom_cursor_update update
  def update
    luna_menu_custom_cursor_update
    update_custom_cursor
  end
  
  #--------------------------------------------------------------------------
  # new method: update_custom_cursor
  #--------------------------------------------------------------------------
    # If Custom Cursor is not nil or disposed
  def update_custom_cursor
    # If Custom Cursor is not nil or disposed
    if !@custom_cursor.nil? and !@custom_cursor.disposed?
      # Update Custom Cursor
      @custom_cursor.update if @custom_cursor
    end    
  end    
  
  #--------------------------------------------------------------------------
  # alias method: dispose
  #--------------------------------------------------------------------------
  alias luna_menu_custom_cursor_dispose dispose
  def dispose
    luna_menu_custom_cursor_dispose
    dispose_custom_cursor
  end
  
  #--------------------------------------------------------------------------
  # new method: dispose_custom_cursor
  #--------------------------------------------------------------------------
  def dispose_custom_cursor
    @custom_cursor.dispose if @custom_cursor
  end
  
end # Window_SaveFile