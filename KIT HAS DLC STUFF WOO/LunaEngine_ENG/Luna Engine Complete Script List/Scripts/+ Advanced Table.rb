#==============================================================================
# ■ MenuLuna: Advanced Table Settings
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This allows you to modify the alphabet Table.
# Use at your own risk. 
#
# Make sure that 'OK' in the table, 'Page' is optional and will change to page
# number should it be disabled.
#==============================================================================

class Window_NameInput < Window_Selectable
  
  #--------------------------------------------------------------------------
  # * Character Tables (Latin)
  #--------------------------------------------------------------------------
  LATIN1 = [ 'A','B','C','D','E',  'a','b','c','d','e',
             'F','G','H','I','J',  'f','g','h','i','j',
             'K','L','M','N','O',  'k','l','m','n','o',
             'P','Q','R','S','T',  'p','q','r','s','t',
             'U','V','W','X','Y',  'u','v','w','x','y',
             'Z',' ',' ',' ',' ',  'z',' ',' ',' ','OK',]
  LATIN2 = [ 'Á','É','Í','Ó','Ú',  'á','é','í','ó','ú',
             'À','È','Ì','Ò','Ù',  'à','è','ì','ò','ù',
             'Â','Ê','Î','Ô','Û',  'â','ê','î','ô','û',
             'Ä','Ë','Ï','Ö','Ü',  'ä','ë','ï','ö','ü',
             'Ā','Ē','Ī','Ō','Ū',  'ā','ē','ī','ō','ū',
             'Ã','Å','Æ','Ç','Ð',  'ã','å','æ','ç','ð',
             'Ñ','Õ','Ø','Š','Ŵ',  'ñ','õ','ø','š','ŵ',
             'Ý','Ŷ','Ÿ','Ž','Þ',  'ý','ÿ','ŷ','ž','þ',
             'Ĳ','Œ','ĳ','œ','ß',  '«','»',' ','Page','OK']
             
#==============================================================================
# ▼ Editting anything past this point may potentially result in causing
# computer damage, incontinence, explosion of user's head, coma, death, and/or
# halitosis so edit at your own risk.
#==============================================================================
  #--------------------------------------------------------------------------
  # * Get Text Character
  #--------------------------------------------------------------------------
  def character
    ['Page', 'OK'].include?(table[@page][@index]) ? "" : table[@page][@index]
  end
  
  #--------------------------------------------------------------------------
  # * Determining if Page Changed and Cursor Location
  #--------------------------------------------------------------------------
  def is_page_change?
    table[@page][@index] == 'Page'
  end
  
  #--------------------------------------------------------------------------
  # * Determine Cursor Location: Confirmation
  #--------------------------------------------------------------------------
  def is_ok?
    table[@page][@index] == 'OK'
  end
  
  #--------------------------------------------------------------------------
  # * Jump to OK
  #--------------------------------------------------------------------------
  def process_jump
    if @index != table[@page].index('OK')
      @index = table[@page].index('OK')
      Sound.play_cursor
    end
  end
  
  #--------------------------------------------------------------------------
  # table_size
  #--------------------------------------------------------------------------
  def table_size
    table[@page].size
  end
  
  #--------------------------------------------------------------------------
  # * Move Cursor Down
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_down(wrap)
    max_round = table_size - (table_size % 10)
    if @index < table_size - (table_size % 10) - 10 or wrap
      @index = (index + 10) % max_round
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move Cursor Up
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_up(wrap)
    max_round = table_size - (table_size % 10)
    if @index >= 10 or wrap
      @index = (index + table_size - (table_size % 10) - 10) % max_round
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move Cursor Right
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_right(wrap)
    if @index % 10 < 9
      @index += 1
    elsif wrap
      @index -= 9
    end
  end
  
  #--------------------------------------------------------------------------
  # * Move Cursor Left
  #     wrap : Wraparound allowed
  #--------------------------------------------------------------------------
  def cursor_left(wrap)
    if @index % 10 > 0
      @index -= 1
    elsif wrap
      @index += 9
    end
  end
  
end # Window_NameInput