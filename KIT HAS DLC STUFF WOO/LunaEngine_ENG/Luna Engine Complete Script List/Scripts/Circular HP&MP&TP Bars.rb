#==============================================================================
# ■ BattleLuna: Circular HP/MP/TP Bars
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This allows you to have circular bars for HP/MP/TP.
#==============================================================================
$imported = {} if $imported.nil?
$imported["YEL-BattleLuna-CircularBars"] = true

module BattleLuna
  module Addon
    CIRCULAR_BARS = {
      :enable   =>  {
        :hp_bar =>  false,
        :mp_bar =>  false,
        :tp_bar =>  false,
      },
      
      # Currently works for bar type 1 only.
      :style    =>  {
        :hp_bar =>  {
          :angle     =>  [180, 270],# [Start, Total Angle]
                                    # (0 degree is at 6 o'clock)
                                    # (Increases clockwise)
          :clockwise =>  true,
        },
        :mp_bar =>  {
          :angle     =>  [180, 270],# [Start, Total Angle]
                                    # (0 degree is at 6 o'clock)
                                    # (Increases clockwise)
          :clockwise =>  true,
        },
        :tp_bar =>  {
          :angle     =>  [180, 270],# [Start, Total Angle]
                                    # (0 degree is at 6 o'clock)
                                    # (Increases clockwise)
          :clockwise =>  true,
        },
      },
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
# ■ SpriteHUD_Bar
#==============================================================================
class SpriteHUD_Bar < Sprite
  
  #--------------------------------------------------------------------------
  # alias method: refresh_type1
  #--------------------------------------------------------------------------
  alias battle_luna_cirbar_refresh_type1 refresh_type1
  def refresh_type1
    if setting_circular[:enable][@symbol]
      refresh_circular
    else
      battle_luna_cirbar_refresh_type1
    end
  end
  
  #--------------------------------------------------------------------------
  # new method: refresh_circular
  #--------------------------------------------------------------------------
  def refresh_circular
    self.bitmap = Cache.system(setting_type[:filename]).clone if self.bitmap.nil?
    self.bitmap.clear
    #---
    bitmap = Cache.system(setting_type[:filename])
    clockwise    = setting_circular[:style][@symbol][:clockwise]
    start_angle  = setting_circular[:style][@symbol][:angle][0]
    total_angle  = setting_circular[:style][@symbol][:angle][1].abs
    fill_angle   = (total_angle * @rate).to_i
    fill_angle   = clockwise ? -fill_angle : fill_angle
    #---
    return if fill_angle.abs <= 0
    x = self.bitmap.width / 2; y = self.bitmap.height / 2
    radius = [self.bitmap.width / 2, self.bitmap.height / 2].max
    circular_region = CircularRegion.new(x, y, radius)
    pie_region      = PieRegion.new(circular_region, start_angle, fill_angle)
    self.bitmap.clip_blt(0, 0, bitmap, bitmap.rect, pie_region)
  end
  
  #--------------------------------------------------------------------------
  # setting_circular
  #--------------------------------------------------------------------------
  def setting_circular
    BattleLuna::Addon::CIRCULAR_BARS
  end
  
end # SpriteHUD_Bar