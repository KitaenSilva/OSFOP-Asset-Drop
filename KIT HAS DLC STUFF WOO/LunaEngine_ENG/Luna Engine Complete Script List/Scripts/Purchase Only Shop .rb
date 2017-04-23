#==============================================================================
# ■ MenuLuna: Purchase Only Shops
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This script only allows you buy items. No selling.
# Only use this if you want to do that.
#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================

#==============================================================================
# ■ Window_ShopCommand
#==============================================================================

class Window_ShopCommand < Window_HorzCommand
  
  #--------------------------------------------------------------------------
  # alias method: init_screen_x
  #--------------------------------------------------------------------------
  alias menu_luna_poshop_init_screen_x init_screen_x
  def init_screen_x
    @purchase_only ? 999 : menu_luna_poshop_init_screen_x
  end
  
end # Window_ShopCommand

#==============================================================================
# ■ Scene_Shop
#==============================================================================

class Scene_Shop < Scene_MenuBase
  
  #--------------------------------------------------------------------------
  # alias method: start
  #--------------------------------------------------------------------------
  alias menu_luna_poshop_start start
  def start
    menu_luna_poshop_start
    init_purchase_only
  end
  
  #--------------------------------------------------------------------------
  # new method: init_purchase_only
  #--------------------------------------------------------------------------
  def init_purchase_only
    return unless @purchase_only
    command_buy
  end
  
  #--------------------------------------------------------------------------
  # alias method: on_buy_cancel
  #--------------------------------------------------------------------------
  alias menu_luna_poshop_on_buy_cancel on_buy_cancel
  def on_buy_cancel
    @purchase_only ? return_scene : menu_luna_poshop_on_buy_cancel
  end
  
end # Scene_Shop