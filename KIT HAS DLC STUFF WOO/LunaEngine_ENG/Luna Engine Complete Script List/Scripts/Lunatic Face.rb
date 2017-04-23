#==============================================================================
# ■ BattleLuna: Lunatic Face
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This script allows you to set conditions so the actor's faceset can change.
# For example, if an actor is damaged, their faceset will change to hurt!
#==============================================================================
$imported = {} if $imported.nil?
$imported["YEL-BattleLuna-LunaticFace"] = true

module BattleLuna
  module Addon
    LUNATIC_FACE  = {
		# -----------------------------------------------------------------
    # If the Face graphic can't be found, the system will search for the
		# default face. You must use notetags for both damaged and 
    # lunatic mode for the default faceset.
    # -----------------------------------------------------------------
      
      # Notetag: <damaged face: Faceset, Index>
      :damaged    =>  {
        :suffix   =>  "_damaged",
        :wait     =>  24,
      },
      
      # The higher the ID, the higher the priority
      # Suffix is used for Face Type 1/2, [Faceset, Index] is use for Face type 0
      
      :lunatic    =>  {
      # ID  =>  [Condition, Suffix, [Faceset, Index]]
        0   =>  ["actor.hp_rate >= 0.5", ""],
        1   =>  ["actor.hp_rate < 0.5" , "_weak"],
        2   =>  ["actor.state?(29)", "_Happy", ["Actor1_Happy [AF 7-15 LOOP]", 0]],
        3   =>  ["actor.dead?", "_death"],
      },
    }
  end # Addon
end # BattleLuna

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
  # new method: damaged_face
  #--------------------------------------------------------------------------
  def damaged_face
    self.note.split(/[\r\n]+/).each { |line|
      if line =~ /<damaged face:[ ]*(.*)>/i
        str_scan = $1.scan(/[^,]+/i)
        return [str_scan[0], str_scan[1].to_i]
      end
    }
    return false
  end
  
end # RPG::BaseItem

#==============================================================================
# ■ Game_Actor
#==============================================================================

class Game_Actor < Game_Battler
  
  #--------------------------------------------------------------------------
  # alias method: item_apply
  #--------------------------------------------------------------------------
  alias battle_luna_lunaticface_item_apply item_apply
  def item_apply(user, item)
    battle_luna_lunaticface_item_apply(user, item)
    return unless @battle_hud
    start_face_damage
  end
  
  #--------------------------------------------------------------------------
  # new method: start_face_damage
  #--------------------------------------------------------------------------
  def start_face_damage
    damage = [@result.hp_damage, @result.mp_damage, @result.tp_damage].max
    @battle_hud.start_face_damage if damage > 0  
  end
  
end # Game_Actor

#==============================================================================
# ■ Spriteset_HUD
#==============================================================================

class Spriteset_HUD
  
  #--------------------------------------------------------------------------
  # new method: start_face_damage
  #--------------------------------------------------------------------------
  def start_face_damage
    @face_damage = true
    @face_damage_wait = BattleLuna::Addon::LUNATIC_FACE[:damaged][:wait]
  end
  
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias battle_luna_lunaticface_update update
  def update
    battle_luna_lunaticface_update
    update_face_damage
  end
  
  #--------------------------------------------------------------------------
  # new method: update_face_damage
  #--------------------------------------------------------------------------
  def update_face_damage
    @face_damage_wait ||= 0
    @face_damage_wait -= 1
    @face_damage = false if @face_damage_wait <= 0
  end
  
  #--------------------------------------------------------------------------
  # new method: face_damage?
  #--------------------------------------------------------------------------
  def face_damage?
    @face_damage
  end
  
end # Spriteset_HUD

#==============================================================================
# ■ SpriteHUD_Face
#==============================================================================

class SpriteHUD_Face < Sprite_Base
  
  #--------------------------------------------------------------------------
  # alias method: faceset_name
  #--------------------------------------------------------------------------
  alias battle_luna_lunaticface_faceset_name faceset_name
  def faceset_name
    result = battle_luna_lunaticface_faceset_name
    if @spriteset.face_damage?
      result = @battler.actor.damaged_face if @battler.actor.damaged_face
    else
      actor = @battler
      hash = BattleLuna::Addon::LUNATIC_FACE[:lunatic]
      hash.each { |key, value|
        result = value[2] if value[2] && eval(value[0])
      }
    end
    result
  end
  
  #--------------------------------------------------------------------------
  # alias method: real_name
  #--------------------------------------------------------------------------
  alias battle_luna_lunaticface_real_name real_name
  def real_name
    result = battle_luna_lunaticface_real_name
    if @spriteset.face_damage?
      cache = result + BattleLuna::Addon::LUNATIC_FACE[:damaged][:suffix]
      begin
        bitmap = Cache.face(cache)
        result = cache
      rescue
        puts "Battle Luna - Lunatic Face: Cannot find \"Graphics/Faces/#{cache}\""
      end
    else
      actor = @battler
      hash = BattleLuna::Addon::LUNATIC_FACE[:lunatic]
      hash.each { |key, value|
        cache = result + value[1]
        begin
          bitmap = Cache.face(cache)
          result = cache if eval(value[0])
        rescue
          if eval(value[0])
            puts "Battle Luna - Lunatic Face: Cannot find \"Graphics/Faces/#{cache}\""
          end
        end
      }
    end
    result
  end
  
end # SpriteHUD_Face