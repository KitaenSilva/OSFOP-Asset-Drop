#==============================================================================
# ■ Window_QuestHelp
#==============================================================================
#==============================================================================
# ▼ Editting anything past this point may potentially result in causing
# computer damage, incontinence, explosion of user's head, coma, death, and/or
# halitosis so edit at your own risk.
#==============================================================================
class Window_QuestHelp < Window_Help
  
  #--------------------------------------------------------------------------
  # initialize
  #--------------------------------------------------------------------------
  def initialize
    super(line_number)
    init_position
    update_padding
    create_contents
    refresh_background
    update
  end
  
  #--------------------------------------------------------------------------
  # new method: init_position
  #--------------------------------------------------------------------------
  def init_position
    self.x = screen_x
    self.y = screen_y
    self.z = screen_z
    self.width = window_width
    self.height = window_height
  end
  
  #--------------------------------------------------------------------------
  # window_width
  #--------------------------------------------------------------------------
  def window_width
    [setting[:width], standard_padding * 2 + line_height].max
  end
  
  #--------------------------------------------------------------------------
  # window_height
  #--------------------------------------------------------------------------
  def window_height
    fitting_height(line_number) + setting[:height_buff]
  end
  
  #--------------------------------------------------------------------------
  # setting
  #--------------------------------------------------------------------------
  def setting
    MenuLuna::QuestMenu::WINDOW_HELP
  end
  
  #--------------------------------------------------------------------------
  # line_number
  #--------------------------------------------------------------------------
  def line_number
    setting[:line_number]
  end
  
  #--------------------------------------------------------------------------
  # screen_x
  #--------------------------------------------------------------------------
  def screen_x
    setting[:x]
  end
  
  #--------------------------------------------------------------------------
  # screen_y
  #--------------------------------------------------------------------------
  def screen_y
    setting[:y]
  end
  
  #--------------------------------------------------------------------------
  # screen_z
  #--------------------------------------------------------------------------
  def screen_z
    setting[:z]
  end
  
  #--------------------------------------------------------------------------
  # new method: setting_type
  #--------------------------------------------------------------------------
  def setting_type
    type = setting[:back_type]
    setting[eval(":type_#{type}")]
  end
    
  #--------------------------------------------------------------------------
  # overwrite method: dispose
  #--------------------------------------------------------------------------
  def dispose
    super
    @bg_sprite.dispose if @bg_sprite
  end
  
end # Window_QuestHelp

#==============================================================================
# ■ Window_QuestCategory
#==============================================================================

class Window_QuestCategory < Window_HorzCommand
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  alias luna_quest_custom_initialize initialize
  def initialize
    luna_quest_custom_initialize
    self.arrows_visible = setting[:arrow]
    refresh_background
    update
  end
  
  #--------------------------------------------------------------------------
  # new method: init_position
  #--------------------------------------------------------------------------
  def init_position
    self.x = init_screen_x
    self.y = init_screen_y
    self.z = init_screen_z
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: window_width
  #--------------------------------------------------------------------------
  def window_width
    [setting[:width], standard_padding * 2 + line_height].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: window_height
  #--------------------------------------------------------------------------
  def window_height
    [setting[:height], standard_padding * 2 + line_height].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: standard_padding
  #--------------------------------------------------------------------------
  def standard_padding
    [setting[:padding], 0].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: item_height
  #--------------------------------------------------------------------------
  def item_height
    setting[:item_height]
  end
  
  #--------------------------------------------------------------------------
  # new method: init_screen_x
  #--------------------------------------------------------------------------
  def init_screen_x
    setting[:enable] ? eval(setting[:x].to_s) : 999
  end
  
  #--------------------------------------------------------------------------
  # new method: init_screen_y
  #--------------------------------------------------------------------------
  def init_screen_y
    eval(setting[:y].to_s)
  end
  
  #--------------------------------------------------------------------------
  # new method: init_screen_z
  #--------------------------------------------------------------------------
  def init_screen_z
    eval(setting[:z].to_s)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: col_max
  #--------------------------------------------------------------------------
  def col_max
    setting[:vertical] ? 1 : [item_max, 1].max
  end
  
  #--------------------------------------------------------------------------
  # alias method: contents_height
  #--------------------------------------------------------------------------
  alias menu_luna_contents_height contents_height
  def contents_height
    setting[:vertical] ? [super - super % item_height, row_max * item_height].max : menu_luna_contents_height
  end

  #--------------------------------------------------------------------------
  # overwrite method: spacing
  #--------------------------------------------------------------------------
  def spacing
    8
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: alignment
  #--------------------------------------------------------------------------
  def alignment
    setting[:align]
  end
  
  #--------------------------------------------------------------------------
  # new method: setting
  #--------------------------------------------------------------------------
  def setting
    MenuLuna::QuestMenu::WINDOW_CATEGORY
  end
  
  #--------------------------------------------------------------------------
  # new method: setting_type
  #--------------------------------------------------------------------------
  def setting_type
    type = setting[:back_type]
    setting[eval(":type_#{type}")]
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: dispose
  #--------------------------------------------------------------------------
  def dispose
    super
    @bg_sprite.dispose if @bg_sprite
  end
  
#~   #--------------------------------------------------------------------------
#~   # new method: texts
#~   #--------------------------------------------------------------------------
#~   def texts(index, contents, rect, enable, select)
#~     MenuLuna::ItemMenu.category_text(index, contents, rect, enable, select)
#~   end
#~   
#~   #--------------------------------------------------------------------------
#~   # alias method: draw_item
#~   #--------------------------------------------------------------------------
#~   alias menu_luna_draw_item draw_item
#~   def draw_item(index)
#~     clear_item(index)
#~     rect = item_rect(index)
#~     enable = command_enabled?(index)
#~     select = index == self.index
#~     return menu_luna_draw_item(index) if texts(index, contents, rect, enable, select).nil?
#~     reset_font_settings
#~     hash = texts(index, contents, rect, enable, select)
#~     hash[0].each { |val|
#~       draw_lunatic(val, hash[1])
#~     }
#~   end
  
  #--------------------------------------------------------------------------
  # alias method: update_cursor
  #--------------------------------------------------------------------------
  alias menu_luna_update_cursor update_cursor
  def update_cursor
    setting[:cursor] ? menu_luna_update_cursor : cursor_rect.empty
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: process_cursor_move
  #--------------------------------------------------------------------------
  def process_cursor_move
    return unless cursor_movable?
    last_index = @index
    cursor_down (Input.trigger?(:DOWN))  if Input.repeat?(:DOWN)
    cursor_up   (Input.trigger?(:UP))    if Input.repeat?(:UP)
    cursor_right(Input.trigger?(:RIGHT)) if Input.repeat?(:RIGHT)
    cursor_left (Input.trigger?(:LEFT))  if Input.repeat?(:LEFT)
    cursor_pagedown   if !handle?(:pagedown) && Input.trigger?(:R)
    cursor_pageup     if !handle?(:pageup)   && Input.trigger?(:L)
    Sound.play_cursor if @index != last_index
    return if @index == last_index
    draw_item(last_index)
    draw_item(@index)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: index=
  #--------------------------------------------------------------------------
  def index=(index)
    draw_item(@index) if current_data
    @index = index
    draw_item(@index) if current_data
    update_cursor
    call_update_help
  end
  
  #--------------------------------------------------------------------------
  # cursor_down
  #--------------------------------------------------------------------------
  def cursor_down(wrap = false)
    if index < item_max - col_max || (wrap && col_max == 1)
      select((index + col_max) % item_max)
    end
  end
  
  #--------------------------------------------------------------------------
  # cursor_up
  #--------------------------------------------------------------------------
  def cursor_up(wrap = false)
    if index >= col_max || (wrap && col_max == 1)
      select((index - col_max + item_max) % item_max)
    end
  end
  
  #--------------------------------------------------------------------------
  # contents_width
  #--------------------------------------------------------------------------
  alias menu_luna_contents_width contents_width
  def contents_width
    setting[:vertical] ? width - standard_padding * 2 : menu_luna_contents_width
  end
  
  #--------------------------------------------------------------------------
  # item_rect
  #--------------------------------------------------------------------------
  alias menu_luna_item_rect item_rect
  def item_rect(index)
    if setting[:vertical]
      rect = Rect.new
      rect.width = item_width
      rect.height = item_height
      rect.x = index % col_max * (item_width + spacing)
      rect.y = index / col_max * item_height
      return rect
    else
      return menu_luna_item_rect(index)
    end
  end
  
  #--------------------------------------------------------------------------
  # ensure_cursor_visible
  #--------------------------------------------------------------------------
  alias menu_luna_ensure_cursor_visible ensure_cursor_visible
  def ensure_cursor_visible
    if setting[:vertical]
      self.top_row = row if row < top_row
      self.bottom_row = row if row > bottom_row
    else
      menu_luna_ensure_cursor_visible
    end
  end
  
end # Window_QuestCategory

#==============================================================================
# ■ Window_QuestList
#==============================================================================

class Window_QuestList < Window_Selectable
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #-------------------------------------------------------------------------- 
  alias luna_quest_custom_initialize initialize
  def initialize
    luna_quest_custom_initialize
    self.arrows_visible = setting[:arrow]
    refresh_background
    update
  end
  
  #--------------------------------------------------------------------------
  # new method: init_position
  #--------------------------------------------------------------------------
  def init_position
    self.x = screen_x
    self.y = screen_y
    self.z = screen_z
    self.width = window_width
    self.height = window_height
    refresh
  end
  
  #--------------------------------------------------------------------------
  # new method: window_width
  #--------------------------------------------------------------------------
  def window_width
    [setting[:width], standard_padding * 2 + line_height].max
  end
  
  #--------------------------------------------------------------------------
  # new method: window_height
  #--------------------------------------------------------------------------
  def window_height
    [setting[:height], standard_padding * 2 + line_height].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: standard_padding
  #--------------------------------------------------------------------------
  def standard_padding
    [setting[:padding], 0].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: item_height
  #--------------------------------------------------------------------------
  def item_height
    [line_height, setting[:item_height]].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: window_height
  #--------------------------------------------------------------------------
  def col_max
    [1, setting[:column]].max
  end
  
  #--------------------------------------------------------------------------
  # new method: setting
  #--------------------------------------------------------------------------
  def setting
    MenuLuna::QuestMenu::WINDOW_ITEM
  end
  
  #--------------------------------------------------------------------------
  # new method: screen_x
  #--------------------------------------------------------------------------
  def screen_x
    setting[:x]
  end
  
  #--------------------------------------------------------------------------
  # new method: screen_y
  #--------------------------------------------------------------------------
  def screen_y
    setting[:y]
  end
  
  #--------------------------------------------------------------------------
  # new method: screen_z
  #--------------------------------------------------------------------------
  def screen_z
    setting[:z]
  end
  
  #--------------------------------------------------------------------------
  # new method: setting_type
  #--------------------------------------------------------------------------
  def setting_type
    type = setting[:back_type]
    setting[eval(":type_#{type}")]
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: dispose
  #--------------------------------------------------------------------------
  def dispose
    super
    @bg_sprite.dispose if @bg_sprite
  end
  
  #--------------------------------------------------------------------------
  # alias method: include?
  #--------------------------------------------------------------------------
  alias luna_quest_custom_include? include?
  def include?(item)
    category_enable = MenuLuna::QuestMenu::WINDOW_CATEGORY[:enable]
    category_enable ? luna_quest_custom_include?(item) : true
  end
  
#~   #--------------------------------------------------------------------------
#~   # new method: texts
#~   #--------------------------------------------------------------------------
#~   def texts(item, contents, rect, enable, select)
#~     MenuLuna::ItemMenu.item_text(item, contents, rect, enable, select)
#~   end
#~   
#~   #--------------------------------------------------------------------------
#~   # alias method: draw_item
#~   #--------------------------------------------------------------------------
#~   alias menu_luna_draw_item draw_item
#~   def draw_item(index)
#~     clear_item(index)
#~     item = @data[index]
#~     select = index == self.index
#~     if item
#~       rect = item_rect(index)
#~       enable = enable?(item)
#~       return menu_luna_draw_item(index) if texts(item, contents, rect, enable, select).nil?
#~       reset_font_settings
#~       hash = texts(item, contents, rect, enable, select)
#~       hash[0].each { |val|
#~         draw_lunatic(val, hash[1])
#~       }
#~     end
#~   end
  
  #--------------------------------------------------------------------------
  # alias method: update_cursor
  #--------------------------------------------------------------------------
  alias menu_luna_update_cursor update_cursor
  def update_cursor
    setting[:cursor] ? menu_luna_update_cursor : cursor_rect.empty
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: process_cursor_move
  #--------------------------------------------------------------------------
  def process_cursor_move
    return unless cursor_movable?
    last_index = @index
    cursor_down (Input.trigger?(:DOWN))  if Input.repeat?(:DOWN)
    cursor_up   (Input.trigger?(:UP))    if Input.repeat?(:UP)
    cursor_right(Input.trigger?(:RIGHT)) if Input.repeat?(:RIGHT)
    cursor_left (Input.trigger?(:LEFT))  if Input.repeat?(:LEFT)
    cursor_pagedown   if !handle?(:pagedown) && Input.trigger?(:R)
    cursor_pageup     if !handle?(:pageup)   && Input.trigger?(:L)
    Sound.play_cursor if @index != last_index
    return if @index == last_index
    draw_item(last_index)
    draw_item(@index)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: index=
  #--------------------------------------------------------------------------
  def index=(index)
    draw_item(@index) if @index >= 0
    @index = index
    draw_item(@index) if @index >= 0
    update_cursor
    call_update_help
  end
  
  #--------------------------------------------------------------------------
  # alias method: item_rect
  #--------------------------------------------------------------------------
  alias menu_luna_item_rect item_rect
  def item_rect(index)
    return menu_luna_item_rect(index) unless setting[:item_rect][:custom]
    rect = Rect.new
    item_width = setting[:item_rect][:width]
    item_height = setting[:item_rect][:height]
    spacing_ver = setting[:item_rect][:spacing_ver]
    spacing_hor = setting[:item_rect][:spacing_hor]
    rect.width = item_width
    rect.height = item_height
    rect.x = index % col_max * (item_width + spacing_hor)
    rect.y = index / col_max * (item_height + spacing_ver)
    rect
  end
  
end # Window_QuestList

#==============================================================================
# ■ Window_QuestContents
#==============================================================================

class Window_QuestContents < Window_Base
  
  #--------------------------------------------------------------------------
  # overwrite method: initialize
  #--------------------------------------------------------------------------
  alias luna_quest_custom_initialize initialize
  def initialize
    luna_quest_custom_initialize
    refresh_background
    init_position
    update
  end
  
  #--------------------------------------------------------------------------
  # new method: init_position
  #--------------------------------------------------------------------------
  def init_position
    self.x = init_screen_x
    self.y = init_screen_y
    self.z = init_screen_z
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: window_width
  #--------------------------------------------------------------------------
  def window_width
    [setting[:width], standard_padding * 2 + line_height].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: window_height
  #--------------------------------------------------------------------------
  def window_height
    [setting[:height], standard_padding * 2 + line_height].max
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: standard_padding
  #--------------------------------------------------------------------------
  def standard_padding
    [setting[:padding], 0].max
  end
  
  #--------------------------------------------------------------------------
  # new method: init_screen_x
  #--------------------------------------------------------------------------
  def init_screen_x
    eval(setting[:x].to_s)
  end
  
  #--------------------------------------------------------------------------
  # new method: init_screen_y
  #--------------------------------------------------------------------------
  def init_screen_y
    eval(setting[:y].to_s)
  end
  
  #--------------------------------------------------------------------------
  # new method: init_screen_z
  #--------------------------------------------------------------------------
  def init_screen_z
    eval(setting[:z].to_s)
  end
  
  #--------------------------------------------------------------------------
  # new method: setting
  #--------------------------------------------------------------------------
  def setting
    MenuLuna::QuestMenu::WINDOW_DESCRIPTION
  end
  
  #--------------------------------------------------------------------------
  # new method: setting_type
  #--------------------------------------------------------------------------
  def setting_type
    type = setting[:back_type]
    setting[eval(":type_#{type}")]
  end
  
#~   #--------------------------------------------------------------------------
#~   # new method: text
#~   #--------------------------------------------------------------------------
#~   def texts(item, contents)
#~     MenuLuna::ItemMenu::description_text(item, contents)
#~   end
#~   
#~   #--------------------------------------------------------------------------
#~   # new method: refresh
#~   #--------------------------------------------------------------------------
#~   def refresh
#~     contents.clear
#~     return unless @window_item
#~     return if @window_item.item.nil?
#~     return if texts(@window_item.item, contents).nil?
#~     reset_font_settings
#~     hash = texts(@window_item.item, contents)
#~     hash[0].each { |val|
#~       draw_lunatic(val, hash[1])
#~     }
#~   end
    
  #--------------------------------------------------------------------------
  # overwrite method: dispose
  #--------------------------------------------------------------------------
  def dispose
    super
    @bg_sprite.dispose if @bg_sprite
  end
  
end # Window_QuestContents