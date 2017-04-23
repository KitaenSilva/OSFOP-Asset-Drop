##-----------------------------------------------------------------------------
## Luna Engine - Easy Status Menu Add-on
## Created by Neon Black - 10.18.2013
##
## CORE HALF
##   - Requires the config half above it to work.
##
## This script is the first half of a 2 part script that allows the status
## menu to be customized without the need to use lunatic customization.  The
## status menu may be easily customized using commands similar to the rest of
## the Luna engine.  To use this script place the script anywhere below
## "▼ Materials" and above "▼ Main Process".  When using the Luna Engine Menu
## script, both pieces must go BELOW the Luna Engine.
##
##  ▼ Materials
##   Yami's Luna Menu
##   Neon's Luna Status Config
##   Neon's Luna Status Core
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
class CPLStatusObject < Sprite
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
    @actor
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
class CPLStatusMain < CPLStatusObject
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
    super[symbol]
  end
  
  def symbol
    :main1
  end
end

class CPLStatusMain2 < CPLStatusMain
  def symbol
    :main2
  end
end

##------
## * Face sprite
##------
class CPLStatusFace < CPLStatusObject
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
class CPLStatusName < CPLStatusObject
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
class CPLStatusClass < CPLStatusObject
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
class CPLStatusNickname < CPLStatusObject
  def make_object_bitmap
    vocab = battler ? battler.nickname : ""
    make_text_sprite(vocab)
  end
  
  def setting
    super[:nickname]
  end
end

##------
## * Level sprite
##------
class CPLStatusLevel < CPLStatusObject
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
class CPLStatusBar < CPLStatusObject
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
class CPLStatusHPBar < CPLStatusBar
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
class CPLStatusMPBar < CPLStatusBar
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
class CPLStatusTPBar < CPLStatusBar
  def setting
    super[:tp_bar]
  end
  
  def rate
    return battler.tp_rate
  end
end

##------
## * XP bar sprite
##------
class CPLStatusXPBar < CPLStatusBar
  def setting
    super[:xp_bar]
  end
  
  def rate
    return battler.xp_rate
  end
end

##------
## * Min/max sprite base object for HP and such
##------
class CPLStatusMinMax < CPLStatusObject
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
class CPLStatusHPNum < CPLStatusMinMax
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
class CPLStatusMPNum < CPLStatusMinMax
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
class CPLStatusTPNum < CPLStatusMinMax
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
## * Current XP value sprite
##------
class CPLStatusXPNum < CPLStatusMinMax
  def make_object_bitmap
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    end
  end
  
  def object_map_0
    full = setting_type[:max_level]
    vocab = setting[:vocab].clone
    if setting[:total_exp]
      bot = battler.exp
      top = battler.next_level_exp
    else
      bot = battler.this_level_exp
      top = battler.level_up_exp
    end
    vocab.gsub!(/<c>/i, battler.max_level? ? full : bot.to_s)
    vocab.gsub!(/<m>/i, battler.max_level? ? full : top.to_s)
    make_text_sprite(vocab)
  end
  
  def object_map_1
    return make_frame_sprite(0) if battler.max_level?
    number = setting[:total_exp] ? battler.exp : battler.this_level_exp
    make_frame_sprite(number)
  end
  
  def setting
    super[:xp_num]
  end
end

##------
## * Max HP value sprite
##------
class CPLStatusHPMax < CPLStatusMinMax
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
class CPLStatusMPMax < CPLStatusMinMax
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
class CPLStatusTPMax < CPLStatusMinMax
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
## * Max XP value sprite
##------
class CPLStatusXPMax < CPLStatusMinMax
  def make_object_bitmap
    type = setting[:type]
    case type
    when 0; object_map_0
    when 1; object_map_1
    end
  end
  
  def object_map_0
    if setting[:total_exp]
      vocab = battler.max_level ? battler.next_level_exp.to_s : setting_type[:max_level]
    else
      vocab = battler.max_level ? battler.level_up_exp.to_s : setting_type[:max_level]
    end
    make_text_sprite(vocab)
  end
  
  def object_map_1
    return make_frame_sprite(0) if battler.max_level?
    number = setting[:total_exp] ? battler.next_level_exp : battler.level_up_exp
    make_frame_sprite(number)
  end
  
  def setting
    super[:xp_max]
  end
end

##------
## * State object sprite
##------
class CPLStatusStates < CPLStatusObject
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
## * Stat name object sprite
##------
class CPLStatusStatsN < CPLStatusObject
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
    super[symbol]
  end
  
  def symbol
    :stats1
  end
  
  def setting_type
    setting[:names]
  end
end

class CPLStatusStatsN2 < CPLStatusStatsN
  def symbol
    :stats2
  end
end

##------
## * Stat values object sprite
##------
class CPLStatusStatsV < CPLStatusObject
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
      vocab = "#{(vocab * 100).round}%" if per_stats.include?(s)
      rect = Rect.new(1, setting[:line_height] * i, setting[:width] - 2, setting[:line_height])
      self.bitmap.draw_text(rect, vocab, setting_type[:align])
    end
  end
  
  def per_stats
    [:hit, :eva, :cri, :cev, :mev, :mrf, :cnt, :hrg, :mrg, :trg, :tgr, :grd,
     :rec, :pha, :mcr, :tcr, :pdr, :mdr, :fdr, :exr]
  end
  
  def setting
    super[symbol]
  end
  
  def symbol
    :stats1
  end
  
  def setting_type
    setting[:values]
  end
end

class CPLStatusStatsV2 < CPLStatusStatsV
  def symbol
    :stats2
  end
end

##------
## * Equips object sprite
##------
class CPLStatusEquips < CPLStatusObject
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

##------
## * Actor element name stats
##------
class CPLStatusElemN < CPLStatusObject
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
    self.bitmap = Bitmap.new(setting[:width], setting[:elements].size * setting[:line_height])
    return unless battler
    color1 = Color.new(*setting_type[:color])
    color2 = Color.new(*setting_type[:outline])
    self.bitmap.font.color     = color1
    self.bitmap.font.out_color = color2
    self.bitmap.font.bold      = setting_type[:bold]
    self.bitmap.font.italic    = setting_type[:italic]
    self.bitmap.font.name      = setting_type[:font]
    self.bitmap.font.size      = setting_type[:size]
    setting[:elements].each_with_index do |s,i|
      vocab = $data_system.elements[s]
      rect = Rect.new(1, setting[:line_height] * i, setting[:width] - 2, setting[:line_height])
      self.bitmap.draw_text(rect, vocab, setting_type[:align])
    end
  end
  
  def setting
    super[:elements]
  end
  
  def setting_type
    setting[:names]
  end
end

##------
## * Actor element values stats
##------
class CPLStatusElemV < CPLStatusObject
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
    self.bitmap = Bitmap.new(setting[:width], setting[:elements].size * setting[:line_height])
    return unless battler
    color1 = Color.new(*setting_type[:color])
    color2 = Color.new(*setting_type[:outline])
    self.bitmap.font.color     = color1
    self.bitmap.font.out_color = color2
    self.bitmap.font.bold      = setting_type[:bold]
    self.bitmap.font.italic    = setting_type[:italic]
    self.bitmap.font.name      = setting_type[:font]
    self.bitmap.font.size      = setting_type[:size]
    setting[:elements].each_with_index do |s,i|
      vocab = battler.element_rate(s)
      vocab = "#{(vocab * 100).round}%"
      rect = Rect.new(1, setting[:line_height] * i, setting[:width] - 2, setting[:line_height])
      self.bitmap.draw_text(rect, vocab, setting_type[:align])
    end
  end
  
  def setting
    super[:elements]
  end
  
  def setting_type
    setting[:values]
  end
end

##------
## * Actor rate name stats
##------
class CPLStatusRateN < CPLStatusObject
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
    self.bitmap = Bitmap.new(setting[:width], setting[:states].size * setting[:line_height])
    return unless battler
    color1 = Color.new(*setting_type[:color])
    color2 = Color.new(*setting_type[:outline])
    self.bitmap.font.color     = color1
    self.bitmap.font.out_color = color2
    self.bitmap.font.bold      = setting_type[:bold]
    self.bitmap.font.italic    = setting_type[:italic]
    self.bitmap.font.name      = setting_type[:font]
    self.bitmap.font.size      = setting_type[:size]
    setting[:states].each_with_index do |s,i|
      vocab = $data_states[s].name
      rect = Rect.new(1, setting[:line_height] * i, setting[:width] - 2, setting[:line_height])
      self.bitmap.draw_text(rect, vocab, setting_type[:align])
    end
  end
  
  def setting
    super[:rates]
  end
  
  def setting_type
    setting[:names]
  end
end

##------
## * Actor rate values stats
##------
class CPLStatusRateV < CPLStatusObject
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
    self.bitmap = Bitmap.new(setting[:width], setting[:states].size * setting[:line_height])
    return unless battler
    color1 = Color.new(*setting_type[:color])
    color2 = Color.new(*setting_type[:outline])
    self.bitmap.font.color     = color1
    self.bitmap.font.out_color = color2
    self.bitmap.font.bold      = setting_type[:bold]
    self.bitmap.font.italic    = setting_type[:italic]
    self.bitmap.font.name      = setting_type[:font]
    self.bitmap.font.size      = setting_type[:size]
    setting[:states].each_with_index do |s,i|
      vocab = battler.state_rate(s)
      vocab = "#{(vocab * 100).round}%"
      rect = Rect.new(1, setting[:line_height] * i, setting[:width] - 2, setting[:line_height])
      self.bitmap.draw_text(rect, vocab, setting_type[:align])
    end
  end
  
  def setting
    super[:rates]
  end
  
  def setting_type
    setting[:values]
  end
end

##------
## * Actor description object
##------
class CPLStatusDescribe < CPLStatusObject
  def make_object_bitmap
    vocab = battler ? battler.description : ""
    make_text_sprite(vocab)
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
    rect.height = setting[:line_height]
    text.split(/[\r\n]+/).each_with_index do |line,i|
      rect.y = setting[:line_height] * i
      self.bitmap.draw_text(rect, line, setting[:align])
    end
  end
  
  def setting
    super[:describe]
  end
end

##------
## * New actor methods
##------
class Game_Actor < Game_Battler  
  def this_level_exp
    exp - current_level_exp
  end
  
  def level_up_exp
    next_level_exp - current_level_exp
  end
  
  def xp_rate
    return 1.0 if max_level?
    this_level_exp.to_f / level_up_exp
  end
end

##------
## * Main window for the status screen
##------
class Window_Status < Window_Selectable
  attr_accessor :front_page
  
  def initialize(actor)
    @viewport = Viewport.new
    super(0, 0, window_width, window_height)
    self.viewport = @viewport
    @actor = actor
    @front_page = true
    init_position
    refresh_background
    refresh
    activate
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
    type = setting[:type]
    case type
    when 0; update_type0
    when 1; update_type1
    when 2; update_type2
    end
    change_page if setting[:switch_button] && Input.trigger?(setting[:switch_button])
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
  
  def change_page
    Sound.play_cursor
    @front_page = !@front_page
  end
  
  def update_spritesets
    @spritesets.update if @spritesets
  end
  
  def refresh
    @spritesets.dispose if @spritesets
    @spritesets = CPLunaStatus_Spriteset.new(self, @viewport, @actor)
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
    CPLunaStatus::STATUS_WINDOW
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
class CPLunaStatus_Spriteset
  def initialize(parent, viewport, actor = 0)
    @parent   = parent
    @viewport = viewport
    @actor = actor || 0
    @layers = {}
    refresh
  end
  
  def dispose
    @layers.each_value { |layer| layer.dispose }
    @layers.clear
  end
  
  def update
    layer_visibility
    @layers.each_value do |layer|
      layer.update
      layer.pos(@parent.x, @parent.y)
    end
  end
  
  def layer_visibility
    page1 = CPLunaStatus::STATUS_WINDOW[:page1]
    page1 += [:statsn1, :statsv1] if page1.include?(:stats1)
    page1 += [:statsn2, :statsv2] if page1.include?(:stats2)
    page1 += [:elemsn,  :elemsv ] if page1.include?(:elements)
    page1 += [:ratesn,  :ratesv ] if page1.include?(:rates)
    page2 = CPLunaStatus::STATUS_WINDOW[:page2]
    page2 += [:statsn1, :statsv1] if page2.include?(:stats1)
    page2 += [:statsn2, :statsv2] if page2.include?(:stats2)
    page2 += [:elemsn,  :elemsv ] if page2.include?(:elements)
    page2 += [:ratesn,  :ratesv ] if page2.include?(:rates)
    @layers.each do |k,l|
      next unless (page1 + page2).include?(k)
      if page1.include?(k)
        l.visible = @parent.front_page
      else
        l.visible = !@parent.front_page
      end
    end
  end
  
  def refresh
    dispose
    [:main1, :main2, :face, :name, :class, :nickname, :level, :hp_bar, :mp_bar,
     :tp_bar, :xp_bar, :hp_num, :mp_num, :tp_num, :xp_num, :hp_max, :mp_max,
     :tp_max, :xp_max, :states, :statsn1, :statsv1, :statsn2, :statsv2, :equips,
     :elemsn, :elemsv, :ratesn, :ratesv, :describe].each do |layer|
      create_layer(layer)
    end
    layer_visibility
  end
  
  def create_layer(layer)
    check = [:statsn1, :statsv1].include?(layer) ? :stats1   : layer
    check = [:statsn2, :statsv2].include?(layer) ? :stats2   : check
    check = [:elemsn,  :elemsv ].include?(layer) ? :elements : check
    check = [:ratesn,  :ratesv ].include?(layer) ? :rates    : check
    return unless @parent.setting[check] && @parent.setting[check][:enable]
    case layer
    when :main1;     obj = CPLStatusMain
    when :main2;     obj = CPLStatusMain2
    when :face;      obj = CPLStatusFace
    when :name;      obj = CPLStatusName
    when :class;     obj = CPLStatusClass
    when :nickname;  obj = CPLStatusNickname
    when :level;     obj = CPLStatusLevel
    when :hp_bar;    obj = CPLStatusHPBar
    when :mp_bar;    obj = CPLStatusMPBar
    when :tp_bar;    obj = CPLStatusTPBar
    when :xp_bar;    obj = CPLStatusXPBar
    when :hp_num;    obj = CPLStatusHPNum
    when :mp_num;    obj = CPLStatusMPNum
    when :tp_num;    obj = CPLStatusTPNum
    when :xp_num;    obj = CPLStatusXPNum
    when :hp_max;    obj = CPLStatusHPMax
    when :mp_max;    obj = CPLStatusMPMax
    when :tp_max;    obj = CPLStatusTPMax
    when :xp_max;    obj = CPLStatusXPMax
    when :states;    obj = CPLStatusStates
    when :statsn1;   obj = CPLStatusStatsN
    when :statsv1;   obj = CPLStatusStatsV
    when :statsn2;   obj = CPLStatusStatsN2
    when :statsv2;   obj = CPLStatusStatsV2
    when :equips;    obj = CPLStatusEquips
    when :elemsn;    obj = CPLStatusElemN
    when :elemsv;    obj = CPLStatusElemV
    when :ratesn;    obj = CPLStatusRateN
    when :ratesv;    obj = CPLStatusRateV
    when :describe;  obj = CPLStatusDescribe
    else; return
    end
    @layers[layer] = obj.new(@viewport, @actor, CPLunaStatus::STATUS_WINDOW)
  end
end

##------
## * Frame object for non-default backgrounds
##------
class CPLunaStatus_Frame < Plane
  def initialize(id, battler)
    super(Viewport.new)
    @id = id
    vocab = setting_type[:frames][@id].gsub(/<id>/i, battler.id.to_s)
    vocab.gsub!(/<cid>/i, battler.class.id.to_s)
    self.bitmap = Cache.system(vocab)
    init_position
  end
  
  def init_position
    self.viewport.rect.x      = setting_type[:offset_x][@id]
    self.viewport.rect.y      = setting_type[:offset_y][@id]
    self.viewport.rect.width  = setting_type[:width][@id]
    self.viewport.rect.height = setting_type[:height][@id]
    self.viewport.z           = setting_type[:offset_z][@id]
    self.blend_type           = setting_type[:blending][@id]
  end
  
  def actor=(battler)
    vocab = setting_type[:frames][@id].gsub(/<id>/i, battler.id.to_s)
    vocab.gsub!(/<cid>/i, battler.class.id.to_s)
    self.bitmap = Cache.system(vocab)
  end
  
  def update
    self.ox += setting_type[:pan_x][@id]
    self.oy += setting_type[:pan_y][@id]
  end
  
  def setting
    CPLunaStatus::STATUS_BACKGROUND[:background]
  end
  
  def setting_type
    type = setting[:type]
    setting[eval(":type_#{type}")]
  end
end

##------
## * Updated scene status
##------
class Scene_Status < Scene_MenuBase
  def create_background
    @actor = $game_party.menu_actor
    type = setting[:type]
    case type
    when 0; create_type0
    when 1; create_type1
    end
  end
  
  def create_type0
    @background_sprite = [Sprite.new]
    @background_sprite[0].bitmap = SceneManager.background_bitmap
    @background_sprite[0].color.set(*setting_type[:color])
  end
  
  def create_type1
    @color_background_sprite = [Sprite.new]
    @color_background_sprite[0].bitmap = SceneManager.background_bitmap
    @color_background_sprite[0].color.set(*setting_type[:map_color])
    @background_sprite = []
    setting_type[:frames].each_with_index do |_,i|
      @background_sprite.push(CPLunaStatus_Frame.new(i, @actor))
    end
  end
  
  def dispose_background
    @background_sprite.each { |back| back.dispose }
  end
  
  def update
    super
    update_background
  end
  
  def update_background
    @background_sprite.each { |back| back.update }
  end
  
  def on_actor_change
    @status_window.actor = @actor
    @status_window.activate
    return unless setting[:type] == 1
    @background_sprite.each { |back| back.actor = @actor }
  end
  
  def setting
    CPLunaStatus::STATUS_BACKGROUND[:background]
  end
  
  def setting_type
    type = setting[:type]
    setting[eval(":type_#{type}")]
  end
end

##-----------------------------------------------------------------------------
##  End of script.
##-----------------------------------------------------------------------------