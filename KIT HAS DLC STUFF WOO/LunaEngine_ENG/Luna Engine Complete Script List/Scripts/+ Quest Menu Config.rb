#==============================================================================
# ■ MenuLuna: Quest Menu Core
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This is a custom quest menu made for Luna Engine users!
# This uses items as a way to indicate if the player has a new or finished  
# quest. Based on Subterranean Starfield by rhyme and Archeia_Nessiah.
#==============================================================================
module MenuLuna
  module QuestMenu
    # -----------------------------------------------------------------
    # This section modifies the help window.
    # -----------------------------------------------------------------
    WINDOW_HELP = {
      # -----------------------------------------------------------------
      # :x refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move to the left, while 
      # Positive values mean they would move to the right.
      # -----------------------------------------------------------------
      :x            =>  0,
      # -----------------------------------------------------------------
      # :y refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move up, while 
      # Positive values mean they would move to the down.
      # -----------------------------------------------------------------
      :y            =>  0,
      # -----------------------------------------------------------------
      # :z refers to the item’s display priority. Think of it as layers when 
      # you use an image program or when mapping in RPG Maker. The higher the 
      # value, the higher it will be drawn/drawn above other items.
      # -----------------------------------------------------------------
      :z            =>  300,
      :width        =>  640, # Change the width of the window.
      # -----------------------------------------------------------------
      # Refers to the amount of lines displayed. By default it's 2 lines.
      # If you wish to have more and fit in the database, use the 
      # Notetag Descriptions script.
      # -----------------------------------------------------------------
      :line_number  =>  2,
      :height_buff  =>  0, # Spacing between the lines vertically.
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
        :picture  =>  "Help_Window",
        :opacity  =>  255,        # Change the transparency of the window.
                                  # 0 = Transparent, 255 = Solid  
        :offset_x =>  0,
        :offset_y =>  0,
      },
    } # End WINDOW_HELP
    
      # -----------------------------------------------------------------   
      # This section allows you to modify the Window_Category section.
      # The place in the menu that says All Quest(s)/Ongoing Quest(s)/etc.
      # -----------------------------------------------------------------    
    WINDOW_CATEGORY = {
      :enable =>  true,   # Enable Window Category? True/False
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
      :y      =>  72,
      # -----------------------------------------------------------------
      # :z refers to the item’s display priority. Think of it as layers when 
      # you use an image program or when mapping in RPG Maker. The higher the 
      # value, the higher it will be drawn/drawn above other items.
      # -----------------------------------------------------------------
      :z      =>  300,  
      :width  =>  640,         # Change the width of the window.
      # -----------------------------------------------------------------
      # Change the height of the window.
      # By default: max lines shown is (height - 24) / 24
      # -----------------------------------------------------------------
      :height 		 =>  48,
      :item_height => 24,      # Height of each command.
      # -----------------------------------------------------------------
      # This refers to the spacing between the window border and the contents.
      # ----------------------------------------------------------------- 
      :padding     => 12,
      # -----------------------------------------------------------------
      # :cursor enables or disable the default cursor display. If set to false 
      # It will remove the rectangle cursor.
      # -----------------------------------------------------------------
      :cursor      => true,
      # -----------------------------------------------------------------
      # Enable scrolling arrows display when long lists are shown.
      # -----------------------------------------------------------------
      :arrow      =>  true,    # Default arrow for long list.
      # ----------------------------------------------------------------- 
      # Set alignment settings.
      # 0 = Left/Default, 1 = Center, 2 = Right
      # -----------------------------------------------------------------   
      :align      =>  1,
      :vertical   =>  false,   # Display vertically? True/False 
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
    } # End WINDOW_CATEGORY.
    
      # -----------------------------------------------------------------   
      # This modifies the Window Item List. Where all the items in the 
      # inventory is displayed.
      # -----------------------------------------------------------------    
    WINDOW_ITEM = {
		# -----------------------------------------------------------------   
    # This is an extra window that displays the quest requirements.
    # -----------------------------------------------------------------    
      # -----------------------------------------------------------------
      # :x refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move to the left, while 
      # Positive values mean they would move to the right.
      # -----------------------------------------------------------------
      :x            =>  0,
      # -----------------------------------------------------------------
      # :y refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move up, while 
      # Positive values mean they would move to the down.
      # -----------------------------------------------------------------
      :y            =>  120,
      # -----------------------------------------------------------------
      # :z refers to the item’s display priority. Think of it as layers when 
      # you use an image program or when mapping in RPG Maker. The higher the 
      # value, the higher it will be drawn/drawn above other items.
      # -----------------------------------------------------------------
      :z            =>  300,
      :width        =>  240,    # Change the width of the window.
      :height       =>  296,    # Change the height of the window.
      :column       =>  1,      # Columns for displaying item list.
      :item_height  =>  24,     # Height of each items in the list.
      # -----------------------------------------------------------------
      # This refers to the spacing between the window border and the contents.
      # ----------------------------------------------------------------- 
      :padding      =>  12,
      # -----------------------------------------------------------------
      # :cursor enables or disable the default cursor display. If set to false 
      # It will remove the rectangle cursor.
      # -----------------------------------------------------------------
      :cursor       =>  true,
      # -----------------------------------------------------------------
      # Enable scrolling arrows display when long lists are shown.
      # -----------------------------------------------------------------
      :arrow        =>  true,   # Default arrow for long list.
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
      :background_variable => 1, # Set a Variable to change Window
      # -----------------------------------------------------------------  
      # Customize Item Rect settings.
      # Item rect refers to the individual items listed in the Item list.
      # You can adjust the display over here.
      # -----------------------------------------------------------------  
      :item_rect=>  {
        :custom =>  false,  # Enable custom item_rect or not? True/False
        :width  =>  64,     # Width of the item rect.
        :height =>  64,     # Height of the item rect.
        :spacing_ver =>  8, # Spacing of each item vertically.
        :spacing_hor =>  8, # Spacing of each item horizontally.
      },
      # Type 0 settings (Windowskin)
      :type_0     =>  { 
        :skin     => "Window",   # Name of the Windowskin
        :opacity  => 255,        # Change the transparency of the window.
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
        :vertical =>  false,    # Display the gradient vertically.
      },
      # -----------------------------------------------------------------   
      # Type 2 settings (Picture Background)
      # :picture = Name of the Picture located in Graphics/System folder.
      # :opacity = Transparency of the picture. 0 = Transparent, 255 = Solid  
      # ----------------------------------------------------------------- 
      :type_2     =>  {
        :picture  =>  "", # Graphics/System
        :opacity  =>  255,
        :offset_x =>  0,
        :offset_y =>  0,
      },
    } # End WINDOW_ITEM
    
    WINDOW_DESCRIPTION = {
		  # -----------------------------------------------------------------
      # :x refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move to the left, while 
      # Positive values mean they would move to the right.
      # -----------------------------------------------------------------
      :x      =>  240,
      # -----------------------------------------------------------------
      # :y refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move up, while 
      # Positive values mean they would move to the down.
      # -----------------------------------------------------------------
      :y      =>  120,
      # -----------------------------------------------------------------
      # :z refers to the item’s display priority. Think of it as layers when 
      # you use an image program or when mapping in RPG Maker. The higher the 
      # value, the higher it will be drawn/drawn above other items.
      # -----------------------------------------------------------------
      :z       =>  300,
      :width   =>  400,  # Change the width of the window.
      :height  =>  296,  # Change the height of the window.
      # -----------------------------------------------------------------
      # This refers to the spacing between the window border and the contents.
      # ----------------------------------------------------------------- 
      :padding =>  10,
      # -----------------------------------------------------------------
      # Set a Background Display Type:
      # 0 - Windowskin; 1 - Gradient Background; 2 - Picture
      # -----------------------------------------------------------------
      :back_type  =>  1, 
      # ----------------------------------------------------------------- 
      # This allows you to set a variable to change the skin of this particular    
      # section of the menu. The default is Variable 1. Remember that it reads 
      # it as a string (e.g. $game_variables[1] = “Menu_Green”).
      # -----------------------------------------------------------------     
      :background_variable => 1, # Set a Variable to change Window
			
      # Type 0 settings (Windowskin)
      :type_0     =>  { 
        :skin     => "Window",   # Name of the Windowskin
        :opacity  => 255,        # Change the transparency of the window.
                                 # 0 = Transparent, 255 = Solid    
      },
        
      # -----------------------------------------------------------------   
      # Type 1 settings (Gradient Background)
      # color1 = refers to the first color of the gradient. ([R,G,B,A])
      # color2 = refers to the second color of the gradient. ([R,G,B,A])
      # normal_color refers to the color of your default windowskin.
      # ----------------------------------------------------------------- 
      :type_1     =>  {
        :color1   =>  [250,105,0, 128],
        :color2   =>  [250,105,0, 128],
        :vertical =>  false,     # Display the gradient vertically.
      },
        
      # -----------------------------------------------------------------   
      # Type 2 settings (Picture Background)
      # :picture = Name of the Picture located in Graphics/System folder.
      # :opacity = Transparency of the picture. 0 = Transparent, 255 = Solid  
      # -----------------------------------------------------------------   
      :type_2     =>  {
        :picture  =>  "commandpane",
        :opacity  =>  255,
        :offset_x =>  0,
        :offset_y =>  0,
      },
    } # End WINDOW_DESCRIPTION.
    
#==============================================================================
# ■ Window Cursor Add-On: Quest Configuration
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Allows you to use Window_Cursor script in Quest Menu.
#==============================================================================
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
    
  end
end