#==============================================================================
# ■ MenuLuna: Quest Menu Core
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This is a custom quest menu made for Luna Engine users!
# This uses items as a way to indicate if the player has a new or finished  
# quest. Based on Subterranean Starfield by rhyme and Archeia_Nessiah.
#==============================================================================
#==============================================================================
# ■ Quest Menu Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Item Notetags. Look at the database editor for more information.
#
# <quest>
# Sets an item as a quest.
#
# <quest clear switch: X>
# Sets a clear switch for a quest.
#
# <quest description>
# text
# text
# </quest description>
# Sets quest description. !break for linebreak.
#
# clear X, Y: text
# Sets quest conditions. You can use as many as you want.
# X is complete switch, Y is show switch. If switch Y set to true, the text
# will be shown. If Y is omitted (clear X: text), the text will always be shown.
#
# <quest condition>
# clear X, Y: text
# reward: text
# clear term: text
# reward term: text
# </quest condition>
#
#////////////////////////////////////_NOTE_/////////////////////////////////////
# - Text in description and condition can use some message codes such as, but
# not limited to, color, variable, and, icon display.
# - Using multiple quest conditions notetag means the quest has many sub-quests.
# - In quest condition, can use multiple clear X: text and reward: text to
#   make a list of clearance and rewards for sub-quest.
# - Use !break in description, clear and reward for break line.
#////////////////////////////////////_FIN_/////////////////////////////////////
#
# Example notetag based on item #21 in Luna Engine Base:
#
# <quest>
# <quest clear switch: 5>
# <quest description>
# \C[10]Type: \C[0]\I[143]Main Quest!break
# \C[10]Location: \C[0]Dr.Yami's Home!break
# !break\C[0]
# Bessy ordered you to test the Luna 
# !breakQuest and report her if there is
# !breakany problem occurs.
# </quest description>
# <quest condition>
# clear 6: Get the script and read manual.
# clear 7: Try to create your own quest.
# clear 8: Report to Bessy.
# reward: \I[122]A hugz.
# </quest condition>
#
#==============================================================================
$imported = {} if $imported.nil?
$imported["YEL-QuestMenu"] = true

#==============================================================================
# ■ LunaEngine::QuestMenu
#==============================================================================

module LunaEngine
  module QuestMenu
    
    # Vocab for Quest Menu
    TERMS = {
      # For menu command
      :quest_command => "Quests",
    
      # For quest list filter by all, ongoing and finished
      :all       => "All Quest(s)",
      :ongoing   => "Ongoing Quest(s)",
      :finished  => "Finished Quest(s)",
      
      # Description terms by default, can be changed by notetag
      :condition => "Conditions",
      :clear     => "Clear:",
      :reward    => "Reward:",
      
      # Cleared term, can use some message code, like color and icon
      # must have %s in term to show their name or condition.
      :cleared_condition => "\\C[3]%s",
      :cleared_quest     => "\\C[3]%s\\I[125]",
    } # QuestMenu::TERMS
    
    # Regular Expression, do not touch this unless you know what it is
    REGEXP = {
      :quest             => /<quest>/i,
      :quest_clear       => /<quest clear switch:[ ]*(\d+)>/i,
      :start_description => /<quest description>/i,
      :end_description   => /<\/quest description>/i,
      :start_condition   => /<quest condition>/i,
      :end_condition     => /<\/quest condition>/i,
      :clear_condition   => /clear (\d+):[ ]*(.*)/i,
      :clear_condition2  => /clear (\d+),[ ]*(\d+):[ ]*(.*)/i,
      :reward_condition  => /reward:[ ]*(.*)/i,
      :clear_term        => /clear term:[ ]*(.*)/i,
      :reward_term       => /reward term:[ ]*(.*)/i,
      :break_line        => /!break/i,
    }
    
  end # QuestMenu
end # LunaEngine
#==============================================================================
# ▼ Editting anything past this point may potentially result in causing
# computer damage, incontinence, explosion of user's head, coma, death, and/or
# halitosis so edit at your own risk.
#==============================================================================
#==============================================================================
# ■ DataManager
#==============================================================================

module DataManager
  
  #--------------------------------------------------------------------------
  # alias method: load_database
  # Load and parse notetags
  #--------------------------------------------------------------------------
  class <<self; alias load_database_lunaquest load_database; end
  def self.load_database
    load_database_lunaquest
    load_notetags_lunaquest
  end
  
  #--------------------------------------------------------------------------
  # new method: load_notetags_lunaquest
  # Load and parse notetags for quests
  #--------------------------------------------------------------------------
  def self.load_notetags_lunaquest
    $data_items.each { |obj|
      next if obj.nil?
      obj.load_notetags_lunaquest
    }
  end
  
end # DataManager

#==============================================================================
# ■ RPG::BaseItem
#==============================================================================

class RPG::BaseItem

  #--------------------------------------------------------------------------
  # new method: load_notetags_lunaquest
  # Load and parse notetags for quests
  #--------------------------------------------------------------------------
  def load_notetags_lunaquest
    @quest = false
    @quest_description  = ""
    @quest_conditions   = []
    @quest_clear_switch = 0
    #--- local variable for parsing ---
    on_description = false
    on_condition   = false
    condition      = {}
    #---
    self.note.split(/[\r\n]+/).each { |line|
      case line
      when LunaEngine::QuestMenu::REGEXP[:quest]
        @quest = true
      when LunaEngine::QuestMenu::REGEXP[:quest_clear]
        @quest_clear_switch = $1.to_i
      when LunaEngine::QuestMenu::REGEXP[:start_description]
        on_description = true
      when LunaEngine::QuestMenu::REGEXP[:end_description]
        on_description = false
      when LunaEngine::QuestMenu::REGEXP[:start_condition]
        on_condition       = true
        condition          = {}
        condition[:clear]  = []
        condition[:reward] = []
        condition[:clear_term]  = LunaEngine::QuestMenu::TERMS[:clear]
        condition[:reward_term] = LunaEngine::QuestMenu::TERMS[:reward]
      when LunaEngine::QuestMenu::REGEXP[:end_condition]
        on_condition = false
        @quest_conditions.push(condition)
      else
        # for description
        if on_description
          @quest_description += line
        end
        
        # for condition
        if on_condition
          case line
          when LunaEngine::QuestMenu::REGEXP[:clear_term]
            condition[:clear_term] = $1
          when LunaEngine::QuestMenu::REGEXP[:reward_term]
            condition[:reward_term] = $1
          when LunaEngine::QuestMenu::REGEXP[:clear_condition2]
            clear = {}
            clear[:switch] = $1.to_i
            clear[:text]   = break_multiline($3)
            clear[:show]   = $2.to_i
            condition[:clear].push(clear)
          when LunaEngine::QuestMenu::REGEXP[:clear_condition]
            clear = {}
            clear[:switch] = $1.to_i
            clear[:text]   = break_multiline($2)
            condition[:clear].push(clear)
          when LunaEngine::QuestMenu::REGEXP[:reward_condition]
            condition[:reward].push(break_multiline($1))
          end
        end
      end
    }
    #---
    @quest_description.gsub!(/!break/i) { "\n" }
  end
  
  #--------------------------------------------------------------------------
  # new method: is_quest?
  #--------------------------------------------------------------------------
  def is_quest?
    @quest
  end
  
  #--------------------------------------------------------------------------
  # new method: quest_finished?
  #--------------------------------------------------------------------------
  def quest_finished?
    $game_switches[@quest_clear_switch]
  end
  
  #--------------------------------------------------------------------------
  # new method: quest_description
  #--------------------------------------------------------------------------
  def quest_description
    @quest_description
  end
  
  #--------------------------------------------------------------------------
  # new method: quest_conditions
  #--------------------------------------------------------------------------
  def quest_conditions
    @quest_conditions
  end
  
  #--------------------------------------------------------------------------
  # new method: quest_description_lines
  #--------------------------------------------------------------------------
  def quest_description_lines
    quest_description.lines.count
  end
  
  #--------------------------------------------------------------------------
  # new method: break_multiline
  #--------------------------------------------------------------------------
  def break_multiline(text)
    text.split(/!break/i)
  end
  
  #--------------------------------------------------------------------------
  # new method: break_multiline
  #--------------------------------------------------------------------------
  def quest_clear_line
    
  end
  
end # RPG::BaseItem

#==============================================================================
# ■ Window_ItemList
#==============================================================================

class Window_ItemList < Window_Selectable
  
  #--------------------------------------------------------------------------
  # include?
  #--------------------------------------------------------------------------
  alias luna_quest_include? include?
  def include?(item)
    item && item.is_quest? ? false : luna_quest_include?(item)
  end
  
end # Window_ItemList

#==============================================================================
# ■ Window_ItemListLuna
#==============================================================================

class Window_ItemListLuna < Window_ItemList
  
  #--------------------------------------------------------------------------
  # include?
  #--------------------------------------------------------------------------
  alias luna_quest_include? include?
  def include?(item)
    item && item.is_quest? ? false : luna_quest_include?(item)
  end
  
end # Window_ItemListLuna

#==============================================================================
# ■ Window_ItemListShop
#==============================================================================

class Window_ItemListShop < Window_ShopSell
  
  #--------------------------------------------------------------------------
  # include?
  #--------------------------------------------------------------------------
  alias luna_quest_include? include?
  def include?(item)
    item && item.is_quest? ? false : luna_quest_include?(item)
  end
  
end # Window_ItemListShop

#==============================================================================
# ■ Window_MenuCommand
#==============================================================================

class Window_MenuCommand < Window_Command
  
  #--------------------------------------------------------------------------
  # add_main_commands
  #--------------------------------------------------------------------------
  alias luna_quest_add_main_commands add_main_commands
  def add_main_commands
    luna_quest_add_main_commands
    return if $imported["YEA-AceMenuEngine"]
    add_quest_command
  end
  
  #--------------------------------------------------------------------------
  # add_quest_command
  #--------------------------------------------------------------------------
  def add_quest_command
    add_command(LunaEngine::QuestMenu::TERMS[:quest_command], :quest)
  end
  
end # Window_MenuCommand

#==============================================================================
# ■ Scene_Menu
#==============================================================================

class Scene_Menu < Scene_MenuBase
  
  #--------------------------------------------------------------------------
  # alias method: create_command_window
  #--------------------------------------------------------------------------
  alias luna_quest_create_command_window create_command_window
  def create_command_window
    luna_quest_create_command_window
    @command_window.set_handler(:quest, method(:command_quest))
  end
  
  #--------------------------------------------------------------------------
  # new method: command_quest
  #--------------------------------------------------------------------------
  def command_quest
    SceneManager.call(Scene_Quest)
  end
  
end # Scene_Menu

#==============================================================================
# ■ Window_QuestHelp
#==============================================================================

class Window_QuestHelp < Window_Help
end # Window_QuestHelp

#==============================================================================
# ■ Window_QuestCategory
#==============================================================================

class Window_QuestCategory < Window_HorzCommand
  
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_reader :item_window
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0)
  end
  
  #--------------------------------------------------------------------------
  # window_width
  #--------------------------------------------------------------------------
  def window_width
    Graphics.width
  end
  
  #--------------------------------------------------------------------------
  # col_max
  #--------------------------------------------------------------------------
  def col_max
    return 3
  end
  
  #--------------------------------------------------------------------------
  # update
  #--------------------------------------------------------------------------
  def update
    super
    @item_window.category = current_symbol if @item_window
  end
  
  #--------------------------------------------------------------------------
  # make_command_list
  #--------------------------------------------------------------------------
  def make_command_list
    add_command(LunaEngine::QuestMenu::TERMS[:all],      :all)
    add_command(LunaEngine::QuestMenu::TERMS[:ongoing],  :ongoing)
    add_command(LunaEngine::QuestMenu::TERMS[:finished], :finished)
  end
  
  #--------------------------------------------------------------------------
  # item_window
  #--------------------------------------------------------------------------
  def item_window=(item_window)
    @item_window = item_window
    update
  end
  
end # Window_QuestCategory

#==============================================================================
# ■ Window_QuestList
#==============================================================================

class Window_QuestList < Window_Selectable
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0, window_width, window_height)
    @category = :none
    @data = []
  end
  
  #--------------------------------------------------------------------------
  # window_width
  #--------------------------------------------------------------------------
  def window_width
    240
  end
  
  #--------------------------------------------------------------------------
  # window_height
  #--------------------------------------------------------------------------
  def window_height
    Graphics.height - 120
  end
  
  #--------------------------------------------------------------------------
  # category=
  #--------------------------------------------------------------------------
  def category=(category)
    return if @category == category
    @category = category
    refresh
    self.oy = 0
  end
  
  #--------------------------------------------------------------------------
  # col_max
  #--------------------------------------------------------------------------
  def col_max
    return 1
  end
  
  #--------------------------------------------------------------------------
  # item_max
  #--------------------------------------------------------------------------
  def item_max
    @data ? @data.size : 1
  end
  
  #--------------------------------------------------------------------------
  # item
  #--------------------------------------------------------------------------
  def item
    @data && index >= 0 ? @data[index] : nil
  end
  
  #--------------------------------------------------------------------------
  # current_item_enabled?
  #--------------------------------------------------------------------------
  def current_item_enabled?
    enable?(@data[index])
  end
  
  #--------------------------------------------------------------------------
  # include?
  #--------------------------------------------------------------------------
  def include?(item)
    return true if item.nil?
    result = item.is_quest?
    case @category
    when :all
      result = result
    when :ongoing
      result = result && !item.quest_finished?
    when :finished
      result = result && item.quest_finished?
    end
    result
  end
  
  #--------------------------------------------------------------------------
  # enable?
  #--------------------------------------------------------------------------
  def enable?(item)
    !item.nil?
  end
  
  #--------------------------------------------------------------------------
  # make_item_list
  #--------------------------------------------------------------------------
  def make_item_list
    @data = $game_party.all_items.select { |item| include?(item) }
    @data.push(nil) if @data.size == 0
  end

  #--------------------------------------------------------------------------
  # draw_item
  #--------------------------------------------------------------------------
  def draw_item(index)
    item = @data[index]
    if item
      rect = item_rect(index)
      rect.width -= 4
      text = 
      draw_item_name(item, rect.x, rect.y, true)
    end
  end
  
  #--------------------------------------------------------------------------
  # draw_item_name
  #--------------------------------------------------------------------------
  def draw_item_name(item, x, y, enabled = true)
    return unless item
    draw_icon(item.icon_index, x, y, enabled)
    if item.quest_finished?
      text = sprintf(LunaEngine::QuestMenu::TERMS[:cleared_quest], item.name)
    else
      text = item.name
    end
    draw_text_ex(x + 24, y, text)
  end

  #--------------------------------------------------------------------------
  # update_help
  #--------------------------------------------------------------------------
  def update_help
    @help_window.set_item(item) if @help_window
    @contents_window.set_item(item) if @contents_window
  end
  
  #--------------------------------------------------------------------------
  # refresh
  #--------------------------------------------------------------------------
  def refresh
    make_item_list
    create_contents
    draw_all_items
  end
  
  #--------------------------------------------------------------------------
  # contents_window
  #--------------------------------------------------------------------------
  def contents_window=(contents_window)
    @contents_window = contents_window
    call_update_help
  end
  
end # Window_QuestList

#==============================================================================
# ■ Window_QuestContents
#==============================================================================

class Window_QuestContents < Window_Base
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize
    super(0, 0, window_width, window_height)
    @item = nil
    @cancel_handler = nil
    self.deactivate
  end
  
  #--------------------------------------------------------------------------
  # window_width
  #--------------------------------------------------------------------------
  def window_width
    Graphics.width - 240
  end
  
  #--------------------------------------------------------------------------
  # window_height
  #--------------------------------------------------------------------------
  def window_height
    Graphics.height - 120
  end
  
  #--------------------------------------------------------------------------
  # item
  #--------------------------------------------------------------------------
  def item
    @item
  end
  
  #--------------------------------------------------------------------------
  # set_item
  #--------------------------------------------------------------------------
  def set_item(item)
    return if item == @item
    @item = item
    refresh
  end
  
  #--------------------------------------------------------------------------
  # contents_height
  #--------------------------------------------------------------------------
  def contents_height
    return viewport_height unless item
    result = line_height * 2
    result += item.quest_description_lines * line_height
    if item.quest_conditions.size > 0
      result += line_height * 2
      item.quest_conditions.each do |condition|
        condition[:clear].each do |clear|
          next if clear[:show] && !$game_switches[clear[:show]]
          result += line_height * clear[:text].size
        end
        condition[:reward].each do |reward|
          result += line_height * reward.size
        end
        result += line_height
      end
    end
    return [result, viewport_height].max
  end
  
  #--------------------------------------------------------------------------
  # viewport_height
  #--------------------------------------------------------------------------
  def viewport_height
    height - standard_padding * 2
  end
  
  #--------------------------------------------------------------------------
  # refresh
  #--------------------------------------------------------------------------
  def refresh
    self.oy = 0
    create_contents
    draw_contents
  end
  
  #--------------------------------------------------------------------------
  # draw_contents
  #--------------------------------------------------------------------------
  def draw_contents
    return unless @item
    draw_header
    draw_description
    draw_conditions
  end
  
  #--------------------------------------------------------------------------
  # draw_header
  #--------------------------------------------------------------------------
  def draw_header
    change_color(system_color)
    text = item.name
    draw_text(0, 0, contents.width, line_height, text, 1)
    contents.fill_rect(0, line_height * 3 / 2, contents_width, 2, line_color)
  end
  
  #--------------------------------------------------------------------------
  # draw_description
  #--------------------------------------------------------------------------
  def draw_description
    draw_text_ex(0, line_height * 2, item.quest_description)
  end
  
  #--------------------------------------------------------------------------
  # draw_conditions
  #--------------------------------------------------------------------------
  def draw_conditions
    return unless item.quest_conditions.size > 0
    y = line_height * 3 + item.quest_description_lines * line_height
    contents.fill_rect(0, y - line_height / 2, contents_width, 2, line_color)
    #---
    change_color(system_color)
    text = LunaEngine::QuestMenu::TERMS[:condition]
    draw_text(0, y, contents.width, line_height, text, 1)
    #---
    y += line_height * 2
    item.quest_conditions.each do |condition|
      contents.fill_rect(0, y - line_height / 2, contents_width, 2, line_color)
      #---
      clear_term  = condition[:clear_term]
      reward_term = condition[:reward_term]
      cleared     = LunaEngine::QuestMenu::TERMS[:cleared_condition]
      #---
      x = [text_size(clear_term).width, text_size(reward_term).width].max
      x += 2
      #---
      condition[:clear].each do |clear|
        next if clear[:show] && !$game_switches[clear[:show]]
        change_color(system_color)
        draw_text(0, y, contents.width, line_height, clear_term, 0)
        if $game_switches[clear[:switch]]
          text = sprintf(cleared, clear[:text].join("\n"))
        else
          text = clear[:text].join("\n")
        end
        draw_text_ex(x, y, text)
        y += line_height * clear[:text].size
      end
      #---
      condition[:reward].each do |reward|
        change_color(system_color)
        draw_text(0, y, contents.width, line_height, reward_term, 0)
        text = reward.join("\n")
        draw_text_ex(x, y, text)
        y += line_height * reward.size
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # line_color
  #--------------------------------------------------------------------------
  def line_color
    color = system_color
    color.alpha = 96
    color
  end
  
  #--------------------------------------------------------------------------
  # update
  #--------------------------------------------------------------------------
  def update
    super
    process_cursor_move
    process_handling
  end
  
  #--------------------------------------------------------------------------
  # process_cursor_move
  #--------------------------------------------------------------------------
  def process_cursor_move
    return unless open? && self.active
    scroll_down if Input.repeat?(:DOWN)
    scroll_up   if Input.repeat?(:UP)
  end
  
  #--------------------------------------------------------------------------
  # process_handling
  #--------------------------------------------------------------------------
  def process_handling
    return unless open? && self.active
    return process_cancel if cancel_enabled? && Input.trigger?(:B)
  end
  
  #--------------------------------------------------------------------------
  # set_cancel
  #--------------------------------------------------------------------------
  def set_cancel(proc)
    @cancel_handler = proc
  end
  
  #--------------------------------------------------------------------------
  # cancel_enabled?
  #--------------------------------------------------------------------------
  def cancel_enabled?
    !@cancel_handler.nil?
  end

  #--------------------------------------------------------------------------
  # process_cancel
  #--------------------------------------------------------------------------
  def process_cancel
    Sound.play_cancel
    Input.update
    deactivate
    call_cancel_handler
  end
  
  #--------------------------------------------------------------------------
  # call_cancel_handler
  #--------------------------------------------------------------------------
  def call_cancel_handler
    @cancel_handler.call
  end
  
  #--------------------------------------------------------------------------
  # scroll_down
  #--------------------------------------------------------------------------
  def scroll_down
    return if self.oy >= contents_height - viewport_height
    self.oy += [line_height, contents_height - (self.oy + viewport_height)].min
  end
  
  #--------------------------------------------------------------------------
  # scroll_up
  #--------------------------------------------------------------------------
  def scroll_up
    return if self.oy <= 0
    self.oy -= [line_height, self.oy].min
  end

end # Window_QuestContents

#==============================================================================
# ■ Scene_Quest
#==============================================================================

class Scene_Quest < Scene_MenuBase
  
  #--------------------------------------------------------------------------
  # start
  #--------------------------------------------------------------------------
  def start
    super
    create_help_window
    create_category_window
    create_item_window
    create_contents_window
  end
  
  #--------------------------------------------------------------------------
  # create_help_window
  #--------------------------------------------------------------------------
  def create_help_window
    @help_window = Window_QuestHelp.new
    @help_window.viewport = @viewport
  end
  
  #--------------------------------------------------------------------------
  # create_category_window
  #--------------------------------------------------------------------------
  def create_category_window
    @category_window = Window_QuestCategory.new
    @category_window.viewport = @viewport
    @category_window.help_window = @help_window
    @category_window.y = @help_window.height
    @category_window.init_position rescue nil
    @category_window.set_handler(:ok,     method(:on_category_ok))
    @category_window.set_handler(:cancel, method(:return_scene))
  end
  
  #--------------------------------------------------------------------------
  # create_item_window
  #--------------------------------------------------------------------------
  def create_item_window
    @item_window = Window_QuestList.new
    @item_window.y = @category_window.y + @category_window.height
    @item_window.viewport = @viewport
    @item_window.help_window = @help_window
    @item_window.init_position rescue nil
    @item_window.set_handler(:ok,     method(:on_item_ok))
    @item_window.set_handler(:cancel, method(:on_item_cancel))
    @category_window.item_window = @item_window
  end
  
  #--------------------------------------------------------------------------
  # create_contents_window
  #--------------------------------------------------------------------------
  def create_contents_window
    @contents_window = Window_QuestContents.new
    @contents_window.x = @item_window.x + @item_window.width
    @contents_window.y = @category_window.y + @category_window.height
    @contents_window.viewport = @viewport
    @contents_window.init_position rescue nil
    @contents_window.set_cancel(method(:on_contents_cancel))
    @item_window.contents_window = @contents_window
  end
  
  #--------------------------------------------------------------------------
  # on_category_ok
  #--------------------------------------------------------------------------
  def on_category_ok
    @item_window.activate
    @item_window.select(0)
    @item_window.oy = 0
  end
  
  #--------------------------------------------------------------------------
  # on_item_ok
  #--------------------------------------------------------------------------
  def on_item_ok
    @contents_window.activate
  end
  
  #--------------------------------------------------------------------------
  # on_item_cancel
  #--------------------------------------------------------------------------
  def on_item_cancel
    @item_window.unselect
    @category_window.activate
  end
  
  #--------------------------------------------------------------------------
  # on_contents_cancel
  #--------------------------------------------------------------------------
  def on_contents_cancel
    @item_window.activate
  end

end # Scene_Quest