##-----------------------------------------------------------------------------
## Luna Engine - Yanfly's Party System Add-on
## Created by Neon Black - 10.10.2013
##
## CONFIG HALF
##   - Requires the core half below it to work.
##
## This script is the first half of a 2 part script that allows Yanfly's
## party system to be easily customized like the rest of the Luna Engine.  This
## script requires both halves to be present as well as Yanfly's Party System.
## To use this script place the script anywhere below "▼ Materials" and above
## "▼ Main Process".  When using the Luna Engine Menu script, all 3 pieces must
## go BELOW the Luna Engine.
##
##  ▼ Materials
##   Yami's Luna Menu
##   Yanfly's Party System
##   Neon's Luna Party Config
##   Neon's Luna Party Core
##
##  ▼ Main Process
##-----------------------------------------------------------------------------

module CPLunaParty
  
  STATUS_MENU ={
    ## Limits the main menu displayed party to only characters in the active
    ## party if this value is set to true.
    :limit_max => true,
  }
  
  COMMAND_WINDOW ={
    ## Sizes and position settings
    :x        => 0,
    :y        => 0,
    :z        => 300,
    :width    => 160,
    :height   => 120,
    :padding  => 12,
    
    ## Item and selection settings
    :item_height  => 24,
    :cursor       => true,
    :pic_cursor   =>  {
      :enable   => false,
      :picture  => "CommandCursor",
      :opacity  => 255,
      :offset_x => 16,
      :offset_y => 0,
    },
    
    ## Selection text settings
    :text =>  {
      :color    =>  [255, 255, 255, 255],
      :outline  =>  [0, 0, 0, 255],
      :bold     =>  true,
      :italic   =>  false,
      :align    =>  1,
      :font     =>  "Open Sans",
      :size     =>  16,
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
      :picture  =>  "CommandBox", ## Goes in the folder Graphics/System
      :opacity  =>  255,
      :offset_x =>  0,
      :offset_y =>  0,
    },
    
  }
  
  
  RESERVE_WINDOW ={
    ## Sizes and position settings
    :x        => 0,
    :y        => 120,
    :z        => 250,
    :width    => 200,
    :height   => 296,
    :padding  => 12,
    
    ## Item and selection settings
    :item_height  => 24,
    :cursor       => true,
    :pic_cursor   =>  {
      :enable   => false,
      :picture  => "CommandCursor",
      :opacity  => 255,
      :offset_x => 16,
      :offset_y => 0,
    },
    
    ## Selection text settings
    :text =>  {
      :party_color     =>  [255, 255, 100, 255],
      :party_outline   =>  [0, 0, 0, 255],
      :reserve_color   =>  [255, 255, 255, 255],
      :reserve_outline =>  [0, 0, 0, 255],
      :bold            =>  true,
      :italic          =>  false,
      :font            =>  "Open Sans",
      :size            =>  16,
    },
    
    ## Background settings
    :type => 0,  ## 0 = Default Window, 1 = Gradient, 2 = Picture
    
    ## Type 0 settings
    :type_0     =>  { 
      :opacity  => 255, 
    },
    
    ## Type 1 settings
    :type_1     =>  {
      :color1   =>  [0, 0, 0, 0],
      :color2   =>  [0, 0, 0, 182],
      :vertical =>  true,
    },
    
    ## Type 2 settings
    :type_2     =>  {
      :picture  =>  "CommandBox", ## Goes in the folder Graphics/System
      :opacity  =>  255,
      :offset_x =>  0,
      :offset_y =>  0,
    },
    
  }
  
  
  PARTY_WINDOW ={
    ## Sizes and position settings
    :x        => 160,
    :y        => 0,
    :z        => 350,
    :width    => 384,
    :height   => 120,
    :padding  => 12,
    
    ## Item and selection settings
    :cursor       => true,
    :pic_cursor   =>  {
      :enable   => false,
      :picture  => "CommandCursor",
      :opacity  => 255,
      :offset_x => 16,
      :offset_y => 0,
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
      :picture  =>  "CommandBox", ## Goes in the folder Graphics/System
      :opacity  =>  255,
      :offset_x =>  0,
      :offset_y =>  0,
    },
    
    ## Object position settings
    :status =>  {
      :width    => 72,
      :height   => 96,
      :spacing  => 0,
      :vertical => false,
      :offset_x => "0",
      :offset_y => "0",
    },
    
    ## Main settings
    :main       =>  {
      :enable   =>  false,
      :x        =>  2,
      :y        =>  2,
      :z        =>  2,
      :filename =>  "Skin_Main",
      :collapse =>  false,
      :collapse_type => 1,   ## 0 - Like Battler; 1 - Grey out.
      :highlight  =>  false, ## Highlight when selected.
      :base_actor =>  false, ## Main file for each actor will be
                             ## filename + "_ActorID"
                             ## Example: MainHUD_1
      :base_class =>  false, ## Can be use with base_actor, main file
                             ## will be filename_"ClassID"
                             ## Example: MainHUD_1_1
      :type   => 1, ## Main type on empty slots.  0 - Same as normal.
                    ## 1 - Greyed out.  2 - Don't use.  3 - Custom.
      :type_3 => {
        :filename => "Empty_Main",
      },
    }, ## End main
    
    ## Select settings
    :select     =>  {
      :enable   =>  false,
      :x        =>  2,
      :y        =>  2,
      :z        =>  2,
      :filename =>  "Select_Box",
      :base_actor =>  false, ## Main file for each actor will be
                             ## filename + "_ActorID"
                             ## Example: MainHUD_1
      :base_class =>  false, ## Can be use with base_actor, main file
                             ## will be filename_"ClassID"
                             ## Example: MainHUD_1_1
      :type   => 1, ## Main type on empty slots.  0 - Same as normal.
                    ## 1 - Greyed out.  2 - Don't use.  3 - Custom.
      :type_3 => {
        :filename => "Empty_Main",
      },
    }, ## End select.
    
    ## Empty settings
    :empty =>  {
      :enable  => true,
      :x       => 0,
      :y       => 40,
      :z       => 200,
      :width   =>  72,
      :height  =>  16,
      :color   =>  [255, 255, 255, 255],
      :outline =>  [0, 0, 0, 255],
      :bold    =>  true,
      :italic  =>  false,
      :align   =>  1,
      :font    =>  "Open Sans",
      :size    =>  16,
      :vocab   =>  "-Empty-"
    }, ## End empty
    
    ## Face settings
    :face =>  {
      :enable => false,
      :x       => 0,
      :y       => 0,
      :z       => 15,
      :collapse      =>  true,
      :collapse_type => 0,       ## 0 - Like Battler; 1 - Grey out.
      :highlight     =>  true,
      :type     =>  0,
      :type_1   =>  {
        :filename   =>  "Actor", ## Put image in Graphics/Characters
        :base_actor =>  true,    ## Character file for each actor will be
                                 ## filename + "_ActorID"
                                 ## Example: PartyChara_1
        :base_class =>  false,   ## Can be use with base_actor, face file
                                 ## will be filename_"ClassID"
                                 ## Example: PartyClass_1_1
      },
    }, ## End face
    
    ## Character settings
    :character =>  {
      :enable  => true,
      :x       => 36,
      :y       => 87,
      :z       => 20,
      :lunatic => {
        :hor_cells   => [12, 3],
        :ver_cells   => [8,  4],
        :cell_select => [1, 0],
      },
      :collapse      =>  true,
      :collapse_type => 1,       ## 0 - Like Battler; 1 - Grey out.
      :highlight     =>  true,
      :type     =>  0,
      :type_1   =>  {
        :filename   =>  "Actor", ## Put image in Graphics/Characters
        :base_actor =>  true,    ## Character file for each actor will be
                                 ## filename + "_ActorID"
                                 ## Example: PartyChara_1
        :base_class =>  false,   ## Can be use with base_actor, face file
                                 ## will be filename_"ClassID"
                                 ## Example: PartyClass_1_1
      },
    }, ## End character
    
    ## Name settings
    :name       =>  {
      :enable   =>  true,
      :x        =>  0,
      :y        =>  0,
      :z        =>  50,
      :width    =>  72,
      :height   =>  16,
      :color    =>  [255, 255, 255, 255],
      :outline  =>  [0, 0, 0, 255],
      :bold     =>  true,
      :italic   =>  false,
      :align    =>  1,
      :font     =>  "Open Sans",
      :size     =>  16,
    }, ## End name
    
    ## Class settings
    :class       =>  {
      :enable   =>  true,
      :x        =>  2,
      :y        =>  16,
      :z        =>  60,
      :width    =>  70,
      :height   =>  16,
      :color    =>  [255, 255, 255, 255],
      :outline  =>  [0, 0, 0, 255],
      :bold     =>  false,
      :italic   =>  false,
      :align    =>  0,
      :font     =>  "Open Sans",
      :size     =>  16,
    }, ## End class
      
    ## Level settings
    :level       =>  {
      :enable   =>  true,
      :x        =>  0,
      :y        =>  25,
      :z        =>  55,
      :width    =>  70,
      :height   =>  16,
      :color    =>  [255, 255, 255, 255],
      :outline  =>  [0, 0, 0, 255],
      :bold     =>  true,
      :italic   =>  true,
      :align    =>  2,
      :font     =>  "Open Sans",
      :size     =>  16,
      :vocab    =>  "Lv <l>",  ## <l> is used for level number value.
    }, ## End level
    
    ## HP Bar settings
    :hp_bar     =>  {
      :enable   =>  true,
      :x        =>  9,
      :y        =>  47,
      :z        =>  5,
      :type     =>  0,     ## 0 - Default bar; 1 - Custom bar.
                           ## 2 - Custom frame-based bar.
      :vertical =>  true,  ## Works for type 0 and 1.
      
      ## Type 0 settings
      :type_0   =>  {
        :back_color =>  [0, 0, 0, 96],
        :color1     =>  [255, 16, 16, 192],
        :color2     =>  [255, 96, 96, 192],
        :outline    =>  [0, 0, 0, 255],
        :width      =>  8,
        :height     =>  48,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :filename =>  "HP_Bar",
      },
      
      ## Type 2 settings
      :type_2   =>  {
        :filename =>  "Btskin_hp",
        :frames   =>  8,
      },
    }, ## End HP bar
    
    ## MP Bar settings
    :mp_bar     =>  {
      :enable   =>  true,
      :x        =>  55,
      :y        =>  47,
      :z        =>  5,
      :type     =>  0,     ## 0 - Default bar; 1 - Custom bar.
                           ## 2 - Custom frame-based bar.
      :vertical =>  true,  ## Works for type 0 and 1.
      
      ## Type 0 settings
      :type_0   =>  {
        :back_color =>  [0, 0, 0, 96],
        :color1     =>  [16, 16, 255, 192],
        :color2     =>  [96, 96, 255, 192],
        :outline    =>  [0, 0, 0, 255],
        :width      =>  8,
        :height     =>  48,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :filename =>  "MP_Bar",
      },
      
      ## Type 2 settings
      :type_2   =>  {
        :filename =>  "Btskin_mp",
        :frames   =>  8,
      },
    }, ## End MP bar
    
    ## TP Bar settings
    :tp_bar     =>  {
      :enable   =>  false,
      :x        =>  59,
      :y        =>  47,
      :z        =>  5,
      :type     =>  0,     ## 0 - Default bar; 1 - Custom bar.
                           ## 2 - Custom frame-based bar.
      :vertical =>  true,  ## Works for type 0 and 1.
      
      ## Type 0 settings
      :type_0   =>  {
        :back_color =>  [0, 0, 0, 96],
        :color1     =>  [16, 255, 16, 255],
        :color2     =>  [64, 255, 64, 255],
        :outline    =>  [0, 0, 0, 255],
        :width      =>  8,
        :height     =>  48,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :filename =>  "TP_Bar",
      },
      
      ## Type 2 settings
      :type_2   =>  {
        :filename =>  "Btskin_tp",
        :frames   =>  8,
      },
    }, ## End TP bar
      
    ## HP Number settings
    :hp_num     =>  {
      :enable   =>  true,
      :x        =>  0,
      :y        =>  80,
      :z        =>  80,
      :type     =>  0,         ## 0 - Default font.  1 - Custom number.
      :vocab    =>  "<c>",     ## Only works with type 0.  <c> is used for
                               ## current value, <m> is used for max.
      
      ## Type 0 settings
      :type_0   =>  {
        :width    =>  36,
        :height   =>  16,
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 255],
        :bold     =>  false,
        :italic   =>  false,
        :align    =>  1,
        :font     =>  "Franklin Gothic Demi Cond",
        :size     =>  16,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End HP num
      
    ## MP Number settings
    :mp_num     =>  {
      :enable   =>  true,
      :x        =>  36,
      :y        =>  80,
      :z        =>  80,
      :type     =>  0,         ## 0 - Default font.  1 - Custom number.
      :vocab    =>  "<c>",     ## Only works with type 0.  <c> is used for
                               ## current value, <m> is used for max.
      
      ## Type 0 settings
      :type_0   =>  {
        :width    =>  36,
        :height   =>  16,
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 255],
        :bold     =>  false,
        :italic   =>  false,
        :align    =>  1,
        :font     =>  "Franklin Gothic Demi Cond",
        :size     =>  16,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End MP num
      
    ## TP Number settings
    :tp_num     =>  {
      :enable   =>  false,
      :x        =>  0,
      :y        =>  80,
      :z        =>  80,
      :type     =>  1,         ## 0 - Default font.  1 - Custom number.
      :vocab    =>  "<c>/<m>", ## Only works with type 0.  <c> is used for
                               ## current value, <m> is used for max.
      
      ## Type 0 settings
      :type_0   =>  {
        :width    =>  36,
        :height   =>  16,
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 255],
        :bold     =>  false,
        :italic   =>  false,
        :align    =>  1,
        :font     =>  "Franklin Gothic Demi Cond",
        :size     =>  16,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End TP num
      
    ## HP Max settings
    :hp_max     =>  {
      :enable   =>  false,
      :x        =>  0,
      :y        =>  80,
      :z        =>  100,
      :type     =>  0,         ## 0 - Default font.  1 - Custom number.
      
      ## Type 0 settings
      :type_0   =>  {
        :width    =>  72,
        :height   =>  16,
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 255],
        :bold     =>  false,
        :italic   =>  false,
        :align    =>  1,
        :font     =>  "Franklin Gothic Demi Cond",
        :size     =>  16,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End HP max
      
    ## MP Max settings
    :mp_max     =>  {
      :enable   =>  false,
      :x        =>  0,
      :y        =>  80,
      :z        =>  80,
      :type     =>  1,         ## 0 - Default font.  1 - Custom number.
      
      ## Type 0 settings
      :type_0   =>  {
        :width    =>  36,
        :height   =>  16,
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 255],
        :bold     =>  false,
        :italic   =>  false,
        :align    =>  1,
        :font     =>  "Franklin Gothic Demi Cond",
        :size     =>  16,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End MP max
      
    ## TP Max settings
    :tp_max     =>  {
      :enable   =>  false,
      :x        =>  0,
      :y        =>  80,
      :z        =>  80,
      :type     =>  1,         ## 0 - Default font.  1 - Custom number.
      
      ## Type 0 settings
      :type_0   =>  {
        :width    =>  36,
        :height   =>  16,
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 255],
        :bold     =>  false,
        :italic   =>  false,
        :align    =>  1,
        :font     =>  "Franklin Gothic Demi Cond",
        :size     =>  16,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End TP max
    
  }
  
  
  ACTOR_WINDOW ={
    ## Sizes and position settings
    :x        => 200,
    :y        => 120,
    :z        => 200,
    :width    => 344,
    :height   => 296,
    
    ## Background settings
    :type => 0,  ## 0 = Default Window, 1 = Gradient, 2 = Picture
    
    ## Type 0 settings
    :type_0     =>  { 
      :opacity  => 255, 
    },
    
    ## Type 1 settings
    :type_1     =>  {
      :color1   =>  [0, 0, 0, 0],
      :color2   =>  [0, 0, 0, 182],
      :vertical =>  true,
    },
    
    ## Type 2 settings
    :type_2     =>  {
      :picture  =>  "CommandBox", ## Goes in the folder Graphics/System
      :opacity  =>  255,
      :offset_x =>  0,
      :offset_y =>  0,
    },
    
    ## Main settings
    :main       =>  {
      :enable   =>  false,
      :x        =>  2,
      :y        =>  2,
      :z        =>  2,
      :filename =>  "Skin_Main",
      :collapse =>  false,
      :collapse_type => 1,   ## 0 - Like Battler; 1 - Grey out.
      :base_actor =>  false, ## Main file for each actor will be
                             ## filename + "_ActorID"
                             ## Example: MainHUD_1
      :base_class =>  false, ## Can be use with base_actor, main file
                             ## will be filename_"ClassID"
                             ## Example: MainHUD_1_1
      :type   => 1, ## Main type on empty slots.  0 - Same as normal.
                    ## 1 - Greyed out.  2 - Don't use.  3 - Custom.
      :type_3 => {
        :filename => "Empty_Main",
      },
    }, ## End main
    
    ## Empty settings
    :empty =>  {
      :enable  => true,
      :x       => 0,
      :y       => 00,
      :z       => 200,
      :width   => 344,
      :height  => 296,
      :color   => [255, 255, 255, 255],
      :outline => [0, 0, 0, 255],
      :bold    => true,
      :italic  => false,
      :align   => 1,
      :font    => "Open Sans",
      :size    => 32,
      :vocab   => "-No Data-"
    }, ## End empty
    
    ## Face settings
    :face =>  {
      :enable => true,
      :x       => 12,
      :y       => 12,
      :z       => 15,
      :collapse      =>  true,
      :collapse_type => 1,       ## 0 - Like Battler; 1 - Grey out.
      :highlight     =>  true,
      :type     =>  0,
      :type_1   =>  {
        :filename   =>  "Actor", ## Put image in Graphics/Characters
        :base_actor =>  true,    ## Character file for each actor will be
                                 ## filename + "_ActorID"
                                 ## Example: PartyChara_1
        :base_class =>  false,   ## Can be use with base_actor, face file
                                 ## will be filename_"ClassID"
                                 ## Example: PartyClass_1_1
      },
    }, ## End face
    
    ## Name settings
    :name       =>  {
      :enable   =>  true,
      :x        =>  120,
      :y        =>  12,
      :z        =>  50,
      :width    =>  80,
      :height   =>  24,
      :color    =>  [255, 255, 255, 255],
      :outline  =>  [0, 0, 0, 255],
      :bold     =>  true,
      :italic   =>  false,
      :align    =>  0,
      :font     =>  "Open Sans",
      :size     =>  20,
    }, ## End name
    
    ## Class settings
    :class       =>  {
      :enable   =>  true,
      :x        =>  200,
      :y        =>  12,
      :z        =>  60,
      :width    =>  120,
      :height   =>  24,
      :color    =>  [255, 255, 255, 255],
      :outline  =>  [0, 0, 0, 255],
      :bold     =>  true,
      :italic   =>  false,
      :align    =>  0,
      :font     =>  "Open Sans",
      :size     =>  20,
    }, ## End class
    
    ## Nickname settings
    :nickname    =>  {
      :enable   =>  true,
      :x        =>  200,
      :y        =>  36,
      :z        =>  60,
      :width    =>  120,
      :height   =>  24,
      :color    =>  [255, 255, 255, 255],
      :outline  =>  [0, 0, 0, 255],
      :bold     =>  true,
      :italic   =>  false,
      :align    =>  0,
      :font     =>  "Open Sans",
      :size     =>  20,
    }, ## End nickname
      
    ## Level settings
    :level       =>  {
      :enable   =>  true,
      :x        =>  120,
      :y        =>  36,
      :z        =>  55,
      :width    =>  80,
      :height   =>  24,
      :color    =>  [255, 255, 255, 255],
      :outline  =>  [0, 0, 0, 255],
      :bold     =>  true,
      :italic   =>  false,
      :align    =>  0,
      :font     =>  "Open Sans",
      :size     =>  20,
      :vocab    =>  "Level <l>",  ## <l> is used for level number value.
    }, ## End level
    
    ## HP Bar settings
    :hp_bar     =>  {
      :enable   =>  true,
      :x        =>  120,
      :y        =>  70,
      :z        =>  5,
      :type     =>  0,     ## 0 - Default bar; 1 - Custom bar.
                           ## 2 - Custom frame-based bar.
      :vertical =>  false, ## Works for type 0 and 1.
      
      ## Type 0 settings
      :type_0   =>  {
        :back_color =>  [0, 0, 0, 96],
        :color1     =>  [255, 16, 16, 192],
        :color2     =>  [255, 96, 96, 192],
        :outline    =>  [0, 0, 0, 255],
        :width      =>  200,
        :height     =>  10,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :filename =>  "HP_Bar",
      },
      
      ## Type 2 settings
      :type_2   =>  {
        :filename =>  "Btskin_hp",
        :frames   =>  8,
      },
    }, ## End HP bar
    
    ## MP Bar settings
    :mp_bar     =>  {
      :enable   =>  true,
      :x        =>  120,
      :y        =>  94,
      :z        =>  5,
      :type     =>  0,     ## 0 - Default bar; 1 - Custom bar.
                           ## 2 - Custom frame-based bar.
      :vertical =>  false, ## Works for type 0 and 1.
      
      ## Type 0 settings
      :type_0   =>  {
        :back_color =>  [0, 0, 0, 96],
        :color1     =>  [16, 16, 255, 192],
        :color2     =>  [96, 96, 255, 192],
        :outline    =>  [0, 0, 0, 255],
        :width      =>  200,
        :height     =>  10,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :filename =>  "MP_Bar",
      },
      
      ## Type 2 settings
      :type_2   =>  {
        :filename =>  "Btskin_mp",
        :frames   =>  8,
      },
    }, ## End MP bar
    
    ## TP Bar settings
    :tp_bar     =>  {
      :enable   =>  false,
      :x        =>  59,
      :y        =>  47,
      :z        =>  5,
      :type     =>  0,     ## 0 - Default bar; 1 - Custom bar.
                           ## 2 - Custom frame-based bar.
      :vertical =>  true,  ## Works for type 0 and 1.
      
      ## Type 0 settings
      :type_0   =>  {
        :back_color =>  [0, 0, 0, 96],
        :color1     =>  [16, 255, 16, 255],
        :color2     =>  [64, 255, 64, 255],
        :outline    =>  [0, 0, 0, 255],
        :width      =>  8,
        :height     =>  48,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :filename =>  "TP_Bar",
      },
      
      ## Type 2 settings
      :type_2   =>  {
        :filename =>  "Btskin_tp",
        :frames   =>  8,
      },
    }, ## End TP bar
      
    ## HP Number settings
    :hp_num     =>  {
      :enable   =>  true,
      :x        =>  130,
      :y        =>  60,
      :z        =>  80,
      :type     =>  0,         ## 0 - Default font.  1 - Custom number.
      :vocab    =>  "<c>/",    ## Only works with type 0.  <c> is used for
                               ## current value, <m> is used for max.
      
      ## Type 0 settings
      :type_0   =>  {
        :width    =>  100,
        :height   =>  24,
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 255],
        :bold     =>  false,
        :italic   =>  false,
        :align    =>  2,
        :font     =>  "Franklin Gothic Demi Cond",
        :size     =>  24,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End HP num
      
    ## MP Number settings
    :mp_num     =>  {
      :enable   =>  true,
      :x        =>  130,
      :y        =>  84,
      :z        =>  80,
      :type     =>  0,         ## 0 - Default font.  1 - Custom number.
      :vocab    =>  "<c>/",    ## Only works with type 0.  <c> is used for
                               ## current value, <m> is used for max.
      
      ## Type 0 settings
      :type_0   =>  {
        :width    =>  100,
        :height   =>  24,
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 255],
        :bold     =>  false,
        :italic   =>  false,
        :align    =>  2,
        :font     =>  "Franklin Gothic Demi Cond",
        :size     =>  24,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End MP num
      
    ## TP Number settings
    :tp_num     =>  {
      :enable   =>  false,
      :x        =>  0,
      :y        =>  80,
      :z        =>  80,
      :type     =>  1,         ## 0 - Default font.  1 - Custom number.
      :vocab    =>  "<c>/<m>", ## Only works with type 0.  <c> is used for
                               ## current value, <m> is used for max.
      
      ## Type 0 settings
      :type_0   =>  {
        :width    =>  36,
        :height   =>  16,
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 255],
        :bold     =>  false,
        :italic   =>  false,
        :align    =>  1,
        :font     =>  "Franklin Gothic Demi Cond",
        :size     =>  16,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End TP num
      
    ## HP Max settings
    :hp_max     =>  {
      :enable   =>  true,
      :x        =>  225,
      :y        =>  60,
      :z        =>  100,
      :type     =>  0,         ## 0 - Default font.  1 - Custom number.
      
      ## Type 0 settings
      :type_0   =>  {
        :width    =>  100,
        :height   =>  24,
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 255],
        :bold     =>  false,
        :italic   =>  false,
        :align    =>  0,
        :font     =>  "Franklin Gothic Demi Cond",
        :size     =>  24,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End HP max
      
    ## MP Max settings
    :mp_max     =>  {
      :enable   =>  true,
      :x        =>  225,
      :y        =>  84,
      :z        =>  100,
      :type     =>  0,         ## 0 - Default font.  1 - Custom number.
      
      ## Type 0 settings
      :type_0   =>  {
        :width    =>  100,
        :height   =>  24,
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 255],
        :bold     =>  false,
        :italic   =>  false,
        :align    =>  0,
        :font     =>  "Franklin Gothic Demi Cond",
        :size     =>  24,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End MP max
      
    ## TP Max settings
    :tp_max     =>  {
      :enable   =>  false,
      :x        =>  0,
      :y        =>  80,
      :z        =>  80,
      :type     =>  1,         ## 0 - Default font.  1 - Custom number.
      
      ## Type 0 settings
      :type_0   =>  {
        :width    =>  36,
        :height   =>  16,
        :color    =>  [255, 255, 255, 255],
        :outline  =>  [0, 0, 0, 255],
        :bold     =>  false,
        :italic   =>  false,
        :align    =>  1,
        :font     =>  "Franklin Gothic Demi Cond",
        :size     =>  16,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End TP max
      
    ## States settings
    :states       =>  {
      :enable   =>  true,
      :x        =>  12,
      :y        =>  84,
      :z        =>  100,
      :type     =>  1,   ## 0 - Default states; 1 - Scrolling states
      
      ## Type 0 settings
      :type_0   =>  {
        :max      =>  4,
        :spacing  =>  1,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :rate     =>  90, ## Frames
      },
    }, ## End states
    
    ## Stats settings
    :stats    =>  {
      :enable      => true,
      :width       => 120,
      :line_height => 24,
      :stats       => [:atk, :def, :mat, :mdf, :agi, :luk],
      
      :names =>  {
        :x       => 27,
        :y       => 120,
        :z       => 120,
        :vocabs  => ["ATK", "DEF", "MAT", "MDF", "AGI", "LUK"],
        :color   => [100, 200, 255, 255],
        :outline => [0, 0, 0, 255],
        :bold    =>  true,
        :italic  =>  true,
        :align   =>  0,
        :font    =>  "Open Sans",
        :size    =>  16,
        
      },
      
      ## Value text settings
      :values =>  {
        :x        => 27,
        :y        => 120,
        :z        => 120,
        :color    => [255, 255, 255, 255],
        :outline  => [0, 0, 0, 255],
        :bold     => false,
        :italic   => false,
        :align    => 2,
        :font     => "Franklin Gothic Demi Cond",
        :size     => 20,
        
      },
    }, ## End stats settings
    
    ## Equip settings
    :equips   =>  {
      :enable      => true,
      :x           => 162,
      :y           => 120,
      :z           => 120,
      :width       => 150,
      :line_height => 24,
      :color       => [255, 255, 255, 255],
      :outline     => [0, 0, 0, 255],
      :bold        =>  true,
      :italic      =>  true,
      :font        =>  "Open Sans",
      :size        =>  16,
    },
  }
  
end #CPLunaParty