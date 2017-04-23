#==============================================================================
# ■ BattleLuna: Specific Actor Config
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This allows you to override Battle Luna Configs for a specific actor.
# This will check the OVERRIDE_HASH and override any key-value in Luna Engine 
# config. For example:
# Luna Engine has :enable for :mp_bar true, OVERRIDE_HASH has :enable set to 
# false. The actor use override tag and will hide the MP bar.
#==============================================================================
# ■ Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# You can add more settings, based on the Luna Engine Config.
# HP/MP/TP/MAXHP/MAXMP/STATES can be added. Check the configuration below
# for more reference.
#
# Use in a notetag <override battle luna: KEY>
# KEY is defined in the Configuration below
#
# In this one's case, it would be :
# <override battle luna: ACTOR1>
#==============================================================================

module BattleLuna
  module SpecificConfig
    
    # add and edit there
    # "KEY" => OVERRIDE_HASH
    SPECIFIC = { # do not delete
      "ACTOR1" => {
        # Name settings
        :name       =>  {
          :enable   =>  true,
          :color    =>  [0, 0, 0, 255],
          :outline  =>  [255, 255, 255, 255],
        }, # End name.
        
        # MP Bar settings
        :mp_bar     =>  {
          :enable   =>  false,
        }, # End mp_bar.
      } # "ACTOR1"
    } # SPECIFIC
    
#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================
    def self.sp_merge(hash1, hash2)
      newhash = {}
      hash1.each { |key, val|
        if hash2 && hash2.has_key?(key)
          if hash2[key].is_a?(Hash) && val.is_a?(Hash)
            newhash[key] = sp_merge(val, hash2[key])
          else
            newhash[key] = hash2[key]
          end
        else
          newhash[key] = val
        end
      }
      return newhash
    end # self.sp_merge
    
  end # SpecificConfig
end # BattleLuna


#==============================================================================
# ■ RPG::BaseItem
#==============================================================================

class RPG::BaseItem
  
  #--------------------------------------------------------------------------
  # new method: override_battle_luna
  #--------------------------------------------------------------------------
  def override_battle_luna
    self.note.split(/[\r\n]+/).each { |line|
      if line =~ /<override battle luna:[ ]*(.*)>/i
        return $1.upcase
      end
    }
    return nil
  end
  
end # RPG::BaseItem

#==============================================================================
# ■ SpriteHUD_Main
#==============================================================================

class SpriteHUD_Main < Sprite_Base
  
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    base = BattleLuna::HUD::BATTLER_HUD[:main]
    key  = @battler.actor.override_battle_luna || ""
    override = BattleLuna::SpecificConfig::SPECIFIC[key]
    if override
      return BattleLuna::SpecificConfig.sp_merge(base, override[:main])
    else
      return base
    end
  end
  
end # SpriteHUD_Main

#==============================================================================
# ■ SpriteHUD_Select
#==============================================================================

class SpriteHUD_Select < Sprite_Base
  
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    base = BattleLuna::HUD::BATTLER_HUD[:select]
    key  = @battler.actor.override_battle_luna || ""
    override = BattleLuna::SpecificConfig::SPECIFIC[key]
    if override
      return BattleLuna::SpecificConfig.sp_merge(base, override[:select])
    else
      return base
    end
  end
  
end # SpriteHUD_Select

#==============================================================================
# ■ SpriteHUD_Face
#==============================================================================

class SpriteHUD_Face < Sprite_Base
  
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    base = BattleLuna::HUD::BATTLER_HUD[:face]
    key  = @battler.actor.override_battle_luna || ""
    override = BattleLuna::SpecificConfig::SPECIFIC[key]
    if override
      return BattleLuna::SpecificConfig.sp_merge(base, override[:face])
    else
      return base
    end
  end
  
end # SpriteHUD_Face

#==============================================================================
# ■ SpriteHUD_Name
#==============================================================================

class SpriteHUD_Name < Sprite
  
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    base = BattleLuna::HUD::BATTLER_HUD[:name]
    key  = @battler.actor.override_battle_luna || ""
    override = BattleLuna::SpecificConfig::SPECIFIC[key]
    if override
      return BattleLuna::SpecificConfig.sp_merge(base, override[:name])
    else
      return base
    end
  end
  
end # SpriteHUD_Name

#==============================================================================
# ■ SpriteHUD_Bar
#==============================================================================

class SpriteHUD_Bar < Sprite
  
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    base = BattleLuna::HUD::BATTLER_HUD[@symbol]
    key  = @battler.actor.override_battle_luna || ""
    override = BattleLuna::SpecificConfig::SPECIFIC[key]
    if override
      return BattleLuna::SpecificConfig.sp_merge(base, override[@symbol])
    else
      return base
    end
  end
  
end # SpriteHUD_Bar

#==============================================================================
# ■ SpriteHUD_Numbers
#==============================================================================

class SpriteHUD_Numbers < Sprite
  
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    case @symbol
    when :hp; sym = :hp_num
    when :mp; sym = :mp_num
    when :tp; sym = :tp_num
    when :mhp; sym = :hp_max_num
    when :mmp; sym = :mp_max_num
    when :mtp; sym = :tp_max_num
    end
    base = BattleLuna::HUD::BATTLER_HUD[sym]
    key  = @battler.actor.override_battle_luna || ""
    override = BattleLuna::SpecificConfig::SPECIFIC[key]
    if override
      return BattleLuna::SpecificConfig.sp_merge(base, override[sym])
    else
      return base
    end
  end
  
end # SpriteHUD_Numbers

#==============================================================================
# ■ SpriteHUD_States
#==============================================================================

class SpriteHUD_States < Sprite
  
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    base = BattleLuna::HUD::BATTLER_HUD[:states]
    key  = @battler.actor.override_battle_luna || ""
    override = BattleLuna::SpecificConfig::SPECIFIC[key]
    if override
      return BattleLuna::SpecificConfig.sp_merge(base, override[:states])
    else
      return base
    end
  end
  
end # SpriteHUD_States