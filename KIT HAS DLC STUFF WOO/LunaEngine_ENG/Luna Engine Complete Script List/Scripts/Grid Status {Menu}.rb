#==============================================================================
# ■ MenuLuna: Grid Status Add-On
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Allows you to make a grid-like UI for Main Menu Luna.
# Based on Etrian Odyssey or classic dungeon crawler games.
#==============================================================================
module MenuLuna
  module Addon
    module MainMenu
      # Setting for Main Menu
      GRID_STATUS = {
        :column     =>  2,
        :row        =>  2,
        :bottom     =>  false,   # Fill bottom to top
        :right      =>  true,    # Fill right to left
        :col_first  =>  true,    # Fill by column
      }
    end
    module ItemMenu
      # Setting for Item Menu
      GRID_STATUS = {
        :column     =>  2,
        :row        =>  2,
        :bottom     =>  false,   # Fill bottom to top
        :right      =>  true,    # Fill right to left
        :col_first  =>  true,    # Fill by column
      }
    end
    module SkillMenu
      # Setting for Skill Menu
      GRID_STATUS = {
        :column     =>  2,
        :row        =>  2,
        :bottom     =>  false,   # Fill bottom to top
        :right      =>  true,    # Fill right to left
        :col_first  =>  true,    # Fill by column
      }
    end
  end
end

#==============================================================================
# ▼ Editting anything past this point may potentially result in causing
# computer damage, incontinence, explosion of user's head, coma, death, and/or
# halitosis so edit at your own risk.
#==============================================================================
#==============================================================================
# ■ Spriteset_MenuStatus
#==============================================================================

class Spriteset_MenuStatus
  
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
    case @setting
    when :mainmenu
      MenuLuna::Addon::MainMenu::GRID_STATUS
    when :itemmenu
      MenuLuna::Addon::ItemMenu::GRID_STATUS
    when :skillmenu
      MenuLuna::Addon::SkillMenu::GRID_STATUS
    else
      MenuLuna::Addon::MainMenu::GRID_STATUS
    end
  end
  
end # Spriteset_MenuStatus

#==============================================================================
# ■ Window_MenuStatus
#==============================================================================

class Window_MenuStatus < Window_Selectable
  
  #--------------------------------------------------------------------------
  # new method: grid_setting
  #--------------------------------------------------------------------------
  def grid_setting
    case self.class.name
    when "Window_MenuStatusLuna"
      MenuLuna::Addon::MainMenu::GRID_STATUS
    when "Window_ItemMenuActor"
      MenuLuna::Addon::ItemMenu::GRID_STATUS
    when "Window_SkillMenuActor"
      MenuLuna::Addon::SkillMenu::GRID_STATUS
    else
      MenuLuna::Addon::MainMenu::GRID_STATUS
    end
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
    
end # Window_MenuStatus

#==============================================================================
# ■ Window_MenuStatusLuna
#==============================================================================

class Window_MenuStatusLuna < Window_MenuStatus
  
  #--------------------------------------------------------------------------
  # overwrite method: col_max
  #--------------------------------------------------------------------------
  if !MenuLuna::MainMenu::BATTLER_STATUS[:lunatic]
  def col_max
    if grid_setting[:col_first]
      result = item_max / grid_setting[:row]
      result += 1 if item_max % grid_setting[:row] > 0
    else
      result = grid_setting[:column]
    end
    result
  end
  end
  
end # Window_MenuStatusLuna

#==============================================================================
# ■ Window_ItemMenuActor
#==============================================================================

class Window_ItemMenuActor < Window_MenuActor
  
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
  
end # Window_ItemMenuActor

#==============================================================================
# ■ Window_SkillMenuActor
#==============================================================================

class Window_SkillMenuActor < Window_MenuActor
  
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
  
end # Window_SkillMenuActor