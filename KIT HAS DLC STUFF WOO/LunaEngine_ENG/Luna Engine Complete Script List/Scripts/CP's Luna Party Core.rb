##-----------------------------------------------------------------------------
## Luna Engine - Yanfly's Party System Add-on
## Created by Neon Black - 10.10.2013
##
## CORE HALF
##   - Requires the config half above it to work.
##
## This script is the second half of a 2 part script that allows Yanfly's
## party system to be easily customized like the rest of the Luna Engine.  This
## script requires both halves to be present as well as Yanfly's Party System.
## To use this script place the script anywhere below "▼ Materials" and above
## "▼ Main Process".  When using the Luna Engine Menu script, all 3 pieces must
## go BELOW the Luna Engine.
##
##  ▼ Materials
##   Yami's Luna Menu
##   Yanfly's Party System
##   Neon's Luna Party Config
##   Neon's Luna Party Core
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
class CPLPartyObject < Sprite
  attr_accessor :selected
  
  def initialize(viewport, actor, setting)
    super(viewport)
    @actor = actor
    @setting = setting
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
  
  def battler
    $game_actors[@actor]
  end
  
  def update_highlight
    dead = battler && battler.dead?
    highlight = @selected ? (12 - @highlight).abs * 3 : 0
    highlight = setting[:highlight] ? highlight : 0
    self.opacity = 255; grey = 0
    if setting[:collapse] && setting[:collapse_type] == 0
      self.opacity = !dead ? 255 : @selected ? 128 : 0
      self.blend_type = dead ? 1 : 0
      color0 = dead ? [255,128,128,128] : [0,0,0,0]
      self.color.set(*color0)
    elsif setting[:collapse] && setting[:collapse_type] == 1
      grey = dead ? 255 : 0
    end
    self.tone = Tone.new(highlight, highlight, highlight, grey)
    @highlight = (@highlight + 1) % 24
  end
  
  def make_text_sprite(text = "")
    self.bitmap = Bitmap.new(setting[:width], setting[:height])
    return unless battler
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

##------
## * Main window sprite
##------
class CPLPartyMain < CPLPartyObject
  def make_object_bitmap
    if battler
      object_map_0
    else
      object_map_1
    end
  end
  
  def object_map_0
    result = setting[:filename]
    result += "_#{battler.actor.id}" if setting[:base_actor]
    result += "_#{battler.class.id}" if setting[:base_class]
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
  
  def update
    super
    update_highlight if battler
    update_highlight_short unless battler
  end
  
  def update_highlight_short
    highlight = @selected ? (12 - @highlight).abs * 3 : 0
    highlight = setting[:highlight] ? highlight : 0
    grey = self.tone.gray
    self.tone = Tone.new(highlight, highlight, highlight, grey)
    @highlight = (@highlight + 1) % 24
  end
  
  def setting
    super[:main]
  end
end

##------
## * Selection object sprite
##------
class CPLPartySelect < CPLPartyObject
  def make_object_bitmap
    if battler
      object_map_0
    else
      object_map_1
    end
  end
  
  def object_map_0
    result = setting[:filename]
    result += "_#{battler.actor.id}" if setting[:base_actor]
    result += "_#{battler.class.id}" if setting[:base_class]
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
  
  def update
    super
    self.visible = @selected
  end
  
  def setting
    super[:select]
  end
end

##------
## * Character object sprite
##------
class CPLPartyChara < CPLPartyObject
  def make_object_bitmap
    return self.bitmap = Bitmap.new(32, 32) unless battler
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    when 2; object_map_2
    end
    self.ox = self.width / 2
    self.oy = self.height
  end
  
  def object_map_0
    name = battler.character_name
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
      xo = $game_actors[@actor].character_index % 4
      yo = $game_actors[@actor].character_index / 4
      rx += xo * setting_lunatic[:hor_cells][0] / 4 * rw
      ry += yo * setting_lunatic[:ver_cells][0] / 2 * rh
    end
    rect = Rect.new(rx, ry, rw, rh)
    self.bitmap = Bitmap.new(rect.width, rect.height)
    self.bitmap.blt(0, 0, bit, rect)
  end
  
  def object_map_1
    result = setting[:type_1][:filename]
    result += "_#{battler.actor.id}" if setting[:type_1][:base_actor]
    result += "_#{battler.class.id}" if setting[:type_1][:base_class]
    self.bitmap = Cache.character(result)
  end
  
  def object_map_2
    result = "#{battler.character_name}_#{battler.character_index}"
    self.bitmap = Cache.character(result)
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
## * Face sprite
##------
class CPLPartyFace < CPLPartyObject
  def make_object_bitmap
    return self.bitmap = Bitmap.new(32, 32) unless battler
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    when 2; object_map_2
    end
  end
  
  def object_map_0
    bit = Cache.face(battler.face_name)
    self.bitmap = Bitmap.new(96, 96)
    i = battler.face_index
    rect = Rect.new(i % 4 * 96, i / 4 * 96, 96, 96)
    self.bitmap.blt(0, 0, bit, rect)
  end
  
  def object_map_1
    result = setting[:type_1][:filename]
    result += "_#{battler.actor.id}" if setting[:type_1][:base_actor]
    result += "_#{battler.class.id}" if setting[:type_1][:base_class]
    self.bitmap = Cache.face(result)
  end
  
  def object_map_2
    result = "#{battler.face_name}_#{battler.face_index}"
    self.bitmap = Cache.face(result)
  end
  
  def update
    super
    update_highlight
  end
  
  def setting
    super[:face]
  end
end

##------
## * Name object sprite
##------
class CPLPartyName < CPLPartyObject
  def make_object_bitmap
    vocab = battler ? battler.name : ""
    make_text_sprite(vocab)
  end
  
  def setting
    super[:name]
  end
end

##------
## * Class sprite
##------
class CPLPartyClass < CPLPartyObject
  def make_object_bitmap
    vocab = battler ? battler.class.name : ""
    make_text_sprite(vocab)
  end
  
  def setting
    super[:class]
  end
end

##------
## * Nickname sprite
##------
class CPLPartyNickname < CPLPartyObject
  def make_object_bitmap
    vocab = battler ? battler.nickname : ""
    make_text_sprite(vocab)
  end
  
  def setting
    super[:nickname]
  end
end

##------
## * Empty object sprite
##------
class CPLPartyEmpty < CPLPartyObject
  def make_object_bitmap
    vocab = setting[:vocab]
    make_text_sprite(vocab)
  end
  
  def battler
    return !super
  end
  
  def setting
    super[:empty]
  end
end

##------
## * Level sprite
##------
class CPLPartyLevel < CPLPartyObject
  def make_object_bitmap
    vocab = setting[:vocab].clone
    vocab.gsub!(/<l>/i, battler ? battler.level.to_s : "0")
    make_text_sprite(vocab)
  end
  
  def setting
    super[:level]
  end
end

##------
## * The basic bar object used by other bars
##------
class CPLPartyBar < CPLPartyObject
  def make_object_bitmap
    return self.bitmap = Bitmap.new(32, 32) unless battler
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    when 2; object_map_2
    end
  end
  
  def object_map_0
    self.bitmap = Bitmap.new(setting_type[:width], setting_type[:height])
    rect = bitmap.rect.clone
    color1 = Color.new(*setting_type[:outline])
    color2 = Color.new(*setting_type[:back_color])
    color3 = Color.new(*setting_type[:color1])
    color4 = Color.new(*setting_type[:color2])
    self.bitmap.fill_rect(rect, color1)
    rect.x += 1; rect.y += 1; rect.width -= 2; rect.height -= 2
    self.bitmap.fill_rect(rect, color2)
    if setting[:vertical]
      nh = (rect.height.to_f * rate).round
      rect.y += rect.height - nh
      rect.height = nh
    else
      nw = (rect.width.to_f * rate).round
      rect.width = nw
    end
    self.bitmap.gradient_fill_rect(rect, color3, color4, setting[:vertical])
  end
  
  def object_map_1
    bit = Cache.system(setting_type[:filename])
    self.bitmap = Bitmap.new(bit.width, bit.height)
    if setting[:vertical]
      nh = (bit.height.to_f * rate).round
      rect = Rect.new(0, bit.height - nh, bit.width, nh)
    else
      nh = bit.height
      nw = (bit.width.to_f * rate).round
      rect = Rect.new(0, 0, nw, bit.height)
    end
    self.bitmap.blt(0, bit.height - nh, bit, rect)
  end
  
  def object_map_2
    bit = Cache.system(setting_type[:filename])
    self.bitmap = Bitmap.new(bit.width / setting_type[:frames], bit.height)
    frame = ((setting_type[:frames] - 1).to_f * rate).round
    rect = Rect.new(self.bitmap.width * frame, 0, self.bitmap.width, bit.height)
    self.bitmap.blt(0, 0, bit, rect)
  end
end

##------
## * HP bar sprite
##------
class CPLPartyHPBar < CPLPartyBar
  def setting
    super[:hp_bar]
  end
  
  def rate
    return battler.hp_rate
  end
end

##------
## * MP bar sprite
##------
class CPLPartyMPBar < CPLPartyBar
  def setting
    super[:mp_bar]
  end
  
  def rate
    return battler.mp_rate
  end
end

##------
## * TP bar sprite
##------
class CPLPartyTPBar < CPLPartyBar
  def setting
    super[:tp_bar]
  end
  
  def rate
    return battler.tp_rate
  end
end

##------
## * Min/max sprite base object for HP and such
##------
class CPLPartyMinMax < CPLPartyObject
  def make_text_sprite(text = "")
    self.bitmap = Bitmap.new(setting_type[:width], setting_type[:height])
    return unless battler
    color1 = Color.new(*setting_type[:color])
    color2 = Color.new(*setting_type[:outline])
    self.bitmap.font.color     = color1
    self.bitmap.font.out_color = color2
    self.bitmap.font.bold      = setting_type[:bold]
    self.bitmap.font.italic    = setting_type[:italic]
    self.bitmap.font.name      = setting_type[:font]
    self.bitmap.font.size      = setting_type[:size]
    rect = self.bitmap.rect.clone
    rect.x += 1; rect.width -= 2
    self.bitmap.draw_text(rect, text, setting_type[:align])
  end
  
  def make_frame_sprite(number)
    bit = Cache.system(setting_type[:filename])
    self.bitmap = Bitmap.new(setting_type[:width], bit.height)
    return unless battler
    cw = bit.width / 10
    rect = Rect.new(0, 0, cw, bit.height)
    fw = (number.to_s.size - 1) * (cw + setting_type[:spacing]) + cw
    sx = (self.bitmap.width - fw) / 2 * setting_type[:align]
    number.to_s.each_char do |n|
      rect.x = cw * n.to_i
      self.bitmap.blt(sx, 0, bit, rect)
      sx += cw + setting_type[:spacing]
    end
  end
end

##------
## * Current HP value sprite
##------
class CPLPartyHPNum < CPLPartyMinMax
  def make_object_bitmap
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    end
  end
  
  def object_map_0
    vocab = setting[:vocab].clone
    vocab.gsub!(/<c>/i, battler ? battler.hp.to_s : "0")
    vocab.gsub!(/<m>/i, battler ? battler.mhp.to_s : "0")
    make_text_sprite(vocab)
  end
  
  def object_map_1
    number = battler ? battler.hp : 0
    make_frame_sprite(number)
  end
  
  def setting
    super[:hp_num]
  end
end

##------
## * Current MP value sprite
##------
class CPLPartyMPNum < CPLPartyMinMax
  def make_object_bitmap
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    end
  end
  
  def object_map_0
    vocab = setting[:vocab].clone
    vocab.gsub!(/<c>/i, battler ? battler.mp.to_s : "0")
    vocab.gsub!(/<m>/i, battler ? battler.mmp.to_s : "0")
    make_text_sprite(vocab)
  end
  
  def object_map_1
    number = battler ? battler.mp : 0
    make_frame_sprite(number)
  end
  
  def setting
    super[:mp_num]
  end
end

##------
## * Current TP value sprite
##------
class CPLPartyTPNum < CPLPartyMinMax
  def make_object_bitmap
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    end
  end
  
  def object_map_0
    vocab = setting[:vocab].clone
    vocab.gsub!(/<c>/i, battler ? battler.tp.to_s : "0")
    vocab.gsub!(/<m>/i, battler ? battler.max_tp.to_s : "0")
    make_text_sprite(vocab)
  end
  
  def object_map_1
    number = battler ? battler.tp : 0
    make_frame_sprite(number)
  end
  
  def setting
    super[:tp_num]
  end
end

##------
## * Max HP value sprite
##------
class CPLPartyHPMax < CPLPartyMinMax
  def make_object_bitmap
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    end
  end
  
  def object_map_0
    vocab = battler ? battler.mhp.to_s : "0"
    make_text_sprite(vocab)
  end
  
  def object_map_1
    number = battler ? battler.mhp : 0
    make_frame_sprite(number)
  end
  
  def setting
    super[:hp_max]
  end
end

##------
## * Max MP value sprite
##------
class CPLPartyMPMax < CPLPartyMinMax
  def make_object_bitmap
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    end
  end
  
  def object_map_0
    vocab = battler ? battler.mmp.to_s : "0"
    make_text_sprite(vocab)
  end
  
  def object_map_1
    number = battler ? battler.mmp : 0
    make_frame_sprite(number)
  end
  
  def setting
    super[:mp_max]
  end
end

##------
## * Max TP value sprite
##------
class CPLPartyTPMax < CPLPartyMinMax
  def make_object_bitmap
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    end
  end
  
  def object_map_0
    vocab = battler ? battler.max_tp.to_s : "0"
    make_text_sprite(vocab)
  end
  
  def object_map_1
    number = battler ? battler.max_tp : 0
    make_frame_sprite(number)
  end
  
  def setting
    super[:tp_max]
  end
end

##------
## * State object sprite
##------
class CPLPartyStates < CPLPartyObject
  def initialize(*args)
    @scroll_set = 0
    super(*args)
  end
  
  def make_object_bitmap
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    end
  end
  
  def update
    super
    update_icon_scroll if setting[:type] == 1
  end
  
  def update_icon_scroll
    return unless battler
    icons = (battler.state_icons + battler.buff_icons)
    return if icons.empty?
    unless @last_icon == @scroll_set / setting_type[:rate] % icons.size
      @last_icon = @scroll_set / setting_type[:rate] % icons.size
      n = icons[@last_icon]
      rect = Rect.new(n % 16 * 24, n / 16 * 24, 24, 24)
      self.bitmap.blt(0, 0, icon_bit, rect)
    end
    @scroll_set += 1
  end
  
  def object_map_0
    wd = setting_type[:max] * (24 + setting_type[:spacing])
    self.bitmap = Bitmap.new(wd, 24)
    return unless battler
    icons = (battler.state_icons + battler.buff_icons)[0, setting_type[:max]]
    icons.each_with_index do |n,i|
      rect = Rect.new(n % 16 * 24, n / 16 * 24, 24, 24)
      x = (24 + setting_type[:spacing]) * i
      self.bitmap.blt(x, 0, icon_bit, rect)
    end
  end
  
  def object_map_1
    self.bitmap = Bitmap.new(24, 24)
    update_icon_scroll
  end
  
  def icon_bit
    bitmap = Cache.system("Iconset")
  end
  
  def setting
    super[:states]
  end
end

##------
## * State name object sprite
##------
class CPLPartyStatsN < CPLPartyObject
  def initialize(*args)
    super(*args)
    self.z = setting_type[:z]
  end
  
  def pos(xp, yp)
    self.x = setting_type[:x] + xp
    self.y = setting_type[:y] + yp
    self.z = setting_type[:z]
  end
  
  def make_object_bitmap
    self.bitmap = Bitmap.new(setting[:width], setting[:stats].size * setting[:line_height])
    return unless battler
    color1 = Color.new(*setting_type[:color])
    color2 = Color.new(*setting_type[:outline])
    self.bitmap.font.color     = color1
    self.bitmap.font.out_color = color2
    self.bitmap.font.bold      = setting_type[:bold]
    self.bitmap.font.italic    = setting_type[:italic]
    self.bitmap.font.name      = setting_type[:font]
    self.bitmap.font.size      = setting_type[:size]
    setting[:stats].each_with_index do |s,i|
      vocab = setting_type[:vocabs][i]
      rect = Rect.new(1, setting[:line_height] * i, setting[:width] - 2, setting[:line_height])
      self.bitmap.draw_text(rect, vocab, setting_type[:align])
    end
  end
  
  def setting
    super[:stats]
  end
  
  def setting_type
    setting[:names]
  end
end

##------
## * Stat values object sprite
##------
class CPLPartyStatsV < CPLPartyObject
  def initialize(*args)
    super(*args)
    self.z = setting_type[:z]
  end
  
  def pos(xp, yp)
    self.x = setting_type[:x] + xp
    self.y = setting_type[:y] + yp
    self.z = setting_type[:z]
  end
  
  def make_object_bitmap
    self.bitmap = Bitmap.new(setting[:width], setting[:stats].size * setting[:line_height])
    return unless battler
    color1 = Color.new(*setting_type[:color])
    color2 = Color.new(*setting_type[:outline])
    self.bitmap.font.color     = color1
    self.bitmap.font.out_color = color2
    self.bitmap.font.bold      = setting_type[:bold]
    self.bitmap.font.italic    = setting_type[:italic]
    self.bitmap.font.name      = setting_type[:font]
    self.bitmap.font.size      = setting_type[:size]
    setting[:stats].each_with_index do |s,i|
      vocab = battler.method(s).call
      rect = Rect.new(1, setting[:line_height] * i, setting[:width] - 2, setting[:line_height])
      self.bitmap.draw_text(rect, vocab, setting_type[:align])
    end
  end
  
  def setting
    super[:stats]
  end
  
  def setting_type
    setting[:values]
  end
end

##------
## * Equips object sprite
##------
class CPLPartyEquips < CPLPartyObject
  def make_object_bitmap
    return self.bitmap = Bitmap.new(32, 32) unless battler
    equips = battler.equips
    self.bitmap = Bitmap.new(setting[:width], equips.size * setting[:line_height])
    color1 = Color.new(*setting[:color])
    color2 = Color.new(*setting[:outline])
    self.bitmap.font.color     = color1
    self.bitmap.font.out_color = color2
    self.bitmap.font.bold      = setting[:bold]
    self.bitmap.font.italic    = setting[:italic]
    self.bitmap.font.name      = setting[:font]
    self.bitmap.font.size      = setting[:size]
    equips.each_with_index do |e,i|
      next unless e
      rect1 = Rect.new(25, setting[:line_height] * i, setting[:width] - 26, setting[:line_height])
      rect2 = Rect.new(e.icon_index % 16 * 24, e.icon_index / 16 * 24, 24, 24)
      self.bitmap.blt(1, rect1.y, icon_bit, rect2)
      self.bitmap.draw_text(rect1, e.name)
    end
  end
  
  def icon_bit
    bitmap = Cache.system("Iconset")
  end
  
  def setting
    super[:equips]
  end
end

class LunaMenu_Status
  ##------
  ## * Overwrite setup_hud, update, and item_max for battle members
  ##------
  alias_method :cp_1122014_setup_hud, :setup_hud
  def setup_hud(*a)
    return cp_1122014_setup_hud(*a) unless CPLunaParty::STATUS_MENU[:limit_max]
    @limit.times { |i|
      battler = $game_party.battle_members[i]
      spriteset = Spriteset_MenuStatus.new(@viewport, battler, @setting, i)
      @spritesets.push(spriteset)
    }
  end
  
  alias_method :cp_1122014_update, :update
  def update
    return cp_1122014_update(*a) unless CPLunaParty::STATUS_MENU[:limit_max]
    update_top_row
    @spritesets.each_with_index { |spriteset, index|
      spriteset.battler = $game_party.battle_members[index + @top]
    }
    @spritesets.each { |spriteset| spriteset.update }
  end
end

class Window_MenuStatus < Window_Selectable
  def item_max
    if CPLunaParty::STATUS_MENU[:limit_max]
      $game_party.battle_members.size
    else
      $game_party.members.size
    end
  end
end

##------
## * YF's party command window
##------
class Window_PartyMenuCommand < Window_Command
  def initialize(*args)
    @viewport = Viewport.new
    super(*args)
    self.viewport = @viewport
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
    update_cursor
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
  
  def update_cursor
    super
    if setting_cursor[:enable]
      unless @cs_sprite
        @cs_sprite = Sprite.new
        @cs_sprite.bitmap = Cache.system(setting_cursor[:picture])
        @cs_sprite.viewport = @viewport
      end
      if @index >= 0
        @cs_sprite.update
        @cs_sprite.x = self.x + standard_padding + cursor_rect.x - self.ox + setting_cursor[:offset_x]
        @cs_sprite.y = self.y + standard_padding + cursor_rect.y - self.oy + setting_cursor[:offset_y]
        @cs_sprite.z = self.z - 1
        @cs_sprite.opacity = [setting_cursor[:opacity], self.openness].min
        @cs_sprite.visible = self.visible
      else
        @cs_sprite.visible = false
      end
    end
    cursor_rect.empty unless setting[:cursor]
  end
  
  def draw_all_items
    color1 = Color.new(*setting_text[:color])
    color2 = Color.new(*setting_text[:outline])
    self.contents.font.color     = color1
    self.contents.font.out_color = color2
    self.contents.font.bold      = setting_text[:bold]
    self.contents.font.italic    = setting_text[:italic]
    self.contents.font.name      = setting_text[:font]
    self.contents.font.size      = setting_text[:size]
    super
  end
  
  def dispose
    @bg_sprite.dispose if @bg_sprite
    @cs_sprite.dispose if @cs_sprite
    super
    @viewport.dispose
  end
  
  def setting
    CPLunaParty::COMMAND_WINDOW
  end
  
  def setting_type
    type = setting[:type]
    setting[eval(":type_#{type}")]
  end
  
  def setting_cursor
    setting[:pic_cursor]
  end
  
  def setting_text
    setting[:text]
  end
end

##------
## * YF's party list window
##------
class Window_PartyList < Window_Selectable
  def initialize(party_window)
    @viewport = Viewport.new
    super(0, 0, window_width, window_height)
    self.viewport = @viewport
    @party_window = party_window
    select(1)
    deactivate
    init_position
    refresh_background
    refresh
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
  
  def item_height
    [setting[:item_height], 0].max
  end
  
  def line_height
    item_height
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
  
  def draw_remove(rect)
    reset_font_settings
    yo = (rect.height - 24) / 2
    draw_icon(Icon.remove_party, rect.x+4, rect.y + yo)
    text = YEA::PARTY::REMOVE_TEXT
    draw_text(rect.x+32, rect.y, rect.width-32, line_height, text)
  end
  
  def draw_actor_locked(actor, rect)
    return unless actor.locked
    yo = (rect.height - 24) / 2
    draw_icon(Icon.locked_party, rect.width-24, rect.y + yo)
  end
  
  def draw_actor_required(actor, rect)
    return if actor.locked
    return unless actor.required
    yo = (rect.height - 24) / 2
    draw_icon(Icon.required_party, rect.width-24, rect.y + yo)
  end
  
  def update
    super
    type = setting[:type]
    case type
    when 0; update_type0
    when 1; update_type1
    when 2; update_type2
    end
    update_cursor
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
  
  def update_cursor
    super
    if setting_cursor[:enable]
      unless @cs_sprite
        @cs_sprite = Sprite.new
        @cs_sprite.bitmap = Cache.system(setting_cursor[:picture])
        @cs_sprite.viewport = @viewport
      end
      if @index >= 0
        @cs_sprite.update
        @cs_sprite.x = self.x + standard_padding + cursor_rect.x - self.ox + setting_cursor[:offset_x]
        @cs_sprite.y = self.y + standard_padding + cursor_rect.y - self.oy + setting_cursor[:offset_y]
        @cs_sprite.z = self.z - 1
        @cs_sprite.opacity = [setting_cursor[:opacity], self.openness].min
        @cs_sprite.visible = self.visible
      else
        @cs_sprite.visible = false
      end
    end
    cursor_rect.empty unless setting[:cursor]
  end
  
  def reset_font_settings
    super
    self.contents.font.bold      = setting_text[:bold]
    self.contents.font.italic    = setting_text[:italic]
    self.contents.font.name      = setting_text[:font]
    self.contents.font.size      = setting_text[:size]
  end
  
  def list_colour(actor)
    if in_party?(actor)
      color1 = Color.new(*setting_text[:party_color])
      color2 = Color.new(*setting_text[:party_outline])
    else
      color1 = Color.new(*setting_text[:reserve_color])
      color2 = Color.new(*setting_text[:reserve_outline])
    end
    self.contents.font.out_color = color2
    return color1
  end
  
  def dispose
    @bg_sprite.dispose if @bg_sprite
    @cs_sprite.dispose if @cs_sprite
    super
    @viewport.dispose
  end
  
  def setting
    CPLunaParty::RESERVE_WINDOW
  end
  
  def setting_type
    type = setting[:type]
    setting[eval(":type_#{type}")]
  end
  
  def setting_cursor
    setting[:pic_cursor]
  end
  
  def setting_text
    setting[:text]
  end
end

##------
## * YF's party selection window
##   This is the top right window in the menu
##------
class Window_PartySelect < Window_Selectable
  def initialize(command_window)
    @command_window = command_window
    @viewport = Viewport.new
    @spritesets = []
    super(0, 0, window_width, window_height)
    self.viewport = @viewport
    select(0)
    deactivate
    init_position
    refresh_background
    refresh
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
  
  def standard_padding
    [setting[:padding], 0].max
  end
  
  def col_max
    setting_status[:vertical] ? 1 : item_max
  end
  
  def spacing
    [setting_status[:spacing], 0].max
  end
  
  def item_width
    [setting_status[:width], 0].max
  end
  
  def item_height
    [setting_status[:height], 0].max
  end
  
  def item_rect(index)
    rect = Rect.new
    rect.width = setting_status[:width]
    rect.height = setting_status[:height]
    if setting_status[:vertical]
      rect.x = 0
      rect.y = index * (setting_status[:height] + setting_status[:spacing])
    else
      rect.x = index * (setting_status[:width] + setting_status[:spacing])
      rect.y = 0
    end
    rect.x += eval(setting_status[:offset_x])
    rect.y += eval(setting_status[:offset_y])
    return rect
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
    update_cursor
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
  
  def update_cursor
    super
    if setting_cursor[:enable]
      unless @cs_sprite
        @cs_sprite = Sprite.new
        @cs_sprite.bitmap = Cache.system(setting_cursor[:picture])
      end
      if @index >= 0
        @cs_sprite.update
        @cs_sprite.x = self.x + standard_padding + cursor_rect.x - self.ox + setting_cursor[:offset_x]
        @cs_sprite.y = self.y + standard_padding + cursor_rect.y - self.oy + setting_cursor[:offset_y]
        @cs_sprite.z = self.z - 1
        @cs_sprite.opacity = [setting_cursor[:opacity], self.openness].min
        @cs_sprite.visible = self.visible
      else
        @cs_sprite.visible = false
      end
    end
    cursor_rect.empty unless setting[:cursor]
  end
  
  def update_spritesets
    @spritesets.each_with_index do |set,i|
      set.rect = item_rect(i)
      set.highlight = (i == self.index || self.cursor_all) && self.active
      set.update
    end
  end
  
  def refresh
    make_item_list
    @spritesets.each { |set| set.dispose }
    @spritesets.clear
    @data.each { |a| @spritesets.push(CPLunaParty_Spriteset.new(self, @viewport, a)) }
    update_spritesets
  end
  
  def dispose
    @bg_sprite.dispose if @bg_sprite
    @cs_sprite.dispose if @cs_sprite
    @spritesets.each { |set| set.dispose }
    super
    @viewport.dispose
  end
  
  def setting
    CPLunaParty::PARTY_WINDOW
  end
  
  def setting_type
    type = setting[:type]
    setting[eval(":type_#{type}")]
  end
  
  def setting_cursor
    setting[:pic_cursor]
  end
  
  def setting_status
    setting[:status]
  end
end

##------
## * Spriteset for the top left window
##------
class CPLunaParty_Spriteset
  attr_accessor :highlight
  
  def initialize(parent, viewport, actor = 0)
    @parent   = parent
    @viewport = viewport
    @actor = actor
    @layers = []
    @x = @y = 0
    @highlight = false
    refresh
  end
  
  def dispose
    @layers.each { |layer| layer.dispose }
    @layers.clear
  end
  
  def update
    @layers.each do |layer|
      layer.update
      layer.selected = @highlight
    end
  end
  
  def refresh
    dispose
    [:main, :select, :character, :face, :name, :class, :level, :empty, :hp_bar,
     :mp_bar, :tp_bar, :hp_num, :mp_num, :tp_num, :hp_max, :mp_max,
     :tp_max].each do |layer|
      create_layer(layer)
    end
  end
  
  def create_layer(layer)
    return unless @parent.setting[layer] && @parent.setting[layer][:enable]
    case layer
    when :main;      obj = CPLPartyMain
    when :select;    obj = CPLPartySelect
    when :character; obj = CPLPartyChara
    when :face;      obj = CPLPartyFace
    when :name;      obj = CPLPartyName
    when :class;     obj = CPLPartyClass
    when :level;     obj = CPLPartyLevel
    when :empty;     obj = CPLPartyEmpty
    when :hp_bar;    obj = CPLPartyHPBar
    when :mp_bar;    obj = CPLPartyMPBar
    when :tp_bar;    obj = CPLPartyTPBar
    when :hp_num;    obj = CPLPartyHPNum
    when :mp_num;    obj = CPLPartyMPNum
    when :tp_num;    obj = CPLPartyTPNum
    when :hp_max;    obj = CPLPartyHPMax
    when :mp_max;    obj = CPLPartyMPMax
    when :tp_max;    obj = CPLPartyTPMax
    else; return
    end
    @layers.push(obj.new(@viewport, @actor, CPLunaParty::PARTY_WINDOW))
  end
  
  def actor=(actor)
    @actor = actor
    refresh
  end
  
  def rect=(rect)
    @x = @parent.x + @parent.padding + rect.x - @parent.ox
    @y = @parent.y + @parent.padding + rect.y - @parent.oy
    @layers.each { |layer| layer.pos(@x, @y) }
  end
end

##------
## * YF's party status window
##------
class Window_PartyStatus < Window_Base
  def initialize(party_window, list_window)
    @viewport = Viewport.new
    super(0, 0, window_width, window_height)
    self.viewport = @viewport
    @party_window = party_window
    @list_window = list_window
    @actor = active_actor
    init_position
    refresh_background
    refresh
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
  
  def update
    super
    refresh if @actor != active_actor
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
  
  def refresh
    @actor = active_actor
    @spritesets.dispose if @spritesets
    @spritesets = CPLunaPartyActor_Spriteset.new(self, @viewport, @actor)
    update_spritesets
  end
  
  def dispose
    @bg_sprite.dispose if @bg_sprite
    @cs_sprite.dispose if @cs_sprite
    @spritesets.dispose if @spritesets
    super
    @viewport.dispose
  end
  
  def setting
    CPLunaParty::ACTOR_WINDOW
  end
  
  def setting_type
    type = setting[:type]
    setting[eval(":type_#{type}")]
  end
  
  def setting_cursor
    setting[:pic_cursor]
  end
  
  def setting_status
    setting[:status]
  end
end

##------
## * Spriteset for the status window
##------
class CPLunaPartyActor_Spriteset
  def initialize(parent, viewport, actor = 0)
    @parent   = parent
    @viewport = viewport
    @actor = actor || 0
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
    [:main, :face, :name, :class, :nickname, :level, :empty, :hp_bar, :mp_bar,
     :tp_bar, :hp_num, :mp_num, :tp_num, :hp_max, :mp_max, :tp_max, :states,
     :statsn, :statsv, :equips].each do |layer|
      create_layer(layer)
    end
  end
  
  def create_layer(layer)
    check = [:statsn, :statsv].include?(layer) ? :stats : layer
    return unless @parent.setting[check] && @parent.setting[check][:enable]
    case layer
    when :main;      obj = CPLPartyMain
    when :face;      obj = CPLPartyFace
    when :name;      obj = CPLPartyName
    when :class;     obj = CPLPartyClass
    when :nickname;  obj = CPLPartyNickname
    when :level;     obj = CPLPartyLevel
    when :empty;     obj = CPLPartyEmpty
    when :hp_bar;    obj = CPLPartyHPBar
    when :mp_bar;    obj = CPLPartyMPBar
    when :tp_bar;    obj = CPLPartyTPBar
    when :hp_num;    obj = CPLPartyHPNum
    when :mp_num;    obj = CPLPartyMPNum
    when :tp_num;    obj = CPLPartyTPNum
    when :hp_max;    obj = CPLPartyHPMax
    when :mp_max;    obj = CPLPartyMPMax
    when :tp_max;    obj = CPLPartyTPMax
    when :states;    obj = CPLPartyStates
    when :statsn;    obj = CPLPartyStatsN
    when :statsv;    obj = CPLPartyStatsV
    when :equips;    obj = CPLPartyEquips
    else; return
    end
    @layers.push(obj.new(@viewport, @actor, CPLunaParty::ACTOR_WINDOW))
  end
end

##-----------------------------------------------------------------------------
##  End of script.
##-----------------------------------------------------------------------------