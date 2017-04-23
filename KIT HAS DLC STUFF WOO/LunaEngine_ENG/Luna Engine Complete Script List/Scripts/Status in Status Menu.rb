#==============================================================================
# ■ MenuLuna: Main Menu Configuration
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This section allows you to include a 'Current Actor' displayed on the Status
# Menu on all times. This has some uses on certain layouts.
#==============================================================================

$imported = {} if $imported.nil?
$imported["YEL-MenuLuna-StatusStatusMenu"] = true

module MenuLuna
  module StatusMenu
    
    CURRENT_ACTOR_STATUS   = {
    # -----------------------------------------------------------------
    # This section configures the positioning of the menu.
    # -----------------------------------------------------------------
      :enable     =>  true,
      # -----------------------------------------------------------------
      # :x refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move to the left, while 
      # Positive values mean they would move to the right.
      # -----------------------------------------------------------------
      :x          =>  172,
      # -----------------------------------------------------------------
      # :y refers to the horizontal axis. Based on the Cartesian Plane. 
      # Negative values (e.g. -1) mean they would move up, while 
      # Positive values mean they would move to the down.
      # -----------------------------------------------------------------
      :y          =>  84,
      # -----------------------------------------------------------------
      # :z refers to the item’s display priority. Think of it as layers when 
      # you use an image program or when mapping in RPG Maker. The higher the 
      # value, the higher it will be drawn/drawn above other items.
      # -----------------------------------------------------------------
      :z          =>  350,
			# -----------------------------------------------------------------
			# Main Configuration Setting.
			# -----------------------------------------------------------------
      :main       =>  {
        :enable   =>  true,		# Enable Current Actor Display? True/False
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # ----------------------------------------------------------------- 
        :offset_x =>  12,
        :offset_y =>  66,
        :offset_z =>  10,
        :filename =>  "Skin_Main",   # Name of the background image.
        :collapse =>  false,				 # Enable collapse options?
        :collapse_type => 1,   			 # 0 - Like Battler; 1 - Grey out.
        :highlight  =>  false, 	     # Highlight when selected.
				# -----------------------------------------------------------------
				# When enabled, you can set custom graphics based on Actor ID/Index.
				# filename + "_ActorID" (Example: MainHUD_1)
				# -----------------------------------------------------------------
        :base_actor =>  false,
				# -----------------------------------------------------------------
				# When enabled, you can set custom graphics based on Class ID/Index.
				# filename + "_ActorID_ClassID" (Example: MainHUD_1_1)
				# -----------------------------------------------------------------
        :base_class =>  false,
      }, # End main.
			
      # -----------------------------------------------------------------
      # The select settings is if you want to add a picture graphic
      # when selecting an item
      # ----------------------------------------------------------------- 
      :select     =>  {
        :enable   =>  false,  # Enable select settings? True/False
      # -----------------------------------------------------------------
      # Offset Values refer to how much you want to nudge the window
      # display without affecting its base x, y, and z. 
      # -----------------------------------------------------------------
        :offset_x =>  0,
        :offset_y =>  0,
        :offset_z =>  0,
        :filename =>  "Select Bar",	# Picture Filename.
				# -----------------------------------------------------------------
				# When enabled, you can set custom graphics based on Actor ID/Index.
				# filename + "_ActorID" (Example: MainHUD_1)
				# -----------------------------------------------------------------
        :base_actor =>  false,
				# -----------------------------------------------------------------
				# When enabled, you can set custom graphics based on Class ID/Index.
				# filename + "_ActorID_ClassID" (Example: MainHUD_1_1)
				# -----------------------------------------------------------------
        :base_class =>  false,
      }, # End select.
      
      # Face settings
      :face       =>  {
        :enable   =>  true,	 # Enable face settings? True/False
      # -----------------------------------------------------------------
      # Offset Values refer to how much you want to nudge the window
      # display without affecting its base x, y, and z. 
      # -----------------------------------------------------------------
        :offset_x =>  1,
        :offset_y =>  1,
        :offset_z =>  0,
        :collapse =>  true, 	# Allow collapse effects? True/False
        :collapse_type => 1,  # 0 - Like Battler; 1 - Grey out.
        :highlight=>  false,  # Highlight when selected.
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
      # This section allows you to customize name settings for actors.
      # -----------------------------------------------------------------  
      :name       =>  {
        :enable   =>  true, # Enable name display? True/False
        :width    =>  160,  # Change the width of the name rect.
        :height   =>  24,   # Change the height of the name rect.
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # ----------------------------------------------------------------- 
        :offset_x =>  108,
        :offset_y =>  12,
        :offset_z =>  0,
        # ----------------------------------------------------------------- 
        # Set the color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default font color.
        # -----------------------------------------------------------------         
        :color    =>  [255, 255, 255, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # -----------------------------------------------------------------   
        :outline  =>  [0, 0, 0, 128],
        :bold     =>  false, # Enable Bold? True/False
        :italic   =>  false, # Enable Italic? True/False
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
        :align    =>  0,
        :font     =>  "VL Gothic", # Set Font type.
        :size     =>  24,          # Set Font Size
      }, # End name.
      
      # -----------------------------------------------------------------
      # This section allows you to customize class name settings for actors.
      # -----------------------------------------------------------------  
      :class       =>  {
        :enable   =>  true, # Enable class name display? True/False
        :width    =>  160,  # Change the width of the class name rect.
        :height   =>  24,   # Change the height of the class name rect.
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # -----------------------------------------------------------------         
        :offset_x =>  228,
        :offset_y =>  12,
        :offset_z =>  0,
        # ----------------------------------------------------------------- 
        # Set the color for the class name display. [R,G,B,A]
        # You can also use normal_color to use the default font color.
        # -----------------------------------------------------------------      
        :color    =>  [255, 255, 255, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the class name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # -----------------------------------------------------------------   
        :outline  =>  [0, 0, 0, 128],
        :bold     =>  false, # Enable Bold? True/False
        :italic   =>  false, # Enable Italic? True/False
        :font     =>  "VL Gothic", # Set Font type.
        :size     =>  24,          # Set Font Size
        :vocab    =>  "%s",        # Set a new vocab for class name. 
                                   # %s is default.
      }, # End name.
      
      # -----------------------------------------------------------------
      # This section allows you to customize HP Bar settings for actors.
      # -----------------------------------------------------------------  
      :hp_bar     =>  {
        :enable   =>  true, # Enable HP Bars? True/False
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # -----------------------------------------------------------------     
        :offset_x =>  228,
        :offset_y =>  48,
        :offset_z =>  0,
      # -----------------------------------------------------------------
      # Type allows you to set the type of graphic you want to use.
      # 0 - Default bar; 1 - Custom bar; 2 - Custom animated bar.
      # -----------------------------------------------------------------
        :type     =>  0,
        :vertical =>  false,# Display vertically? True/False 
                            # Works for type 0 and 1.
        :ani_rate =>  0.02, # Max is 1.00. Refers to animate speed/rate.
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
          :color1     =>  [7, 101, 58, 255],
          :color2     =>  [84, 194, 144, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # -----------------------------------------------------------------   
          :outline    =>  [0, 0, 0, 255],
          :length     =>  220, # Width/Length of the bar.
          :height     =>  12,  # Height of the bar.
          
        # ----------------------------------------------------------------- 
        # This section allows you to customize the "HP" Vocab display.
        # -----------------------------------------------------------------  
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # ----------------------------------------------------------------- 
          :offset_x =>  232,
          :offset_y =>  32,
          :offset_z =>  1,
        # ----------------------------------------------------------------- 
        # Set the color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default font color.
        # -----------------------------------------------------------------        
          :tcolor   =>  [255, 255, 255, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # -----------------------------------------------------------------   
          :toutline =>  [0, 0, 0, 128],
          :bold     =>  false, # Enable Bold? True/False
          :italic   =>  false, # Enable Italic? True/False
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  0,
          :font     =>  "VL Gothic", # Set Font type.
          :size     =>  24,          # Set Font Size
          :text     =>  "HP",        # Change "HP" Vocab.
        },
        #---
        :type_1   =>  {
          :filename =>  "HP_Bar",    # Custom HP Bar Filename.
        },
        #---
        :type_2   =>  {
          :filename =>  "Btskin_hp", # Custom Frame-based HP Bar Filename.
          :frames   =>  10,          # Amount of animation frames.
        },
      }, # End hp_bar.
        
      # -----------------------------------------------------------------
      # This section allows you to customize MP Bar settings for actors.
      # -----------------------------------------------------------------  
      :mp_bar     =>  {
        :enable   =>  true, # Enable MP Bars? True/False
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # -----------------------------------------------------------------           
        :offset_x =>  228,
        :offset_y =>  72,
        :offset_z =>  0,
      # -----------------------------------------------------------------
      # Type allows you to set the type of graphic you want to use.
      # 0 - Default bar; 1 - Custom bar; 2 - Custom animated bar.
      # -----------------------------------------------------------------       
        :type     =>  0,
        :vertical =>  false,# Display vertically? True/False 
                            # Works for type 0 and 1.
        :ani_rate =>  0.02, # Max is 1.00. Refers to animate speed/rate.
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
          :color1     =>  [74, 115, 185, 255],
          :color2     =>  [128, 157, 206, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # -----------------------------------------------------------------   
          :outline    =>  [0, 0, 0, 255],
          :length     =>  220, # Width/Length of the bar.
          :height     =>  12,  # Height of the bar.
        # ----------------------------------------------------------------- 
        # This section allows you to customize the "HP" Vocab display.
        # -----------------------------------------------------------------  
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # ----------------------------------------------------------------- 
          :offset_x =>  232,
          :offset_y =>  56,
          :offset_z =>  1,
        # ----------------------------------------------------------------- 
        # Set the color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default font color.
        # -----------------------------------------------------------------      
          :tcolor    =>  [255, 255, 255, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # ----------------------------------------------------------------- 
          :toutline  =>  [0, 0, 0, 128],
          :bold     =>  false, # Enable Bold? True/False
          :italic   =>  false, # Enable Italic? True/False
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  0,
          :font     =>  "VL Gothic", # Set Font type.
          :size     =>  24,          # Set Font Size
          :text     =>  "MP",        # Change "MP" Vocab.
        },
        #---
        :type_1   =>  {
          :filename =>  "MP_Bar",    # Custom MP Bar Filename.
        },
        #---
        :type_2   =>  {
          :filename =>  "Btskin_mp", # Custom Frame-based MP Bar Filename.
          :frames   =>  10,          # Amount of animation frames.
        },
      }, # End mp_bar.
      
      # -----------------------------------------------------------------
      # This section allows you to customize TP Bar settings for actors.
      # -----------------------------------------------------------------  
      :tp_bar     =>  {
        :enable   =>  false, # Enable TP Bars? True/False
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # -----------------------------------------------------------------       
        :offset_x =>  0,
        :offset_y =>  76,
        :offset_z =>  0,
        # -----------------------------------------------------------------
        # Type allows you to set the type of graphic you want to use.
        # 0 - Default bar; 1 - Custom bar; 2 - Custom animated bar.
        # -----------------------------------------------------------------   
        :type     =>  2,
        :vertical =>  false,# Display vertically? True/False 
                            # Works for type 0 and 1.
        :ani_rate =>  0.02, # Max is 1.00. Refers to animate speed/rate.
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
          :color1     =>  [16, 255, 16, 255],
          :color2     =>  [64, 255, 64, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # -----------------------------------------------------------------   
          :outline    =>  [0, 0, 0, 255],
          :length     =>  76, # Width/Length of the bar.
          :height     =>  12, # Height of the bar.
        # ----------------------------------------------------------------- 
        # This section allows you to customize the "TP" Vocab display.
        # -----------------------------------------------------------------  
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # ----------------------------------------------------------------- 
          :offset_x =>  380,
          :offset_y =>  -14,
          :offset_z =>  5,
        # ----------------------------------------------------------------- 
        # Set the color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default font color.
        # -----------------------------------------------------------------   
          :tcolor    =>  [255, 255, 255, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # ----------------------------------------------------------------- 
          :toutline  =>  [0, 0, 0, 255],
          :bold     =>  true,  # Enable Bold? True/False
          :italic   =>  false, # Enable Italic? True/False
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  0,
          :font     =>  "Open Sans", # Set Font type.
          :size     =>  18,          # Set Font Size
          :text     =>  "TP",        # Change "TP" Vocab.
        },
        #---
        :type_1   =>  {
          :filename =>  "Btskin_tp", # Custom TP Bar Filename.
        },
        #---
        :type_2   =>  {
          :filename =>  "Skin_TP",   # Custom Frame-based TP Bar Filename.
          :frames   =>  17,          # Amount of animation frames.
        },
      }, # End tp_bar.
      
      # -----------------------------------------------------------------
      # This section allows you to customize HP Number settings for actors.
      # -----------------------------------------------------------------  
      :hp_num     =>  {
        :enable   =>  true, # Enable HP Numbers? True/False
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # -----------------------------------------------------------------     
        :offset_x =>  232,
        :offset_y =>  34,
        :offset_z =>  20,
        # -----------------------------------------------------------------
        # Type allows you to set the type of graphic you want to use.
        # # 0 - Default font; 1 - Custom number picture sheet;
        # -----------------------------------------------------------------
        :type     =>  0,    
        :ani_rate =>  0.05, # Max is 1.00. Refers to animate speed/rate.
        #--- START 2013.09.02
        :with_max =>  true, # Set to true to show Max HP Numbers in this sprite.
                            # Only works with type 0.
        :text     =>  "%d/%d", # Only available for :with_max == true
        #--- END 2013.09.02
        :type_0   =>  {
          :width    =>  212,  # Change the width of the number rect.
          :height   =>  24,   # Change the height of the number rect.
        # ----------------------------------------------------------------- 
        # Set the color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default font color.
        # -----------------------------------------------------------------  
          :color    =>  [255, 255, 255, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # -----------------------------------------------------------------   
          :outline  =>  [0, 0, 0, 128],
          :bold     =>  false, # Enable Bold? True/False
          :italic   =>  false, # Enable Italic? True/False
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  2,
        :font     =>  "VL Gothic", # Set Font type.
        :size     =>  24,          # Set Font Size
        },
        #---
        :type_1   =>  {
          :width    =>  80,              # Change the width of the number rect. 
                                         # Use for adjusting alignment.
          :filename =>  "Skin_NumSmall", # Picture Filename.
          :spacing  =>  -2,              # Add spacing
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  2,
        },
      }, # End hp_num.
      
      # -----------------------------------------------------------------
      # This section allows you to customize MP Number settings for actors.
      # -----------------------------------------------------------------  
      :mp_num     =>  {
        :enable   =>  true, # Enable MP Numbers? True/False
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # ----------------------------------------------------------------- 
        :offset_x =>  232,
        :offset_y =>  58,
        :offset_z =>  1,
        # -----------------------------------------------------------------
        # Type allows you to set the type of graphic you want to use.
        # # 0 - Default font; 1 - Custom number picture sheet;
        # -----------------------------------------------------------------
        :type     =>  0, 
        :ani_rate =>  0.05, # Max is 1.00. Refers to animate speed/rate.
        #--- START 2013.09.02
        :with_max =>  true, # Set to true to show Max MP Numbers in this sprite.
                            # Only works with type 0.
        :text     =>  "%d/%d", # Only available for :with_max == true
        #--- END 2013.09.02
        :type_0   =>  {
          :width    =>  212,  # Change the width of the number rect.
          :height   =>  24,   # Change the height of the number rect.
        # ----------------------------------------------------------------- 
        # Set the color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default font color.
        # -----------------------------------------------------------------  
          :color    =>  [255, 255, 255, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # -----------------------------------------------------------------   
          :outline  =>  [0, 0, 0, 128],
          :bold     =>  false, # Enable Bold? True/False
          :italic   =>  false, # Enable Italic? True/False
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  2,
          :font     =>  "VL Gothic", # Set Font type.
          :size     =>  24,          # Set Font Size
        },
        #---
        :type_1   =>  {
          :width    =>  80,              # Change the width of the number rect. 
                                         # Use for adjusting alignment.
          :filename =>  "Skin_NumSmall", # Picture Filename.
          :spacing  =>  -2,              # Add spacing
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  2,
        },
      }, # End mp_num.
      
      
      # -----------------------------------------------------------------
      # This section allows you to customize TP Number settings for actors.
      # -----------------------------------------------------------------  
      :tp_num     =>  {
        :enable   =>  false, # Enable TP Numbers? True/False
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # ----------------------------------------------------------------- 
        :offset_x =>  -8,
        :offset_y =>  90,
        :offset_z =>  5,
        # -----------------------------------------------------------------
        # Type allows you to set the type of graphic you want to use.
        # # 0 - Default font; 1 - Custom number picture sheet;
        # -----------------------------------------------------------------
        :type     =>  0,
        :ani_rate =>  0.05, # Max is 1.00. Refers to animate speed/rate.
        #--- START 2013.09.02
        :with_max =>  false,   # Set to true to show Max MP Numbers in this sprite.
                               # Only works with type 0.
        :text     =>  "%d/%d", # Only available for :with_max == true
        #--- END 2013.09.02
        :type_0   =>  {
          :width    =>  76,    # Change the width of the number rect.
          :height   =>  24,    # Change the height of the number rect.
        # ----------------------------------------------------------------- 
        # Set the color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default font color.
        # -----------------------------------------------------------------  
          :color    =>  [255, 255, 255, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # -----------------------------------------------------------------   
          :outline  =>  [0, 0, 0, 255],
          :bold     =>  true,   # Enable Bold? True/False
          :italic   =>  false,  # Enable Italic? True/False
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  2,
          :font     =>  "Franklin Gothic Demi Cond", # Set Font type.
          :size     =>  32,                          # Set Font Size
        },
        #---
        :type_1   =>  {
          :width    =>  30,              # Change the width of the number rect. 
                                         # Use for adjusting alignment.
          :filename =>  "Skin_NumSmall", # Picture Filename.
          :spacing  =>  -2,              # Add spacing
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  1,
        },
      }, # End tp_num.
      
      # -----------------------------------------------------------------
      # This section allows you to customize Max HP Number settings for actors.
      # -----------------------------------------------------------------  
      :hp_max_num =>  {
        :enable   =>  false, # Enable Max HP Numbers? True/False
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # -----------------------------------------------------------------     
        :offset_x =>  76,
        :offset_y =>  56,
        :offset_z =>  5,
        # -----------------------------------------------------------------
        # Type allows you to set the type of graphic you want to use.
        # # 0 - Default font; 1 - Custom number picture sheet;
        # -----------------------------------------------------------------
        :type     =>  0,
        :ani_rate =>  0.05, # Max is 1.00. Refers to animate speed/rate.
        #---
        :type_0   =>  {
          :width    =>  76,  # Change the width of the number rect.
          :height   =>  24,   # Change the height of the number rect.
        # ----------------------------------------------------------------- 
        # Set the color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default font color.
        # -----------------------------------------------------------------  
          :color    =>  [255, 255, 255, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # -----------------------------------------------------------------   
          :outline  =>  [0, 0, 0, 255],
          :bold     =>  true, # Enable Bold? True/False
          :italic   =>  false, # Enable Italic? True/False
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  2,           
          :font     =>  "Open Sans", # Set Font type.
          :size     =>  16,          # Set Font Size
        },
        #---
        :type_1   =>  {
          :width    =>  76,               # Change the width of the number rect. 
                                          # Use for adjusting alignment.
          :filename =>  "Btskin_numbers", # Picture Filename.
          :spacing  =>  -2,               # Add spacing
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  2,
        },
      }, # End hp_max_num.
      
      # -----------------------------------------------------------------
      # This section allows you to customize Max MP Number settings for actors.
      # -----------------------------------------------------------------  
      :mp_max_num =>  {
        :enable   =>  false, # Enable Max MP Numbers? True/False
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # ----------------------------------------------------------------- 
        :offset_x =>  76,
        :offset_y =>  70,
        :offset_z =>  5,
        # -----------------------------------------------------------------
        # Type allows you to set the type of graphic you want to use.
        # # 0 - Default font; 1 - Custom number picture sheet;
        # -----------------------------------------------------------------
        :type     =>  0,
        :ani_rate =>  0.05, # Max is 1.00. Refers to animate speed/rate.
        #---
        :type_0   =>  {
          :width    =>  76,  # Change the width of the number rect.
          :height   =>  24,   # Change the height of the number rect.
        # ----------------------------------------------------------------- 
        # Set the color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default font color.
        # -----------------------------------------------------------------  
          :color    =>  [255, 255, 255, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # ----------------------------------------------------------------- 
          :outline  =>  [0, 0, 0, 255],
          :bold     =>  true,  # Enable Bold? True/False
          :italic   =>  false, # Enable Italic? True/False
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  2,
          :font     =>  "Open Sans", # Set Font type.
          :size     =>  16,          # Set Font Size
        },
        #---
        :type_1   =>  {
          :width    =>  76,               # Change the width of the number rect. 
                                          # Use for adjusting alignment.
          :filename =>  "Btskin_numbers", # Picture Filename.
          :spacing  =>  -2,               # Add spacing
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  2,
        },
      }, # End mp_max_num.
      
      # -----------------------------------------------------------------
      # This section allows you to customize Max TP Number settings for actors.
      # -----------------------------------------------------------------  
      :tp_max_num     =>  {
        :enable   =>  false, # Enable Max TP Numbers? True/False
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # ----------------------------------------------------------------- 
        :offset_x =>  76,
        :offset_y =>  84,
        :offset_z =>  5,
        # -----------------------------------------------------------------
        # Type allows you to set the type of graphic you want to use.
        # # 0 - Default font; 1 - Custom number picture sheet;
        # -----------------------------------------------------------------
        :type     =>  0,    
        :ani_rate =>  0.05, # Max is 1.00. Refers to animate speed/rate.
        #---
        :type_0   =>  {
          :width    =>  76, # Change the width of the number rect.
          :height   =>  24, # Change the height of the number rect.
        # ----------------------------------------------------------------- 
        # Set the color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default font color.
        # -----------------------------------------------------------------  
          :color    =>  [255, 255, 255, 255],
        # ----------------------------------------------------------------- 
        # Set the outline color for the name display. [R,G,B,A]
        # You can also use normal_color to use the default outline color.
        # ----------------------------------------------------------------- 
          :outline  =>  [0, 0, 0, 255],
          :bold     =>  true,    # Enable Bold? True/False
          :italic   =>  false,   # Enable Italic? True/False
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  2,
          :font     =>  "Open Sans", # Set Font type.
          :size     =>  16,          # Set Font Size
        },
        #---
        :type_1   =>  {
          :width    =>  76,               # Change the width of the number rect. 
                                          # Use for adjusting alignment.
          :filename =>  "Btskin_numbers", # Picture Filename.
          :spacing  =>  -2,               # Add spacing
        # ----------------------------------------------------------------- 
        # Set alignment settings.
        # 0 = Left/Default, 1 = Center, 2 = Right
        # -----------------------------------------------------------------   
          :align    =>  2,
        },
      }, # End tp_max_num.
      
        # ----------------------------------------------------------------- 
        # This allows you to customize the states display.
        # -----------------------------------------------------------------   
      :states       =>  {
        :enable   =>  true, # Enable State Display? True/False
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # ----------------------------------------------------------------- 
        :offset_x =>  108,
        :offset_y =>  72,
        :offset_z =>  1,
        # -----------------------------------------------------------------
        # Type allows you to set the type of state display you want to use.
        # # 0 - Default states; 1 - Scrolling states
        # -----------------------------------------------------------------
        :type     =>  0,    
        # ----------------------------------------------------------------- 
        # This allows you to set a background image for state display.
        # -----------------------------------------------------------------  
        :back     =>  { # Offset is not related to above state offset
          :enable   =>  false, # Enable custom background? True/False
        # ----------------------------------------------------------------- 
        # Offset Values refer to how much you want to nudge the window display 
        # without affecting its base x, y and z. 
        # ----------------------------------------------------------------- 
          :offset_x =>  2,
          :offset_y =>  2,
          :offset_z =>  19,
          :filename =>  "", # Filename for the background picture for states.
        },
        #---
        :type_0   =>  {
          :max      =>  4,  # Max amount of states displayed.
          :spacing  =>  1,  # Spacing between states.
        },
        :type_1   =>  {
          :rate     =>  90, # Wait time before changing to the next state.
        },
      }, # End states
      
    } # End CURRENT_ACTOR_STATUS.
    
  end
end
#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================
#==============================================================================
# ■ Spriteset_StatusStatus
#==============================================================================

class Spriteset_StatusStatus < Spriteset_MenuStatus
  
  #--------------------------------------------------------------------------
  # overwrite method: screen_x
  #--------------------------------------------------------------------------
  def screen_x
    setting[:x]
  end

  #--------------------------------------------------------------------------
  # overwrite method: screen_y
  #--------------------------------------------------------------------------
  def screen_y
    setting[:y]
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: setting
  #--------------------------------------------------------------------------
  def setting
    MenuLuna::StatusMenu::CURRENT_ACTOR_STATUS
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: create_select
  #--------------------------------------------------------------------------
  def create_select
    # Removed.
  end
  
  #--------------------------------------------------------------------------
  # opacity
  #--------------------------------------------------------------------------
  def opacity
    255
  end
  
  #--------------------------------------------------------------------------
  # visible
  #--------------------------------------------------------------------------
  def visible
    setting[:enable] ? true : false
  end
  
end # Spriteset_StatusStatus

#==============================================================================
# ■ Scene_Status
#==============================================================================

class Scene_Status < Scene_MenuBase

  #--------------------------------------------------------------------------
  # alias method: start
  #--------------------------------------------------------------------------
  alias luna_menu_sssmenu_start start
  def start
    luna_menu_sssmenu_start
    create_status_sprite
  end
  
  #--------------------------------------------------------------------------
  # new method: create_status_sprite
  #--------------------------------------------------------------------------
  def create_status_sprite
    @current_status = Spriteset_StatusStatus.new(@viewport, @actor)
    @current_status.refresh
    @current_status.update
  end
  
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias menu_luna_sssmenu_update update
  def update
    menu_luna_sssmenu_update
    @current_status.update
  end
  
  #--------------------------------------------------------------------------
  # alias method: terminate
  #--------------------------------------------------------------------------
  alias menu_luna_sssmenu_terminate terminate
  def terminate
    menu_luna_sssmenu_terminate
    @current_status.dispose
  end
  
  #--------------------------------------------------------------------------
  # alias method: on_actor_change
  #--------------------------------------------------------------------------
  alias menu_luna_sssmenu_on_actor_change on_actor_change
  def on_actor_change
    menu_luna_sssmenu_on_actor_change
    @current_status.dispose
    create_status_sprite
  end
  
end # Scene_Status