#==============================================================================
# ■ MenuLuna: Name Input Core
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This allows you to modify the Name Input Processing in RPG Maker.
#==============================================================================

$imported = {} if $imported.nil?
$imported["YEL-MenuLuna-NameInput"] = true

module MenuLuna
  module Addon
    module NameInput
		# -----------------------------------------------------------------
    # This allows you to add custom backgrounds.
		# Requires Menu Luna Add-on: Lunatic Backgrounds
    # -----------------------------------------------------------------
      BACKGROUND = [
			# Check Lunatic Backgrounds for Instructions
      ]
      
		# -----------------------------------------------------------------
    # This allows you to modify the window that displays the actor's name.
    # -----------------------------------------------------------------
      WINDOW_NAME = {
      # -----------------------------------------------------------------
      # :x refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move to the left, while 
      # Positive values mean they would move to the right.
      # -----------------------------------------------------------------
        :x            =>  140,
      # -----------------------------------------------------------------
      # :y refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move up, while 
      # Positive values mean they would move to the down.
      # -----------------------------------------------------------------
        :y            =>  24,
      # -----------------------------------------------------------------
      # :z refers to the item’s display priority. Think of it as layers when 
      # you use an image program or when mapping in RPG Maker. The higher the 
      # value, the higher it will be drawn/drawn above other items.
      # -----------------------------------------------------------------
        :z            =>  300,
        :width        =>  360,         # Change the width of the window.
        :height       =>  120,         # Change the height of the window.
      # -----------------------------------------------------------------
      # This refers to the spacing between the window border and the contents.
      # ----------------------------------------------------------------- 
        :padding      =>  12,
        :cursor       =>  true,				 # Enable Box Cursor? True/False
      # -----------------------------------------------------------------
      # This modifies the text display for the actor's name.
      # ----------------------------------------------------------------- 
        :text         => {
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the character
        # display without affecting its base x and y. 
        # ----------------------------------------------------------------- 
          :offset_x   => 181,
          :offset_y   => 36,
          :width      => 10,  					# Width for each character alphabet.
          :height     => 24, 					  # Height for each character alphabet.
          :underline  => true, 					# Enable underline indicator? True/False
        },
      # -----------------------------------------------------------------
      # This modifies the actor faceset display.
      # ----------------------------------------------------------------- 
        :face       =>  {
          :enable   =>  true,						# Enable Faceset display? True/False
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the faceset
        # display without affecting its base x, y and z. 
        # ----------------------------------------------------------------- 
          :offset_x =>  24,
          :offset_y =>  12,
          :offset_z =>  5,
      # -----------------------------------------------------------------
      # Type allows you to set the type of face graphic you want to use.
      # 0 - Default faceset; 1 - Custom face graphic.
      # 2 - Custom face based on database settings. FaceName_FaceIndex
      # Example for Eric: Actor4_0
      # -----------------------------------------------------------------
        :type     =>  0,   
				
				:type_1   =>  {
          :filename   =>  "Actor", # Put image in Graphics/Faces
      # -----------------------------------------------------------------
      # When enabled, you can set custom graphics based on Actor ID/Index.
      # filename + "_ActorID" (Example: FaceHUD_1)
      # -----------------------------------------------------------------
          :base_actor =>  true,
      # -----------------------------------------------------------------
      # When enabled, you can set custom graphics based on Class ID/Index.
      # filename + "_ActorID_ClassID" (Example: FaceHUD_1_1)
      # -----------------------------------------------------------------
          :base_class =>  false,
          },
        }, # End face.
				
      # -----------------------------------------------------------------
      # Set a Background Display Type:
      # 0 - Windowskin; 1 - Gradient Background; 2 - Picture
      # -----------------------------------------------------------------
      :back_type    =>  0, 
      # ----------------------------------------------------------------- 
      # This allows you to set a variable to change the skin of this particular    
      # section of the menu. The default is Variable 1. Remember that it reads 
      # it as a string (e.g. $game_variables[1] = “Menu_Green”).
      # -----------------------------------------------------------------    
      :background_variable => 1,
      
      # Type 0 settings (Windowskin)
      :type_0     =>  { 
        :skin     => "Window",  # Name of the Windowskin
        :opacity  => 255,       # Change the transparency of the window.
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
        :vertical =>  false,  # Display the gradient vertically.
      },
        
      # -----------------------------------------------------------------   
      # Type 2 settings (Picture Background)
      # :picture = Name of the Picture located in Graphics/System folder.
      # :opacity = Transparency of the picture. 0 = Transparent, 255 = Solid  
      # -----------------------------------------------------------------   
      :type_2     =>  {
        :picture  =>  "",
        :opacity  =>  255,        # Change the transparency of the window.
                                  # 0 = Transparent, 255 = Solid  
        :offset_x =>  0,
        :offset_y =>  0,
        },
      }
      
		# -----------------------------------------------------------------
    # This allows you to modify the window that allows you to select characters
		# for actor name.
    # -----------------------------------------------------------------
      WINDOW_INPUT = {
      # -----------------------------------------------------------------
      # :x refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move to the left, while 
      # Positive values mean they would move to the right.
      # -----------------------------------------------------------------
        :x            =>  140,
      # -----------------------------------------------------------------
      # :y refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move up, while 
      # Positive values mean they would move to the down.
      # -----------------------------------------------------------------
        :y            =>  152,
      # -----------------------------------------------------------------
      # :z refers to the item’s display priority. Think of it as layers when 
      # you use an image program or when mapping in RPG Maker. The higher the 
      # value, the higher it will be drawn/drawn above other items.
      # -----------------------------------------------------------------
        :z            =>  300,
        :width        =>  360,         # Change the width of the window.
        :height       =>  240,         # Change the height of the window.
      # -----------------------------------------------------------------
      # This refers to the spacing between the window border and the contents.
      # ----------------------------------------------------------------- 
        :padding      =>  12,
        :cursor       =>  true,				 # Enable Input Cursor? True/False 
      # -----------------------------------------------------------------
      # Character rect settings
      # ----------------------------------------------------------------- 
        :default_sep  =>  true, # Default separated space, will be in the middle
                                # of each line
        :sep_size     =>  16,	  # Separation size
        :item_rect    => {
          # Offset
          :x      =>  0,
          :y      =>  0,
          # Sizes
          :width  =>  32,
          :height =>  24,
        },
#==============================================================================
# ■ Window Cursor Add-On: Name Input Configuration
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Allows you to use Window_Cursor script in Name Input.
#==============================================================================
      :custom_cursor => {
       :enable   => true,	         # Enable Cursor? True/False
       :cursor   => "Name_Cursor", # Cursor filename
       :frame    => 1,             # Amount of Frames
       :offset_x => 0,						 # Adjust X value without affecting the base X.
       :offset_y => 4,						 # Adjust Y value without affecting the base Y.
       :offset_z => 1,						 # Adjust Z value without affecting the base Z.
       :fps      => 4,        		 # Wait time before changing to the next frame.
        },
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
        :picture  =>  "commandpane", # Graphics/System
        :opacity  =>  255,
        :offset_x =>  0,
        :offset_y =>  0,
        },
      } # End WINDOW_HELP

    end   
  end
end

#==============================================================================
# ▼ Editting anything past this point may potentially result in causing
# computer damage, incontinence, explosion of user's head, coma, death, and/or
# halitosis so edit at your own risk.
#==============================================================================
#==============================================================================
# ■ SpriteNameInput_Face
#==============================================================================

class SpriteNameInput_Face < Sprite_Base
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize(viewport, battler, window)
    super(viewport)
    @battler = battler
    @window  = window
    @face = ["", 0]
  end
  
  #--------------------------------------------------------------------------
  # update
  #--------------------------------------------------------------------------
  def update
    return unless setting[:enable]
    #---
    super
    refresh if face_change?
    #---
    self.x = screen_x; self.y = screen_y; self.z = screen_z
  end
  
  #--------------------------------------------------------------------------
  # refresh
  #--------------------------------------------------------------------------
  def refresh
    return unless setting[:enable]
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
    @face.clear
    @face = faceset_name
    face_name = @face[0]
    face_index = @face[1]
    #---
    bitmap = Bitmap.new(96, 96)
    face_bitmap = Cache.face(face_name)
    rect = Rect.new(face_index % 4 * 96, face_index / 4 * 96, 96, 96)
    bitmap.blt(0, 0, face_bitmap, rect)
    face_bitmap.dispose
    #---
    self.bitmap.dispose if self.bitmap
    self.bitmap = bitmap
  end
  
  #--------------------------------------------------------------------------
  # refresh_type1
  #--------------------------------------------------------------------------
  def refresh_type1
    @face.clear
    @face = [real_name, 0]
    #---
    self.bitmap = Cache.face(real_name)
  end
  
  #--------------------------------------------------------------------------
  # refresh_type2
  #--------------------------------------------------------------------------
  def refresh_type2
    @face.clear
    @face = [@battler.face_name, @battler.face_index]
    #---
    self.bitmap = Cache.face(real_name)
  end
  
  #--------------------------------------------------------------------------
  # face_change?
  #--------------------------------------------------------------------------
  def face_change?
    case setting[:type]
    when 0
      return faceset_name != @face
    when 1
      return @face[0] != real_name
    when 2
      return @face[0] + "_" + @face[1].to_s != real_name
    end
  end
  
  #--------------------------------------------------------------------------
  # faceset_name
  #--------------------------------------------------------------------------
  def faceset_name
    [@battler.face_name, @battler.face_index]
  end
  
  #--------------------------------------------------------------------------
  # real_name
  #--------------------------------------------------------------------------
  def real_name
    result = ""
    if setting[:type] == 1
      result = setting[:type_1][:filename]
      result += "_#{@battler.actor.id}" if setting[:type_1][:base_actor]
      result += "_#{@battler.class.id}" if setting[:type_1][:base_class]
    elsif setting[:type] == 2
      result = "#{@battler.face_name}_#{@battler.face_index}"
    end
    result
  end
  
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    MenuLuna::Addon::NameInput::WINDOW_NAME[:face]
  end
  
  #--------------------------------------------------------------------------
  # screen_x
  #--------------------------------------------------------------------------
  def screen_x
    @window.x + setting[:offset_x]
  end
  
  #--------------------------------------------------------------------------
  # screen_y
  #--------------------------------------------------------------------------
  def screen_y
    @window.y + setting[:offset_y]
  end
  
  #--------------------------------------------------------------------------
  # screen_z
  #--------------------------------------------------------------------------
  def screen_z
    @window.z + setting[:offset_z]
  end
  
end # SpriteMenu_Face

#==============================================================================
# ■ Window_NameEdit
#==============================================================================

class Window_NameEdit < Window_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  alias luna_menu_name_input_initialize initialize
  def initialize(actor, max_char)
    luna_menu_name_input_initialize(actor, max_char)
    self.width  = window_width
    self.height = window_height
    create_contents
    refresh
    refresh_background
    init_position
    init_face
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
  # new method: init_face
  #--------------------------------------------------------------------------
  def init_face
    @face = SpriteNameInput_Face.new(self.viewport, @actor, self)
    update_face
  end
  
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias luna_menu_name_input_update update
  def update
    luna_menu_name_input_update
    update_face
  end
  
  #--------------------------------------------------------------------------
  # new method: update_face
  #--------------------------------------------------------------------------
  def update_face
    @face.update if @face
  end
  
  #--------------------------------------------------------------------------
  # alias method: dispose
  #--------------------------------------------------------------------------
  alias luna_menu_name_input_dispose dispose
  def dispose
    luna_menu_name_input_dispose
    dispose_face
    @bg_sprite.dispose if @bg_sprite
  end
  
  #--------------------------------------------------------------------------
  # new method: dispose_face
  #--------------------------------------------------------------------------
  def dispose_face
    @face.dispose if @face
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
    MenuLuna::Addon::NameInput::WINDOW_NAME
  end
  
  #--------------------------------------------------------------------------
  # new method: setting_type
  #--------------------------------------------------------------------------
  def setting_type
    type = setting[:back_type]
    setting[eval(":type_#{type}")]
  end
  
  #--------------------------------------------------------------------------
  # alias method: draw_underline
  #--------------------------------------------------------------------------
  alias luna_menu_name_input_draw_underline draw_underline
  def draw_underline(index)
    luna_menu_name_input_draw_underline(index) if setting[:text][:underline]
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: left
  #--------------------------------------------------------------------------
  def left
    return setting[:text][:offset_x]
  end

  #--------------------------------------------------------------------------
  # overwrite method: item_rect
  #--------------------------------------------------------------------------
  def item_rect(index)
    width = setting[:text][:width]
    height = setting[:text][:height]
    offset_y = setting[:text][:offset_y]
    Rect.new(left + index * width, offset_y, width, height)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: item_rect
  #--------------------------------------------------------------------------
  def draw_actor_face(*args)
    # don't need here
  end
  
  #--------------------------------------------------------------------------
  # new method: update_cursor
  #--------------------------------------------------------------------------
  def update_cursor
    return if setting[:cursor]
    cursor_rect.empty
  end
  
  #--------------------------------------------------------------------------
  # alias method: refresh
  #--------------------------------------------------------------------------
  alias menu_luna_name_input_refresh refresh
  def refresh
    menu_luna_name_input_refresh
    update_cursor
  end
  
end # Window_NameEdit

#==============================================================================
# ■ Window_NameInput
#==============================================================================

class Window_NameInput < Window_Selectable
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  alias luna_menu_name_input_initialize initialize
  def initialize(edit_window)
    luna_menu_name_input_initialize(edit_window)
    self.width  = window_width
    self.height = window_height
    create_contents
    refresh
    refresh_background
    init_position
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
    MenuLuna::Addon::NameInput::WINDOW_INPUT
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
  # overwrite method: item_rect
  #--------------------------------------------------------------------------
  def item_rect(index)
    row    = 10
    x      = setting[:item_rect][:x]
    y      = setting[:item_rect][:y]
    width  = setting[:item_rect][:width]
    height = setting[:item_rect][:height]
    rect = Rect.new
    rect.x = index % row * width
    rect.x = rect.x + index % row / (row / 2) * setting[:sep_size] if setting[:default_sep]
    rect.x = rect.x + x
    rect.y = index / row * height
    rect.y = rect.y + y
    rect.width  = width
    rect.height = height
    rect
  end
  
  #--------------------------------------------------------------------------
  # alias method: update_cursor
  #--------------------------------------------------------------------------
  alias menu_luna_update_cursor update_cursor
  def update_cursor
    setting[:cursor] ? menu_luna_update_cursor : cursor_rect.empty
  end
  
end # Window_NameInput

#==============================================================================
# ■ Scene_Name
#==============================================================================

class Scene_Name < Scene_MenuBase
  
  #--------------------------------------------------------------------------
  # overwrite method: background_setting
  #--------------------------------------------------------------------------
  def background_setting
    MenuLuna::Addon::NameInput::BACKGROUND
  end
  
end # Scene_Name