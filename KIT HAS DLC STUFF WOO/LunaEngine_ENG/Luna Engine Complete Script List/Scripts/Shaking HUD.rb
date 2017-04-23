#==============================================================================
# ■ BattleLuna: Shaking Actor HUD
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This makes your Actor Display in battle to shake whenever they are inflicted
# with: Damage/State/State Damages (Degen) such as poison, etc...
#==============================================================================
$imported = {} if $imported.nil?
$imported["YEL-BattleLuna-ShakingHUD"] = true

module BattleLuna
  module Addon
    SHAKING_HUD = {
      :enable   =>  {
        # Can use notetag to enable for certain skills/state if these options
        # set to false.
        :damage =>  true,	# Ordinary damage to either HP/MP.
        :state  =>  true, # Any state will cause the actor to shake.
        :degen  =>  true, # Damage caused by Poison, etc...
      },
      
      :shake    =>  {
        :power  =>  1,		# How Strong?
        :speed  =>  20,		# How Fast?
        :dur    =>  30,		# How Long?
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
# ■ RPG::BaseItem
#==============================================================================

class RPG::BaseItem
  
  #--------------------------------------------------------------------------
  # new method: hud_shake?
  #--------------------------------------------------------------------------
  def hud_shake?
    self.note.split(/[\r\n]+/).each { |line|
      return true if line =~ /<hud shake>/i
    }
    return false
  end
  
  #--------------------------------------------------------------------------
  # new method: hud_shake_speed
  #--------------------------------------------------------------------------
  def hud_shake_speed
    self.note.split(/[\r\n]+/).each { |line|
      if line =~ /<hud shake speed:[ ]*(\d+)>/i
        return $1.to_i
      end
    }
    return BattleLuna::Addon::SHAKING_HUD[:shake][:speed]
  end
  
  #--------------------------------------------------------------------------
  # new method: hud_shake_power
  #--------------------------------------------------------------------------
  def hud_shake_power
    self.note.split(/[\r\n]+/).each { |line|
      if line =~ /<hud shake power:[ ]*(\d+)>/i
        return $1.to_i
      end
    }
    return BattleLuna::Addon::SHAKING_HUD[:shake][:power]
  end
  
  #--------------------------------------------------------------------------
  # new method: hud_shake_duration
  #--------------------------------------------------------------------------
  def hud_shake_duration
    self.note.split(/[\r\n]+/).each { |line|
      if line =~ /<hud shake duration:[ ]*(\d+)>/i
        return $1.to_i
      end
    }
    return BattleLuna::Addon::SHAKING_HUD[:shake][:dur]
  end
  
end # RPG::BaseItem

#==============================================================================
# ■ Spriteset_HUD
#==============================================================================

class Spriteset_HUD
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  alias battle_luna_shakehud_initialize initialize
  def initialize(viewport, battler)
    battle_luna_shakehud_initialize(viewport, battler)
    init_shake
  end
  
  #--------------------------------------------------------------------------
  # new method: init_shake
  #--------------------------------------------------------------------------
  def init_shake
    @shake_power = 0
    @shake_speed = 0
    @shake_duration = 0
    @shake = 0
    @shake_direction = 1
  end
  
  #--------------------------------------------------------------------------
  # new method: start_shake
  #--------------------------------------------------------------------------
  def start_shake(speed, power, duration)
    @shake_power = power
    @shake_speed = speed
    @shake_duration = duration
    @shake = 0
    @shake_direction = 1
  end
  
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias battle_luna_shakehud_update update
  def update
    battle_luna_shakehud_update
    update_shake
  end
  
  #--------------------------------------------------------------------------
  # new method: update_shake
  #--------------------------------------------------------------------------
  def update_shake
    if @shake_duration > 0 || @shake != 0
      delta = (@shake_power * @shake_speed * @shake_direction) / 10.0
      delta = [delta.abs, @shake_power * 2].min
      delta = delta * @shake_direction
      if @shake_duration <= 1 && @shake * (@shake + delta) < 0
        @shake = 0
      else
        @shake += delta
      end
      @shake_direction = -1 if @shake > @shake_power * 2
      @shake_direction = 1 if @shake < - @shake_power * 2
      @shake_duration -= 1
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: screen_x
  #--------------------------------------------------------------------------
  alias battle_luna_shakehud_screen_x screen_x
  def screen_x
    battle_luna_shakehud_screen_x + @shake
  end
  
end # Spriteset_HUD

#==============================================================================
# ■ Game_Actor
#==============================================================================

class Game_Actor < Game_Battler
  
  #--------------------------------------------------------------------------
  # alias method: item_apply
  #--------------------------------------------------------------------------
  alias battle_luna_shakehud_item_apply item_apply
  def item_apply(user, item)
    battle_luna_shakehud_item_apply(user, item)
    return unless @battle_hud
    start_hud_shake(item)
  end
  
  #--------------------------------------------------------------------------
  # alias method: add_new_state
  #--------------------------------------------------------------------------
  alias battle_luna_shakehud_add_new_state add_new_state
  def add_new_state(state_id)
    battle_luna_shakehud_add_new_state(state_id)
    return unless @battle_hud
    start_hud_shake_state(state_id)
  end
  
  #--------------------------------------------------------------------------
  # new method: start_hud_shake
  #--------------------------------------------------------------------------
  def start_hud_shake(item)
    damage = [@result.hp_damage, @result.mp_damage, @result.tp_damage].max
    enable = BattleLuna::Addon::SHAKING_HUD[:enable][:damage]
    if (damage > 0 && enable) || item.hud_shake?
      power = item.hud_shake_power
      speed = item.hud_shake_speed
      duration = item.hud_shake_duration
      @battle_hud.start_shake(speed, power, duration)
    end    
  end
  
  #--------------------------------------------------------------------------
  # new method: start_hud_shake_state
  #--------------------------------------------------------------------------
  def start_hud_shake_state(state_id)
    state = $data_states[state_id]
    enable = BattleLuna::Addon::SHAKING_HUD[:enable][:state]
    return unless state
    if enable || state.hud_shake?
      power = state.hud_shake_power
      speed = state.hud_shake_speed
      duration = state.hud_shake_duration
      @battle_hud.start_shake(speed, power, duration)
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: regenerate_all
  #--------------------------------------------------------------------------
  alias battle_luna_shakehud_regenerate_all regenerate_all
  def regenerate_all
    battle_luna_shakehud_regenerate_all
    return unless @battle_hud
    start_hud_shake_regen
  end
  
  #--------------------------------------------------------------------------
  # new method: start_hud_shake_regen
  #--------------------------------------------------------------------------
  def start_hud_shake_regen
    enable = BattleLuna::Addon::SHAKING_HUD[:enable][:degen]
    if enable && (@result.hp_damage > 0 || @result.mp_damage > 0)
      power = BattleLuna::Addon::SHAKING_HUD[:shake][:power]
      speed = BattleLuna::Addon::SHAKING_HUD[:shake][:speed]
      duration = BattleLuna::Addon::SHAKING_HUD[:shake][:dur]
      @battle_hud.start_shake(speed, power, duration)
    end
  end
  
end # Game_Actor