#==============================================================================
# ■ YEA: Victory Color Changer 
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This allows you to change the color of specific windows.
# This is not absolutely necessary and can be deleted.
#==============================================================================
# ■ Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Just change the "COLOR" RGBA values.
#==============================================================================
class Window_VictoryEXP_Back < Window_Selectable
  
  COLOR = Color.new(0,0,0,255)
  
  def draw_exp_gain(actor, rect)
    dw = rect.width - (rect.width - [rect.width, 96].min) / 2
    dy = rect.y + line_height * 3 + 96
    fmt = YEA::VICTORY_AFTERMATH::VICTORY_EXP
    text = sprintf(fmt, actor_exp_gain(actor).group)
    contents.font.size = YEA::VICTORY_AFTERMATH::FONTSIZE_EXP
    change_color(COLOR)
    draw_text(rect.x, dy, dw, line_height, text, 2)
  end
  
end

class Window_VictoryEXP_Front < Window_VictoryEXP_Back
  
  COLOR = Color.new(0,0,0,255)
  
  def draw_exp_gauge(actor, rect, rate)
    change_color(COLOR)
    rate = [[rate, 1.0].min, 0.0].max
    dx = (rect.width - [rect.width, 96].min) / 2 + rect.x
    dy = rect.y + line_height * 2 + 96
    dw = [rect.width, 96].min
    colour1 = rate >= 1.0 ? lvl_gauge1 : exp_gauge1
    colour2 = rate >= 1.0 ? lvl_gauge2 : exp_gauge2
    draw_gauge(dx, dy, dw, rate, colour1, colour2)
    fmt = YEA::VICTORY_AFTERMATH::EXP_PERCENT
    text = sprintf(fmt, [rate * 100, 100.00].min)
    if [rate * 100, 100.00].min == 100.00
      text = YEA::VICTORY_AFTERMATH::LEVELUP_TEXT
      text = YEA::VICTORY_AFTERMATH::MAX_LVL_TEXT if actor.max_level?
    end
    draw_text(dx, dy, dw, line_height, text, 1)
  end
  
end

class Window_VictoryTitle < Window_Base
  
  COLOR = Color.new(0,0,0,255)
  def refresh(message = "")
    contents.clear
    change_color(COLOR)
    draw_text(0, 0, contents.width, line_height, message, 1)
  end
  
end