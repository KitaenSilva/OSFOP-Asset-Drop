#==============================================================================
# ■ BattleLuna: Animated Face AddOn
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This script allows you to have animated faces.
#==============================================================================
# ■ Lunatic Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# type 0 (default faceset) only supports 96 * 96 frame, also it should be 
# 4 frames per row
#
# type 1 or 2 supports any kind of frame size, but all frames should be in the
# same row
#
# All animated faces should have the suffix [AF FRAME-FPS LOOP]
# where FRAME is number of frames, FPS is delay between frame
# LOOP is optional.
# example: Face1[AF 10-5 LOOP]
#          Face2[AF 8-2]
#==============================================================================

#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================

#==============================================================================
# ■ SpriteHUD_Face
#==============================================================================

class SpriteHUD_Face < Sprite_Base
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  alias battle_luna_animated_face_initialize initialize
  def initialize(viewport, spriteset)
    battle_luna_animated_face_initialize(viewport, spriteset)
    init_animated
  end
  
  #--------------------------------------------------------------------------
  # new method: init_animated
  #--------------------------------------------------------------------------
  def init_animated
    @cfps = 0
    @fps = 0
    @cframe = 0
    @frame = 0
    @loop = false
    @sw = 0
    @sh = 0
  end
  
  #--------------------------------------------------------------------------
  # alias method: refresh_type0
  #--------------------------------------------------------------------------
  alias battle_luna_animated_face_refresh_type0 refresh_type0
  def refresh_type0
    battle_luna_animated_face_refresh_type0
    @frame = @battler.face_index
    if @face[0] =~ /.*\[AF (\d+)-(\d+)[ ]*(LOOP)?\]/i
      @frame = @face[1]
      @cframe = $1.to_i
      @fps = @cfps = $2.to_i
      @loop = ($3.upcase == "LOOP") rescue false
    else
      @cframe = @cfps = 0
      @loop = 0
      @frame = @battler.face_index
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: faceset_name
  #--------------------------------------------------------------------------
  alias battle_luna_animated_faceset_name faceset_name
  def faceset_name
    result = battle_luna_animated_faceset_name
    result[1] = @frame if @cframe > 0
    return result
  end
  
  #--------------------------------------------------------------------------
  # alias method: refresh_type1
  #--------------------------------------------------------------------------
  alias battle_luna_animated_face_refresh_type1 refresh_type1
  def refresh_type1
    battle_luna_animated_face_refresh_type1
    @frame = 0
    if @face[0] =~ /.*\[AF (\d+)-(\d+)[ ]*(LOOP)?\]/i
      @cframe = $1.to_i
      @fps = @cfps = $2.to_i
      @loop = ($3.upcase == "LOOP") rescue false
      @sw = self.bitmap.width / @cframe
      @sh = self.bitmap.height
    else
      @cframe = @cfps = 0
      @loop = 0
      @frame = 0
      @sw = self.bitmap.width
      @sh = self.bitmap.height
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: refresh_type2
  #--------------------------------------------------------------------------
  alias battle_luna_animated_face_refresh_type2 refresh_type2
  def refresh_type2
    battle_luna_animated_face_refresh_type2
    @frame = 0
    if @face[0] =~ /.*\[AF (\d+)-(\d+)[ ]*(LOOP)?\]/i
      @cframe = $1.to_i
      @fps = @cfps = $2.to_i
      @loop = ($3.upcase == "LOOP") rescue false
      @sw = self.bitmap.width / @cframe
      @sh = self.bitmap.height
    else
      @cframe = @cfps = 0
      @loop = 0
      @frame = 0
      @sw = self.bitmap.width
      @sh = self.bitmap.height
    end
  end
  
  #--------------------------------------------------------------------------
  # alias method: update
  #--------------------------------------------------------------------------
  alias battle_luna_animated_face_update update
  def update
    return unless setting[:enable]
    battle_luna_animated_face_update
    #---
    update_animate
    update_rect
  end
  
  #--------------------------------------------------------------------------
  # new method: update_animate
  #--------------------------------------------------------------------------
  def update_animate
    return unless @cframe > 0
    @fps -= 1
    return unless @fps <= 0
    @fps = @cfps
    return if !@loop && @frame + 1 == @cframe
    @frame = (@frame + 1) % @cframe
  end
  
  #--------------------------------------------------------------------------
  # new method: update_rect
  #--------------------------------------------------------------------------
  def update_rect
    return if setting[:type] == 0
    self.src_rect.set(@sw * @frame, 0, @sw, @sh)
  end
  
end # SpriteHUD_Face 