##-----------------------------------------------------------------------------
## Luna Engine - Easy Status Menu Add-on
## Created by Neon Black - 10.18.2013
##
## CONFIG HALF
##   - Requires the core half below it to work.
##
## This script is the first half of a 2 part script that allows the status
## menu to be customized without the need to use lunatic customization.  The
## status menu may be easily customized using commands similar to the rest of
## the Luna engine.  To use this script place the script anywhere below
## "▼ Materials" and above "▼ Main Process".  When using the Luna Engine Menu
## script, both pieces must go BELOW the Luna Engine.
##
##  ▼ Materials
##   Yami's Luna Menu
##   Neon's Luna Status Config
##   Neon's Luna Status Core
##
##  ▼ Main Process
##-----------------------------------------------------------------------------

module CPLunaStatus
  
  STATUS_WINDOW ={
    ## Sizes and position settings
    :x        => 0,
    :y        => 0,
    :z        => 200,
    :width    => 544,
    :height   => 412,
    :padding => 0,
    
    ## Dual page settings
    :switch_button => :C,
    :page1 => [:stats1, :equips],
    :page2 => [:stats2, :elements],
    
    ## Background settings
    :type => 0,  ## 0 = Default Window, 1 = Gradient, 2 = Picture
    
    ## Type 0 settings
    :type_0     =>  { 
      :opacity  => 0, 
    },
    
    ## Type 1 settings
    :type_1     =>  {
      :color1   =>  [0, 0, 0, 0],
      :color2   =>  [0, 0, 0, 182],
      :vertical =>  true,
    },
    
    ## Type 2 settings
    :type_2     =>  {
      :picture  =>  "StatusWindow", ## Goes in the folder Graphics/System
      :opacity  =>  255,
      :offset_x =>  0,
      :offset_y =>  0,
    },
    
    ## Main 1 settings
    :main1      =>  {
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
    
    ## Main 2 settings
    :main2      =>  {
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
      :x        =>  113,
      :y        =>  12,
      :z        =>  50,
      :width    =>  200,
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
      :x        =>  318,
      :y        =>  12,
      :z        =>  60,
      :width    =>  200,
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
      :x        =>  318,
      :y        =>  36,
      :z        =>  60,
      :width    =>  200,
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
      :x        =>  113,
      :y        =>  36,
      :z        =>  55,
      :width    =>  200,
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
      :x        =>  113,
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
      :x        =>  113,
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
    
    ## XP Bar settings
    :xp_bar     =>  {
      :enable   =>  true,
      :x        =>  318,
      :y        =>  94,
      :z        =>  5,
      :type     =>  0,     ## 0 - Default bar; 1 - Custom bar.
                           ## 2 - Custom frame-based bar.
      :vertical =>  false, ## Works for type 0 and 1.
      
      ## Type 0 settings
      :type_0   =>  {
        :back_color =>  [0, 0, 0, 96],
        :color1     =>  [255, 16, 255, 255],
        :color2     =>  [255, 64, 255, 255],
        :outline    =>  [0, 0, 0, 255],
        :width      =>  200,
        :height     =>  10,
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
    }, ## End XP bar
      
    ## HP Number settings
    :hp_num     =>  {
      :enable   =>  true,
      :x        =>  123,
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
      :x        =>  123,
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
      
    ## XP Number settings
    :xp_num     =>  {
      :enable    =>  true,
      :x         =>  318,
      :y         =>  66,
      :z         =>  80,
      :total_exp =>  false,
      :type      =>  0,          ## 0 - Default font.  1 - Custom number.
      :vocab     =>  "<c>/ EXP", ## Only works with type 0.  <c> is used for
                                 ## current value, <m> is used for max.
      
      ## Type 0 settings
      :type_0   =>  {
        :width     =>  150,
        :height    =>  24,
        :color     =>  [255, 255, 255, 255],
        :outline   =>  [0, 0, 0, 255],
        :max_level =>  "-----",
        :bold      =>  false,
        :italic    =>  false,
        :align     =>  2,
        :font      =>  "Franklin Gothic Demi Cond",
        :size      =>  24,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End XP num
      
    ## HP Max settings
    :hp_max     =>  {
      :enable   =>  true,
      :x        =>  218,
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
      :x        =>  218,
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
      
    ## XP Max settings
    :xp_max     =>  {
      :enable    =>  true,
      :x         =>  318,
      :y         =>  84,
      :z         =>  80,
      :total_exp =>  false,
      :type      =>  0,         ## 0 - Default font.  1 - Custom number.
      
      ## Type 0 settings
      :type_0   =>  {
        :width     =>  140,
        :height    =>  24,
        :color     =>  [255, 255, 255, 255],
        :outline   =>  [0, 0, 0, 255],
        :max_level =>  "-----",
        :bold      =>  false,
        :italic    =>  false,
        :align     =>  2,
        :font      =>  "Franklin Gothic Demi Cond",
        :size      =>  24,
      },
      
      ## Type 1 settings
      :type_1   =>  {
        :width    =>  36, # Use for align
        :filename =>  "Numbers",
        :spacing  =>  -1,
        :align    =>  1,
      },
    }, ## End XP max
      
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
    :stats1   =>  {
      :enable      => true,
      :width       => 120,
      :line_height => 24,
      :stats       => [:atk, :def, :mat, :mdf, :agi, :luk],
      
      :names =>  {
        :x       => 76,
        :y       => 152,
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
        :x        => 76,
        :y        => 152,
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
    
    ## Stats settings
    :stats2   =>  {
      :enable      => true,
      :width       => 120,
      :line_height => 24,
      :stats       => [:hit, :cri, :eva, :mev, :cnt, :mrf],
      
      :names =>  {
        :x       => 76,
        :y       => 152,
        :z       => 120,
        :vocabs  => ["Hit %", "Critical", "Evade", "Magic Evade", "Counter %", "Reflect %"],
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
        :x        => 76,
        :y        => 152,
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
      :x           => 333,
      :y           => 152,
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
    
    ## Elements settings
    :elements   =>  {
      :enable      => true,
      :width       => 120,
      :line_height => 24,
      :elements    => [3, 4, 5, 6, 7, 8],
      
      :names =>  {
        :x       => 333,
        :y       => 152,
        :z       => 120,
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
        :x        => 333,
        :y        => 152,
        :z        => 120,
        :color    => [255, 255, 255, 255],
        :outline  => [0, 0, 0, 255],
        :bold     => false,
        :italic   => false,
        :align    => 2,
        :font     => "Franklin Gothic Demi Cond",
        :size     => 20,
        
      },
    }, ## End element settings
    
    ## State rates settings
    :rates   =>  {
      :enable      => false,
      :width       => 120,
      :line_height => 24,
      :states      => [2, 3, 4, 5, 6, 7],
      
      :names =>  {
        :x       => 333,
        :y       => 152,
        :z       => 120,
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
        :x        => 333,
        :y        => 152,
        :z        => 120,
        :color    => [255, 255, 255, 255],
        :outline  => [0, 0, 0, 255],
        :bold     => false,
        :italic   => false,
        :align    => 2,
        :font     => "Franklin Gothic Demi Cond",
        :size     => 20,
        
      },
    }, ## End rates settings
    
    ## Description settings
    :describe    =>  {
      :enable      =>  true,
      :x           =>  0,
      :y           =>  352,
      :z           =>  60,
      :width       =>  544,
      :height      =>  48,
      :line_height =>  24,
      :color       =>  [255, 255, 255, 255],
      :outline     =>  [0, 0, 0, 255],
      :bold        =>  true,
      :italic      =>  false,
      :align       =>  1,
      :font        =>  "Open Sans",
      :size        =>  20,
    }, ## End class
  }
  
  STATUS_BACKGROUND ={
    
    ## Background settings
    :background    =>  {
      :type  => 1,
      
      ## Type 0 settings
      :type_0 => {
        :color => [16, 16, 16, 128]
      },
      
      ## Type 0 settings
      ## These are all arrays with several elements in them.  Each must contain
      ## the same number of elements in them and the position of each in the
      ## array relates to the same frame.  Frame names may have <id> in them
      ## for the ID of the actor currently displayed and <cid> for the class
      ## ID.  For example, "Actor_<id>" would relate to "Actor_1" for the first
      ## actor, "Actor_2" for the second, etc.
      :type_1 => {
        :frames   => ["pattern", "menuif", "menuwave1", "menuwave2", "menuwave3"],
        :offset_x => [        0,        0,           0,           0,           0],
        :offset_y => [        0,      -34,          86,          86,          86],
        :offset_z => [        0,        0,           1,           2,           3],
        :width    => [      544,      544,         544,         544,         544],
        :height   => [      416,      480,         240,         240,         240],
        :pan_x    => [        0,        0,          -2,           1,          -1],
        :pan_y    => [        0,        0,           0,           0,           0],
        :blending => [        0,        0,           1,           1,           1],
        :map_color =>[        0,        0,           0,         255],
      },
    }, ## End background settings
  }
  
end