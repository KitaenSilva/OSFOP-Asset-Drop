##-----------------------------------------------------------------------------
## Luna Engine - Easy Save Menu Add-on
## Created by Neon Black - 1.9.2013
##
## CONFIG HALF
##   - Requires the core half below it to work.
##
## This script is the first half of a 2 part script that allows the save
## menu to be customized without the need to use lunatic customization.  The
## save menu may be easily customized using commands similar to the rest of
## the Luna engine.  To use this script place the script anywhere below
## "▼ Materials" and above "▼ Main Process".  When using the Luna Engine Menu
## script, both pieces must go BELOW the Luna Engine.
##
##  ▼ Materials
##   Yami's Luna Menu
##   Neon's Luna Save Config
##   Neon's Luna Save Core
##
##  ▼ Main Process
##-----------------------------------------------------------------------------

module CPLunaSave
  
  ## Basic save data settings
  BASIC ={
    
    :save_name   => "Save<index>.rvdata2",  ## Use <index> for index number.
                                            ## If <index> is not present, only
                                            ## one save file will be used!
    :folder_name => nil,  ## Set to nil for no folder
    :slots       => 8,
    
    :cursor_new  => true,
    
  } ## Basic
  
  
  ## Settings pertaining to the background.
  BACKGROUND ={
  
    :x      => 0,
    :y      => 0,
    :z      => 0,
    :width  => 544,
    :height => 416,
    
    :type => 0,  ## 0 - Blur out last screen, 1 - Window, 2 - Image
    
    ## Type 0 settings
    :type_0 =>{
      
      :color => [16, 16, 16, 128],
      
    },
    
    ## Type 1 settings
    :type_1 =>{
      
      :wind_type => 1, ## 0 - Default, 1 - Gradient
      
        :type0_opacity  => 255,
        
        :type1_color1   => [255, 255, 255],
        :type1_color2   => [0, 0, 0],
        :type1_vertical => true,
      
    },
    
    ## Type 2 settings
    :type_2 =>{
      
      :image_name => "background"
      
    },
  } ## Background
  
  
  ## Settings pertaining to the save header.
  HEADER ={
   
    :enable  => true,
    :x       => 0,
    :y       => 0,
    :z       => 150,
    :width   => 544,
    :height  => 48,
    :padding => 12,
    
    ## Selection text settings
    :text =>  {
      :save_string => "Save game to which file?",
      :load_string => "Load game from which file?",
      :color       => [255, 255, 255, 255],
      :outline     => [0, 0, 0, 255],
      :bold        => true,
      :italic      => false,
      :align       => 1,
      :font        => "Open Sans",
      :size        => 16,
    },
    
    ## Background settings
    :type => 0,  ## 0 = Default Window, 1 = Gradient, 2 = Picture
    
    ## Type 0 settings
    :type_0     =>  { 
      :opacity  => 255, 
    },
    
    ## Type 1 settings
    :type_1     =>  {
      :color1   =>  [0, 0, 0, 182],
      :color2   =>  [0, 0, 0, 0],
      :vertical =>  true,
    },
    
    ## Type 2 settings
    :type_2     =>  {
      :picture  =>  "SaveBack", ## Goes in the folder Graphics/System
      :opacity  =>  255,
      :offset_x =>  0,
      :offset_y =>  0,
    },
    
  } ## Header
  
  
  ## Settings pertaining to the info section
  INFO ={
    
    ## Basic settings
    :enable => true,
    :x      => 0,
    :y      => 48,
    :z      => 100,
    :width  => 284,
    :height => 368,
    
    ## Background settings
    :type => 0,  ## 0 = Default Window, 1 = Gradient, 2 = Picture
    
    ## Type 0 settings
    :type_0     =>  { 
      :opacity  => 255, 
    },
    
    ## Type 1 settings
    :type_1     =>  {
      :color1   =>  [0, 0, 0, 182],
      :color2   =>  [0, 0, 0, 0],
      :vertical =>  true,
    },
    
    ## Type 2 settings
    :type_2     =>  {
      :picture  =>  "InfoBox", ## Goes in the folder Graphics/System
      :opacity  =>  255,
      :offset_x =>  0,
      :offset_y =>  0,
    },
    
    ## Main settings
    :main       =>  {
      :enable   =>  false,
      :x        =>  0,
      :y        =>  0,
      :z        =>  10,
      :filename =>  "InfoBox",
      :type   => 1, ## Main type on empty slots.  0 - Same as normal.
                    ## 1 - Greyed out.  2 - Don't use.  3 - Custom.
      :type_3 => {
        :filename => "Empty_Main",
      },
    }, ## End main
    
    ## Slot settings
    :slot =>  {
      :enable => true,
      :x      => 16,
      :y      => 12,
      :z      => 20,
      :width  => 200,
      :height => 24,
      
      :text        => 'File <index>', ## <index> replaces with slot number.
      :color       => [255, 255, 255, 255],
      :outline     => [0, 0, 0, 255],
      :bold        => true,
      :italic      => false,
      :align       => 0,
      :font        => "Open Sans",
      :size        => 20,
    }, ## End slot
    
    ## Character settings
    :character =>  {
      :enable   => true,
      :x        => 46,
      :y        => 208,
      :z        => 20,
      
      :shown    => 12,  ## 0 - Whole party, 1+ - First X,
      :x_offset => "(index % 4) * 64",
      :y_offset => "(index / 4) * 48",
      
      :lunatic => {  ## Character set row settings.
        :hor_cells   => [12, 3],
        :ver_cells   => [8,  4],
        :cell_select => [1, 0],
      },
      
      ## Type settings.  0 - Normal files, 1 - Custom files
      :type     =>  0,
      :type_1   =>  {
        :filename   =>  "Actor", ## Put image in Graphics/Characters
        :base_actor =>  true,    ## Character file for each actor will be
                                 ## filename + "_ActorID"
                                 ## Example: PartyChara_1
        :base_class =>  false,   ## Can be use with base_actor, character file
                                 ## will be filename_"ClassID"
                                 ## Example: PartyClass_1_1
      },
    }, ## End character
    
    ## Face settings
    :face =>  {
      :enable   => true,
      :x        => 12,
      :y        => 40,
      :z        => 25,
      
      :shown    => 1,  ## 0 - Whole party, 1+ - First X,
      :x_offset => 0,
      :y_offset => 0,
      
      ## Type settings.  0 - Normal files, 1 - Custom files
      :type     =>  0,
      :type_1   =>  {
        :filename   =>  "Actor", ## Put image in Graphics/Characters
        :base_actor =>  true,    ## Face file for each actor will be
                                 ## filename + "_ActorID"
                                 ## Example: PartyFace_1
        :base_class =>  false,   ## Can be use with base_actor, face file
                                 ## will be filename_"ClassID"
                                 ## Example: PartyClass_1_1
      },
    }, ## End face
    
    ## Name settings
    :name =>  {
      :enable => true,
      :x      => 110,
      :y      => 40,
      :z      => 30,
      :width  => 200,
      :height => 32,
      
      :color       => [255, 255, 255, 255],
      :outline     => [0, 0, 0, 255],
      :bold        => true,
      :italic      => false,
      :align       => 0,
      :font        => "Open Sans",
      :size        => 20,
    }, ## End name
    
    ## Level settings
    :level =>  {
      :enable => true,
      :x      => 110,
      :y      => 72,
      :z      => 30,
      :width  => 200,
      :height => 32,
      
      :text        => "Level <level>",  ## <level> replaces with level number.
      :color       => [255, 255, 255, 255],
      :outline     => [0, 0, 0, 255],
      :bold        => true,
      :italic      => false,
      :align       => 0,
      :font        => "Open Sans",
      :size        => 20,
    }, ## End level
    
    ## Map Name settings
    :map_name =>  {
      :enable => true,
      :x      => 12,
      :y      => 136,
      :z      => 30,
      :width  => 260,
      :height => 32,
      
      :color       => [255, 255, 255, 255],
      :outline     => [0, 0, 0, 255],
      :bold        => true,
      :italic      => false,
      :align       => 1,
      :font        => "Open Sans",
      :size        => 20,
    }, ## End map name
    
    ## Playtime settings
    :playtime =>  {
      :enable => true,
      :x      => 12,
      :y      => 332,
      :z      => 30,
      :width  => 260,
      :height => 24,
      
      :color       => [255, 255, 255, 255],
      :outline     => [0, 0, 0, 255],
      :bold        => true,
      :italic      => false,
      :align       => 1,
      :font        => "Open Sans",
      :size        => 20,
    }, ## End playtime
    
  } ## Info
  
  
  ## Settings pertaining to the save file windows
  SAVE_FILE ={
    
    ## Basic settings
    :cursor => false,
    :x        => 284,
    :y        => 48,
    :z        => 200,
    :width    => 260,
    :height   => 46,
    :x_offset => 0,
    :y_offset => "index * 46",
    
    ## Background settings
    :type => 0,  ## 0 = Default Window, 1 = Gradient, 2 = Picture
    
    ## Type 0 settings
    :type_0     =>  { 
      :opacity  => 255, 
    },
    
    ## Type 1 settings
    :type_1     =>  {
      :color1   =>  [0, 0, 0, 182],
      :color2   =>  [0, 0, 0, 0],
      :vertical =>  true,
    },
    
    ## Type 2 settings
    :type_2     =>  {
      :picture  =>  "FileBox", ## Goes in the folder Graphics/System
      :opacity  =>  255,
      :offset_x =>  0,
      :offset_y =>  0,
    },
    
    ## Main settings
    :main       =>  {
      :enable   =>  false,
      :x        =>  0,
      :y        =>  0,
      :z        =>  10,
      :filename =>  "FileBox",
      
      :grey_out  => false, ## Greyed out when not selected?
      :highlight => true,  ## Highlighted while selected?
      
      :type   => 1, ## Main type on empty slots.  0 - Same as normal.
                    ## 1 - Greyed out.  2 - Don't use.  3 - Custom.
      :type_3 => {
        :filename => "Empty_Main",
      },
    }, ## End main
    
    ## Slot settings
    :slot =>  {
      :enable => true,
      :x      => 12,
      :y      => 12,
      :z      => 20,
      :width  => 200,
      :height => 22,
      
      :text        => 'File <index>', ## <index> replaces with slot number.
      :color       => [255, 255, 255, 255],
      :outline     => [0, 0, 0, 255],
      :bold        => true,
      :italic      => false,
      :align       => 0,
      :font        => "Open Sans",
      :size        => 16,
    }, ## End slot
    
    ## Character settings
    :character =>  {
      :enable   => true,
      :x        => 82,
      :y        => 39,
      :z        => 20,
      
      :shown    => 4,  ## 0 - Whole party, 1+ - First X,
      :x_offset => "(index % 4) * 32",
      :y_offset => 0,
      
      :lunatic => {  ## Character set row settings.
        :hor_cells   => [12, 3],
        :ver_cells   => [8,  4],
        :cell_select => [1, 0],
      },
      
      :grey_out  => true,  ## Greyed out when not selected?
      :highlight => true,  ## Highlighted while selected?
      
      ## Type settings.  0 - Normal files, 1 - Custom files
      :type     =>  0,
      :type_1   =>  {
        :filename   =>  "Actor", ## Put image in Graphics/Characters
        :base_actor =>  true,    ## Character file for each actor will be
                                 ## filename + "_ActorID"
                                 ## Example: PartyChara_1
        :base_class =>  false,   ## Can be use with base_actor, character file
                                 ## will be filename_"ClassID"
                                 ## Example: PartyClass_1_1
      },
    }, ## End character
    
    ## Face settings
    :face =>  {
      :enable   => false,
      :x        => 12,
      :y        => 40,
      :z        => 25,
      
      :shown    => 1,  ## 0 - Whole party, 1+ - First X,
      :x_offset => 0,
      :y_offset => 0,
      
      :grey_out  => false, ## Greyed out when not selected?
      :highlight => false, ## Highlighted while selected?
      
      ## Type settings.  0 - Normal files, 1 - Custom files
      :type     =>  0,
      :type_1   =>  {
        :filename   =>  "Actor", ## Put image in Graphics/Characters
        :base_actor =>  true,    ## Face file for each actor will be
                                 ## filename + "_ActorID"
                                 ## Example: PartyFace_1
        :base_class =>  false,   ## Can be use with base_actor, face file
                                 ## will be filename_"ClassID"
                                 ## Example: PartyClass_1_1
      },
    }, ## End face
    
    ## Name settings
    :name =>  {
      :enable => true,
      :x      => 12,
      :y      => 12,
      :z      => 30,
      :width  => 236,
      :height => 22,
      
      :color       => [255, 255, 255, 255],
      :outline     => [0, 0, 0, 255],
      :bold        => true,
      :italic      => false,
      :align       => 2,
      :font        => "Open Sans",
      :size        => 16,
    }, ## End name
    
    ## Level settings
    :level =>  {
      :enable => false,
      :x      => 110,
      :y      => 72,
      :z      => 30,
      :width  => 200,
      :height => 32,
      
      :text        => "Level <level>",  ## <level> replaces with level number.
      :color       => [255, 255, 255, 255],
      :outline     => [0, 0, 0, 255],
      :bold        => true,
      :italic      => false,
      :align       => 0,
      :font        => "Open Sans",
      :size        => 20,
    }, ## End level
    
    ## Map Name settings
    :map_name =>  {
      :enable => false,
      :x      => 12,
      :y      => 136,
      :z      => 30,
      :width  => 260,
      :height => 32,
      
      :color       => [255, 255, 255, 255],
      :outline     => [0, 0, 0, 255],
      :bold        => true,
      :italic      => false,
      :align       => 1,
      :font        => "Open Sans",
      :size        => 20,
    }, ## End map name
    
    ## Playtime settings
    :playtime =>  {
      :enable => false,
      :x      => 12,
      :y      => 332,
      :z      => 30,
      :width  => 260,
      :height => 24,
      
      :color       => [255, 255, 255, 255],
      :outline     => [0, 0, 0, 255],
      :bold        => true,
      :italic      => false,
      :align       => 1,
      :font        => "Open Sans",
      :size        => 20,
    }, ## End playtime
    
  }
  
end