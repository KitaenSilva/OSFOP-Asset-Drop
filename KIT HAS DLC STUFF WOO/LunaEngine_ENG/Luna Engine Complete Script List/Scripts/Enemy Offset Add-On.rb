#==============================================================================
# ■ BattleLuna: Enemy Offset Add-On
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This script allows you to add an offset to enemy positions if your screen
# resolution is bigger than 544x416 and/or if you can't move the battler's
# position properly in the database editor.
# 
# Do not use if you're using Theo Allen's SBS.
# Might cause issues with systems that uses a 'camera' inside battle.
#==============================================================================
# ■ Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Notetags Guide:
#    Put them inside Enemy Notes. 
#
# 1, <pos offset y: num>
#    num = number. This adds an offset to move the enemy display up/down.
# 2, <pos offset x: num>
#    num = number. This adds an offset to move the enemy display left/right.
#
#==============================================================================
#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================

module BattleLuna
  module REGEXP
    ENEMY_OFFSET_X = /<(?:POS_OFFSET_X|pos offset x):[ ]*([\-]?\d+)>/i
    ENEMY_OFFSET_Y = /<(?:POS_OFFSET_Y|pos offset y):[ ]*([\-]?\d+)>/i
  end
end

module DataManager
  
  class <<self; alias load_database_blepo load_database; end
  def self.load_database
    load_database_blepo
    load_notetags_blepo
  end
  
  def self.load_notetags_blepo
    $data_enemies.each { |obj|
      next if obj.nil?
      obj.load_notetags_blepo
    }
  end
  
end

class RPG::BaseItem
  
  attr_accessor :pos_offset_x
  attr_accessor :pos_offset_y

  def load_notetags_blepo
    @pos_offset_x = 0
    @pos_offset_y = 0
    self.note.split(/[\r\n]+/).each { |line|
      case line
      when BattleLuna::REGEXP::ENEMY_OFFSET_X
        @pos_offset_x = $1.to_i
      when BattleLuna::REGEXP::ENEMY_OFFSET_Y
        @pos_offset_y = $1.to_i
      end
    }
  end
  
end

class Game_Enemy < Game_Battler
  
  def screen_x
    @screen_x + self.enemy.pos_offset_x
  end
  
  def screen_y
    @screen_y + self.enemy.pos_offset_y
  end
  
end