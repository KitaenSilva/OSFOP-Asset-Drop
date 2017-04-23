#==============================================================================
# ■ BattleLuna: Grid Status Add-On
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Allows you to make a grid-like UI for Main Menu Luna.
# Based on Etrian Odyssey or classic dungeon crawler games.
#==============================================================================
$imported = {} if $imported.nil?
$imported["YEL-BattleLuna-GridStatus"] = true

module BattleLuna
  module Addon
    GRID_STATUS = {
      :column     =>  3,
      :row        =>  2,
      :bottom     =>  false,    # Fill bottom to top
      :right      =>  false,    # Fill right to left
      :col_first  =>  false,    # Fill by column
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
# ■ Spriteset_HUD
#==============================================================================

class Spriteset_HUD
  
  #--------------------------------------------------------------------------
  # screen_x
  #--------------------------------------------------------------------------
  def screen_x
    result = setting[:x] + eval(setting[:offset_x].to_s)
    if setting[:center] && !grid_setting[:col_first]
      total_battler = $game_party.battle_members.size
      neg           = total_battler - (index / grid_setting[:column]) * grid_setting[:column]
      total_col     = [grid_setting[:column], neg].min
      total_width   = setting[:max_width] / total_col
      result += (total_width - setting[:spacing]) * grid[0]
      result += [(total_width - setting[:width]), 0].max / 2
    else
      result += (setting[:width] + setting[:spacing]) * grid[0]
    end
    result
  end

  #--------------------------------------------------------------------------
  # screen_y
  #--------------------------------------------------------------------------
  def screen_y
    result = setting[:y] + eval(setting[:offset_y].to_s)
    if setting[:center] && grid_setting[:col_first]
      total_battler = $game_party.battle_members.size
      neg           = total_battler - (index / grid_setting[:row]) * grid_setting[:row]
      total_row     = [grid_setting[:row], neg].min
      total_height = setting[:max_height] / total_row
      result += (total_height - setting[:spacing]) * grid[1]
      result += [(total_height - setting[:height]), 0].max / 2
    else
      result += (setting[:height] + setting[:spacing]) * grid[1]
    end
    result
  end
  
  #--------------------------------------------------------------------------
  # new method: grid
  #--------------------------------------------------------------------------
  def grid
    if grid_setting[:col_first]
      x = index / grid_setting[:column]
      x = grid_setting[:right] ? (grid_setting[:column] - x - 1) : x
      y = index % grid_setting[:column]
      y = grid_setting[:bottom] ? (grid_setting[:row] - y - 1) : y
    else
      x = index % grid_setting[:column]
      x = grid_setting[:right] ? (grid_setting[:column] - x - 1) : x
      y = index / grid_setting[:column]
      y = grid_setting[:bottom] ? (grid_setting[:row] - y - 1) : y
    end
    return [x, y]
  end
  
  #--------------------------------------------------------------------------
  # new method: grid_setting
  #--------------------------------------------------------------------------
  def grid_setting
    BattleLuna::Addon::GRID_STATUS
  end
  
end # Spriteset_HUD

#==============================================================================
# ■ Window_BattleStatus
#==============================================================================

class Window_BattleStatus < Window_Selectable
  
  #--------------------------------------------------------------------------
  # new method: grid_setting
  #--------------------------------------------------------------------------
  def grid_setting
    BattleLuna::Addon::GRID_STATUS
  end
  
  #--------------------------------------------------------------------------
  # alias method: cursor_down
  #--------------------------------------------------------------------------
  alias menu_luna_gs_cursor_down cursor_down
  def cursor_down(wrap = true)
    if grid_setting[:col_first]
      grid_setting[:bottom] ? menu_luna_gs_cursor_left : menu_luna_gs_cursor_right
    else
      grid_setting[:bottom] ? menu_luna_gs_cursor_up : menu_luna_gs_cursor_down
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: cursor_up
  #--------------------------------------------------------------------------
  alias menu_luna_gs_cursor_up cursor_up
  def cursor_up(wrap = true)
    if grid_setting[:col_first]
      grid_setting[:bottom] ? menu_luna_gs_cursor_right : menu_luna_gs_cursor_left
    else
      grid_setting[:bottom] ? menu_luna_gs_cursor_down : menu_luna_gs_cursor_up
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: cursor_right
  #--------------------------------------------------------------------------
  alias menu_luna_gs_cursor_right cursor_right
  def cursor_right(wrap = true)
    if grid_setting[:col_first]
      grid_setting[:right] ? menu_luna_gs_cursor_up : menu_luna_gs_cursor_down
    else
      grid_setting[:right] ? menu_luna_gs_cursor_left : menu_luna_gs_cursor_right
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: cursor_left
  #--------------------------------------------------------------------------
  alias menu_luna_gs_cursor_left cursor_left
  def cursor_left(wrap = true)
    if grid_setting[:col_first]
      grid_setting[:right] ? menu_luna_gs_cursor_down : menu_luna_gs_cursor_up
    else
      grid_setting[:right] ? menu_luna_gs_cursor_right : menu_luna_gs_cursor_left
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: col_max
  #--------------------------------------------------------------------------
  def col_max
    if grid_setting[:col_first]
      result = item_max / grid_setting[:row]
      result += 1 if item_max % grid_setting[:row] > 0
    else
      result = grid_setting[:column]
    end
    result
  end
    
end # Window_BattleStatus