##-----------------------------------------------------------------------------
## Luna Engine - Easy Save Menu Add-on
## Created by Neon Black - 1.9.2013
##
## CORE HALF
##   - Requires the config half above it to work.
##
## This script is the first half of a 2 part script that allows the save
## menu to be customized without the need to use lunatic customization.  The
## save menu may be easily customized using commands similar to the rest of
## the Luna engine.  To use this script place the script anywhere below
## "▼ Materials" and above "▼ Main Process".  When using the Luna Engine Menu
## script, both pieces must go BELOW the Luna Engine.
##
##  ▼ Materials
##   Yami's Luna Menu
##   Neon's Luna Save Config
##   Neon's Luna Save Core
##
##  ▼ Main Process
##-----------------------------------------------------------------------------


##-----------------------------------------------------------------------------
## The following lines are the actual core code of the script.  While you are
## certainly invited to look, modifying it may result in undesirable results.
## Modify at your own risk!
###----------------------------------------------------------------------------


##------
## * Basic object properties used for the window sprite sets
##------
class CPLSaveObject < Sprite
  attr_accessor :selected
  
  def initialize(viewport, file, setting, index = 0)
    super(viewport)
    @party = file
    @setting = setting
    @index = index
    @highlight = 0
    @selected = false
    refresh
    self.z = setting[:z]
  end
  
  def pos(xp, yp)
    self.x = setting[:x] + xp
    self.y = setting[:y] + yp
    self.z = setting[:z]
  end
  
  def refresh
    make_object_bitmap
  end
  
  def party
    @party
  end
  
  def actor
    return nil unless party
    party[:actors][@index]
  end
  
  def okay_party?
    !party.nil?
  end
  
  def update_highlight
    highlight = @selected ? (12 - @highlight).abs * 3 : 0
    highlight = setting[:highlight] ? highlight : 0
    self.opacity = 255
    grey = grey_value
    self.tone = Tone.new(highlight, highlight, highlight, grey)
    @highlight = (@highlight + 1) % 24
  end
  
  def grey_value
    @selected ? 0 : setting[:grey_out] ? 255 : 0
  end
  
  def make_text_sprite(text = "")
    self.bitmap = Bitmap.new(setting[:width], setting[:height])
    return unless okay_party?
    color1 = Color.new(*setting[:color])
    color2 = Color.new(*setting[:outline])
    self.bitmap.font.color     = color1
    self.bitmap.font.out_color = color2
    self.bitmap.font.bold      = setting[:bold]
    self.bitmap.font.italic    = setting[:italic]
    self.bitmap.font.name      = setting[:font]
    self.bitmap.font.size      = setting[:size]
    rect = self.bitmap.rect.clone
    rect.x += 1; rect.width -= 2
    self.bitmap.draw_text(rect, text, setting[:align])
  end
  
  def setting
    @setting
  end
  
  def setting_type
    type = setting[:type]
    setting[eval(":type_#{type}")]
  end
end

##-----
## * Main object
##-----
class CPLSaveMain < CPLSaveObject
  def make_object_bitmap
    if party
      object_map_0
    else
      object_map_1
    end
  end
  
  def object_map_0
    result = setting[:filename]
    bit = Cache.system(result)
    self.bitmap = Bitmap.new(bit.width, bit.height)
    self.bitmap.blt(0, 0, bit, bit.rect)
  end
  
  def object_map_1
    type = setting[:type]
    case type
    when 0
      object_map_0
    when 1
      object_map_0
      self.tone = Tone.new(0, 0, 0, 255)
    when 2
      self.bitmap = Bitmap.new(32, 32)
    when 3
      bit = Cache.system(setting_type[:filename])
      self.bitmap = Bitmap.new(bit.width, bit.height)
      self.bitmap.blt(0, 0, bit, bit.rect)
    end
  end
  
  def setting
    super[:main]
  end
end

class CPLSaveMainFile < CPLSaveMain
  def update
    super
    update_highlight
  end
  
  def grey_value
    @selected ? party_0 : setting[:grey_out] ? 255 : party_0
  end
  
  def party_0
    !party.nil? ? 0 : setting[:type] == 1 ? 255 : 0
  end
end

##------
## * Character object sprite
##------
class CPLSaveChara < CPLSaveObject
  def make_object_bitmap
    return self.bitmap = Bitmap.new(32, 32) unless actor
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    end
    self.ox = self.width / 2
    self.oy = self.height
  end
  
  def object_map_0
    name = actor.character_name
    bit = Cache.character(name)
    sign = name[/^[\!\$]./]
    if sign && sign.include?('$')
      rw = bit.width / setting_lunatic[:hor_cells][1]
      rh = bit.height / setting_lunatic[:ver_cells][1]
      rx = rw * setting_lunatic[:cell_select][0]
      ry = rh * setting_lunatic[:cell_select][1]
    else
      rw = bit.width / setting_lunatic[:hor_cells][0]
      rh = bit.height / setting_lunatic[:ver_cells][0]
      rx = rw * setting_lunatic[:cell_select][0]
      ry = rh * setting_lunatic[:cell_select][1]
      xo = actor.character_index % 4
      yo = actor.character_index / 4
      rx += xo * setting_lunatic[:hor_cells][0] / 4 * rw
      ry += yo * setting_lunatic[:ver_cells][0] / 2 * rh
    end
    rect = Rect.new(rx, ry, rw, rh)
    self.bitmap = Bitmap.new(rect.width, rect.height)
    self.bitmap.blt(0, 0, bit, rect)
  end
  
  def object_map_1
    result = setting[:type_1][:filename]
    result += "_#{actor.actor.id}" if setting[:type_1][:base_actor]
    result += "_#{actor.class.id}" if setting[:type_1][:base_class]
    self.bitmap = Cache.character(result)
  end
  
  def pos(*args)
    super(*args)
    index = @index
    self.x += eval(setting[:x_offset].to_s)
    self.y += eval(setting[:y_offset].to_s)
  end
  
  def update
    super
    update_highlight
  end
  
  def setting
    super[:character]
  end
  
  def setting_lunatic
    setting[:lunatic]
  end
end

##------
## * Face object sprite
##------
class CPLSaveFace < CPLSaveObject
  def make_object_bitmap
    return self.bitmap = Bitmap.new(32, 32) unless actor
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    end
  end
  
  def object_map_0
    bit = Cache.face(actor.face_name)
    self.bitmap = Bitmap.new(96, 96)
    i = actor.face_index
    rect = Rect.new(i % 4 * 96, i / 4 * 96, 96, 96)
    self.bitmap.blt(0, 0, bit, rect)
  end
  
  def object_map_1
    result = setting[:type_1][:filename]
    result += "_#{actor.actor.id}" if setting[:type_1][:base_actor]
    result += "_#{actor.class.id}" if setting[:type_1][:base_class]
    self.bitmap = Cache.character(result)
  end
  
  def pos(*args)
    super(*args)
    index = @index
    self.x += eval(setting[:x_offset].to_s)
    self.y += eval(setting[:y_offset].to_s)
  end
  
  def update
    super
    update_highlight
  end
  
  def setting
    super[:face]
  end
  
  def setting_lunatic
    setting[:lunatic]
  end
end

##------
## * Slot object sprite
##------
class CPLSaveSlot < CPLSaveObject
  def make_object_bitmap
    vocab = setting[:text].clone.gsub(/<index>/i, (@index + 1).to_s)
    make_text_sprite(vocab)
  end
  
  def okay_party?
    true
  end
  
  def setting
    super[:slot]
  end
end

##------
## * Name object sprite
##------
class CPLSaveName < CPLSaveObject
  def make_object_bitmap
    if party && party[:actors][0]
      vocab = party[:actors][0].name
    else
      vocab = ""
    end
    make_text_sprite(vocab)
  end
  
  def setting
    super[:name]
  end
end

##------
## * Level object sprite
##------
class CPLSaveLevel < CPLSaveObject
  def make_object_bitmap
    if party && party[:actors][0]
      vocab = setting[:text].clone
      vocab = vocab.gsub(/<level>/i, party[:actors][0].level.to_s)
    else
      vocab = ""
    end
    make_text_sprite(vocab)
  end
  
  def setting
    super[:level]
  end
end

##------
## * Map name object sprite
##------
class CPLSaveMapName < CPLSaveObject
  def make_object_bitmap
    if party
      vocab = party[:map_name]
    else
      vocab = ""
    end
    make_text_sprite(vocab)
  end
  
  def setting
    super[:map_name]
  end
end

##------
## * Playtime object sprite
##------
class CPLSavePlaytime < CPLSaveObject
  def make_object_bitmap
    if party
      vocab = party[:playtime_s]
    else
      vocab = ""
    end
    make_text_sprite(vocab)
  end
  
  def setting
    super[:playtime]
  end
end

module DataManager
  def self.save_file_exists?
    check_folder
    file = luna_save_setting[:save_name].clone.gsub(/<index>/i, '*')
    !Dir.glob(File.join('**', file)).empty?
  end
  
  def self.savefile_max
    return luna_save_setting[:slots]
  end
  
  def self.make_filename(index)
    luna = luna_save_setting[:folder_name]
    folder = luna ? "#{luna}/" : ""
    file = luna_save_setting[:save_name].clone.gsub(/<index>/i, (index + 1).to_s)
    return "#{folder}#{file}"
  end
  
  def self.make_save_header
    header = {}
    header[:actors]     = $game_party.members
    header[:playtime_s] = $game_system.playtime_s
    header[:map_name]   = $game_map.display_name
    header
  end
  
  def self.check_folder
    folder = luna_save_setting[:folder_name]
    return unless folder
    return if Dir.entries(Dir.pwd).include?(folder)
    Dir.mkdir(folder)
  end
  
  def self.luna_save_setting
    CPLunaSave::BASIC
  end
end

class Scene_File < Scene_MenuBase
  ## Restored default methods to prevent bugging.
  def create_savefile_viewport
    @savefile_viewport = Viewport.new
    @savefile_viewport.rect.y = @help_window.height
    @savefile_viewport.rect.height -= @help_window.height
  end
  ##------
  
  def visible_max
    return CPLunaSave::BASIC[:slots]
  end
  
  def create_background
    @actor = $game_party.menu_actor
    type = setting[:type]
    case type
    when 0; create_type0
    when 1; create_type1
    when 2; create_type2
    end
    @background_sprite.z = setting[:z]
  end
  
  def create_type0
    x, y, width, height = setting[:x], setting[:y], setting[:width], setting[:height]
    @background_sprite = Sprite.new
    @background_sprite.bitmap = Bitmap.new(width, height)
    @background_sprite.x, @background_sprite.y = x, y
    temp_bit = SceneManager.background_bitmap
    @background_sprite.bitmap.blt(0, 0, temp_bit, Rect.new(x, y, width, height))
    @background_sprite.color.set(*setting_type[:color])
  end
  
  def create_type1
    x, y, width, height = setting[:x], setting[:y], setting[:width], setting[:height]
    case setting_type[:wind_type]
    when 0
      @background_sprite = Window_Base.new(x, y, width, height)
      @background_sprite.opacity = setting_type[:type0_opacity]
    when 1
      @background_sprite = Sprite.new
      @background_sprite.bitmap = Bitmap.new(width, height)
      @background_sprite.x, @background_sprite.y = x, y
      c1 = Color.new(*setting_type[:type1_color1])
      c2 = Color.new(*setting_type[:type1_color2])
      vert = setting_type[:type1_vertical]
      @background_sprite.bitmap.gradient_fill_rect(0, 0, width, height, c1, c2, vert)
    end
  end
  
  def create_type2
    @background_sprite = Sprite.new
    @background_sprite.x = setting[:x]
    @background_sprite.y = setting[:y]
    @background_sprite.bitmap = Cache.system(setting_type[:image_name])
  end
  
  def create_help_window
    @help_window = Luna_SaveHelp.new
    @help_window.set_text(help_window_text)
    @info_window = Luna_SaveInfo.new
  end
  
  alias :cp_lunasave_update_cursor :update_cursor
  def update_cursor
    last_index = @index
    cp_lunasave_update_cursor
    @info_window.set_data(get_file_header, @index) unless last_index == @index
  end
  
  def get_file_header
    DataManager.load_header(@index) if @index
  end
  
  alias :cp_lunasave_init_selection :init_selection
  def init_selection
    cp_lunasave_init_selection
    @info_window.set_data(get_file_header)
  end
  
  def create_savefile_windows
    @savefile_windows = Array.new(item_max) do |i|
      Window_SaveFile.new(0, i)
    end
  end
  
  def setting
    CPLunaSave::BACKGROUND
  end
  
  def setting_type
    type = setting[:type]
    setting[eval(":type_#{type}")]
  end
end

class Scene_Save < Scene_File
  def help_window_text
    CPLunaSave::HEADER[:text][:save_string]
  end
end

class Scene_Load < Scene_File
  def help_window_text
    CPLunaSave::HEADER[:text][:load_string]
  end
end

class Luna_SaveHelp < Window_Base
  def initialize
    @viewport = Viewport.new
    super(0, 0, window_width, window_height)
    self.viewport = @viewport
    self.viewport.visible = setting[:enable]
    init_position
    refresh_background
    update
  end
  
  def init_position
    self.x = init_screen_x
    self.y = init_screen_y
    self.z = 0
    @viewport.z = init_screen_z
  end
  
  def init_screen_x; setting[:x]; end
  def init_screen_y; setting[:y]; end
  def init_screen_z; setting[:z]; end
  def alignment; setting_text[:align]; end
  
  def window_width
    [setting[:width], standard_padding * 2 + line_height].max
  end
  
  def window_height
    [setting[:height], standard_padding * 2 + line_height].max
  end
  
  def item_height
    [setting[:item_height], 0].max
  end
  
  def standard_padding
    [setting[:padding], 0].max
  end
  
  def refresh_background
    type = setting[:type]
    case type
    when 0; refresh_type0
    when 1; refresh_type1
    when 2; refresh_type2
    end
    @bg_sprite.viewport = @viewport
  end
  
  def refresh_type0
    return if @bg_sprite
    @bg_sprite = Window_Base.new(0, 0, window_width, window_height)
  end
  
  def refresh_type1
    return if @bg_sprite
    @bg_sprite = Sprite.new(nil)
    bitmap = Bitmap.new(window_width, window_height)
    color1 = setting_type[:color1]
    color1 = Color.new(*color1)
    color2 = setting_type[:color2]
    color2 = Color.new(*color2)
    bitmap.gradient_fill_rect(bitmap.rect, color1, color2, setting_type[:vertical])
    @bg_sprite.bitmap = bitmap
  end
  
  def refresh_type2
    return if @bg_sprite
    @bg_sprite = Sprite.new(nil)
    @bg_sprite.bitmap = Cache.system(setting_type[:picture])
  end
  
  def update
    super
    type = setting[:type]
    case type
    when 0; update_type0
    when 1; update_type1
    when 2; update_type2
    end
  end
  
  def set_text(text = "")
    contents.clear
    color1 = Color.new(*setting_text[:color])
    color2 = Color.new(*setting_text[:outline])
    self.contents.font.color     = color1
    self.contents.font.out_color = color2
    self.contents.font.bold      = setting_text[:bold]
    self.contents.font.italic    = setting_text[:italic]
    self.contents.font.name      = setting_text[:font]
    self.contents.font.size      = setting_text[:size]
    contents.draw_text(contents.rect, text, alignment)
  end
  
  def update_type0
    @bg_sprite.update
    @bg_sprite.x = self.x
    @bg_sprite.y = self.y
    @bg_sprite.z = self.z - 2
    @bg_sprite.opacity = setting_type[:opacity]
    @bg_sprite.openness = self.openness
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  def update_type1
    @bg_sprite.update
    @bg_sprite.x = self.x
    @bg_sprite.y = self.y
    @bg_sprite.z = self.z - 2
    @bg_sprite.opacity = self.openness
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  def update_type2
    @bg_sprite.update
    @bg_sprite.x = self.x + setting_type[:offset_x]
    @bg_sprite.y = self.y + setting_type[:offset_y]
    @bg_sprite.z = self.z - 2
    @bg_sprite.opacity = [setting_type[:opacity], self.openness].min
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  def dispose
    @bg_sprite.dispose if @bg_sprite
    super
    @viewport.dispose
  end
  
  def setting
    CPLunaSave::HEADER
  end
  
  def setting_type
    type = setting[:type]
    setting[eval(":type_#{type}")]
  end
  
  def setting_text
    setting[:text]
  end
end

class Luna_SaveInfo < Window_Base
  attr_reader :index
  
  def initialize
    @viewport = Viewport.new
    super(0, 0, window_width, window_height)
    self.viewport = @viewport
    self.viewport.visible = setting[:enable]
    @index = 0
    init_position
    refresh_background
    make_spritesheet
    update
  end
  
  def init_position
    self.x = init_screen_x
    self.y = init_screen_y
    self.z = 0
    @viewport.z = init_screen_z
  end
  
  def init_screen_x; setting[:x]; end
  def init_screen_y; setting[:y]; end
  def init_screen_z; setting[:z]; end
  
  def window_width
    [setting[:width], standard_padding * 2 + line_height].max
  end
  
  def window_height
    [setting[:height], standard_padding * 2 + line_height].max
  end
  
  def refresh_background
    type = setting[:type]
    case type
    when 0; refresh_type0
    when 1; refresh_type1
    when 2; refresh_type2
    end
    @bg_sprite.viewport = @viewport
  end
  
  def refresh_type0
    return if @bg_sprite
    @bg_sprite = Window_Base.new(0, 0, window_width, window_height)
  end
  
  def refresh_type1
    return if @bg_sprite
    @bg_sprite = Sprite.new(nil)
    bitmap = Bitmap.new(window_width, window_height)
    color1 = setting_type[:color1]
    color1 = Color.new(*color1)
    color2 = setting_type[:color2]
    color2 = Color.new(*color2)
    bitmap.gradient_fill_rect(bitmap.rect, color1, color2, setting_type[:vertical])
    @bg_sprite.bitmap = bitmap
  end
  
  def refresh_type2
    return if @bg_sprite
    @bg_sprite = Sprite.new(nil)
    @bg_sprite.bitmap = Cache.system(setting_type[:picture])
  end
  
  def make_spritesheet
    @spritesets = CPLunaSaveInfo_Spriteset.new(self, @viewport, nil)
  end
  
  def set_data(data = nil, index = 0)
    @data = data
    @index = index
    @spritesets.header = @data if @spritesets
  end
  
  def update
    super
    type = setting[:type]
    case type
    when 0; update_type0
    when 1; update_type1
    when 2; update_type2
    end
    update_spritesets
  end
  
  def update_type0
    @bg_sprite.update
    @bg_sprite.x = self.x
    @bg_sprite.y = self.y
    @bg_sprite.z = self.z - 2
    @bg_sprite.opacity = setting_type[:opacity]
    @bg_sprite.openness = self.openness
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  def update_type1
    @bg_sprite.update
    @bg_sprite.x = self.x
    @bg_sprite.y = self.y
    @bg_sprite.z = self.z - 2
    @bg_sprite.opacity = self.openness
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  def update_type2
    @bg_sprite.update
    @bg_sprite.x = self.x + setting_type[:offset_x]
    @bg_sprite.y = self.y + setting_type[:offset_y]
    @bg_sprite.z = self.z - 2
    @bg_sprite.opacity = [setting_type[:opacity], self.openness].min
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  def update_spritesets
    @spritesets.update if @spritesets
  end
  
  def dispose
    @bg_sprite.dispose if @bg_sprite
    @spritesets.dispose if @spritesets
    super
    @viewport.dispose
  end
  
  def setting
    CPLunaSave::INFO
  end
  
  def setting_type
    type = setting[:type]
    setting[eval(":type_#{type}")]
  end
end

class CPLunaSaveInfo_Spriteset
  def initialize(parent, viewport, header = nil)
    @parent   = parent
    @viewport = viewport
    @header = header
    @layers = []
    refresh
  end
  
  def dispose
    @layers.each { |layer| layer.dispose }
    @layers.clear
  end
  
  def update
    @layers.each do |layer|
      layer.update
      layer.pos(@parent.x, @parent.y)
    end
  end
  
  def refresh
    dispose
    [:main, :character, :slot, :face, :name, :level, :map_name,
     :playtime].each do |layer|
      if @header && [:character, :face].include?(layer)
        shown = @parent.setting[layer][:shown]
        shown = shown == 0 ? 999 : shown
        [@header[:actors].size, shown].min.times do |i|
          create_layer(layer, i)
        end
      else
        create_layer(layer, @parent.index)
      end
    end
  end
  
  def create_layer(layer, index = 0)
    return unless @parent.setting[layer] && @parent.setting[layer][:enable]
    case layer
    when :main;      obj = CPLSaveMain
    when :character; obj = CPLSaveChara
    when :face;      obj = CPLSaveFace
    when :slot;      obj = CPLSaveSlot
    when :name;      obj = CPLSaveName
    when :level;     obj = CPLSaveLevel
    when :map_name;  obj = CPLSaveMapName
    when :playtime;  obj = CPLSavePlaytime
    else; return
    end
    @layers.push(obj.new(@viewport, @header, CPLunaSave::INFO, index))
    @layers[-1].pos(@parent.x, @parent.y)
  end
  
  def header=(header)
    @header = header
    refresh
  end
end

class Window_SaveFile < Window_Base
  attr_reader :file_index
  
  def initialize(nothing, index)
    @viewport = Viewport.new
    super(0, 0, window_width, window_height)
    self.viewport = @viewport
    @file_index = index
    init_position
    refresh_background
    make_spritesheet
    update
  end
  
  def init_position
    index = @file_index
    self.x = init_screen_x + eval(setting[:x_offset].to_s)
    self.y = init_screen_y + eval(setting[:y_offset].to_s)
    self.z = 0
    @viewport.z = init_screen_z
  end
  
  def init_screen_x; setting[:x]; end
  def init_screen_y; setting[:y]; end
  def init_screen_z; setting[:z]; end
  
  def standard_padding
    return 12
  end
  
  def window_width
    [setting[:width], standard_padding * 2 + line_height].max
  end
  
  def window_height
    [setting[:height], standard_padding * 2 + line_height].max
  end
  
  def refresh_background
    type = setting[:type]
    case type
    when 0; refresh_type0
    when 1; refresh_type1
    when 2; refresh_type2
    end
    @bg_sprite.viewport = @viewport
  end
  
  def refresh_type0
    return if @bg_sprite
    @bg_sprite = Window_Base.new(0, 0, window_width, window_height)
  end
  
  def refresh_type1
    return if @bg_sprite
    @bg_sprite = Sprite.new(nil)
    bitmap = Bitmap.new(window_width, window_height)
    color1 = setting_type[:color1]
    color1 = Color.new(*color1)
    color2 = setting_type[:color2]
    color2 = Color.new(*color2)
    bitmap.gradient_fill_rect(bitmap.rect, color1, color2, setting_type[:vertical])
    @bg_sprite.bitmap = bitmap
  end
  
  def refresh_type2
    return if @bg_sprite
    @bg_sprite = Sprite.new(nil)
    @bg_sprite.bitmap = Cache.system(setting_type[:picture])
  end
  
  def make_spritesheet
    header = DataManager.load_header(@file_index)
    @spritesets = CPLunaSaveFile_Spriteset.new(self, @viewport, header)
  end
  
  def set_data(data = nil, index = 0)
    @data = data
    @index = index
    @spritesets.header = @data if @spritesets
  end
  
  def refresh
  end
  
  def update
    super
    type = setting[:type]
    case type
    when 0; update_type0
    when 1; update_type1
    when 2; update_type2
    end
    update_spritesets
  end
  
  def update_type0
    @bg_sprite.update
    @bg_sprite.x = self.x
    @bg_sprite.y = self.y
    @bg_sprite.z = self.z - 2
    @bg_sprite.opacity = setting_type[:opacity]
    @bg_sprite.openness = self.openness
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  def update_type1
    @bg_sprite.update
    @bg_sprite.x = self.x
    @bg_sprite.y = self.y
    @bg_sprite.z = self.z - 2
    @bg_sprite.opacity = self.openness
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  def update_type2
    @bg_sprite.update
    @bg_sprite.x = self.x + setting_type[:offset_x]
    @bg_sprite.y = self.y + setting_type[:offset_y]
    @bg_sprite.z = self.z - 2
    @bg_sprite.opacity = [setting_type[:opacity], self.openness].min
    @bg_sprite.visible = self.visible
    self.opacity = 0
  end
  
  def update_spritesets
    @spritesets.update if @spritesets
  end
  
  def update_cursor
    if @selected
      @spritesets.highlight = true if @spritesets
      cursor_rect.set(0, 0, contents.width, contents.height) if setting[:cursor]
    else
      @spritesets.highlight = false if @spritesets
      cursor_rect.empty
    end
  end
  
  def dispose
    @bg_sprite.dispose if @bg_sprite
    @spritesets.dispose if @spritesets
    super
    @viewport.dispose
  end
  
  def setting
    CPLunaSave::SAVE_FILE
  end
  
  def setting_type
    type = setting[:type]
    setting[eval(":type_#{type}")]
  end
end

class CPLunaSaveFile_Spriteset
  attr_writer :highlight
  
  def initialize(parent, viewport, header = nil)
    @parent   = parent
    @viewport = viewport
    @header = header
    @layers = []
    refresh
  end
  
  def dispose
    @layers.each { |layer| layer.dispose }
    @layers.clear
  end
  
  def update
    @layers.each do |layer|
      layer.update
      layer.pos(@parent.x, @parent.y)
      layer.selected = @highlight
    end
  end
  
  def refresh
    dispose
    [:main, :slot, :character, :face, :name, :level, :map_name,
     :playtime].each do |layer|
      if @header && [:character, :face].include?(layer)
        shown = @parent.setting[layer][:shown]
        shown = shown == 0 ? 999 : shown
        [@header[:actors].size, shown].min.times do |i|
          create_layer(layer, i)
        end
      else
        create_layer(layer, @parent.file_index)
      end
    end
  end
  
  def create_layer(layer, index = 0)
    return unless @parent.setting[layer] && @parent.setting[layer][:enable]
    case layer
    when :main;      obj = CPLSaveMainFile
    when :character; obj = CPLSaveChara
    when :face;      obj = CPLSaveFace
    when :slot;      obj = CPLSaveSlot
    when :name;      obj = CPLSaveName
    when :level;     obj = CPLSaveLevel
    when :map_name;  obj = CPLSaveMapName
    when :playtime;  obj = CPLSavePlaytime
    else; return
    end
    @layers.push(obj.new(@viewport, @header, CPLunaSave::SAVE_FILE, index))
    @layers[-1].pos(@parent.x, @parent.y)
  end
  
  def header=(header)
    @header = header
    refresh
  end
end