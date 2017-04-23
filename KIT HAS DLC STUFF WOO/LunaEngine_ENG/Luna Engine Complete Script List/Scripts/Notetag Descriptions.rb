#==============================================================================
# ■ Notetag Descriptions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# This section allows you to have more than two Lines when making help entries.
# The beauty of this script is that you can have different descriptions for 
# items based on which scene (Battle/Shop/Equip/Item) they are in.
# This script is for Menu and Battle Luna. 
#==============================================================================
# ■ Instructions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# You can have all of the following notetags in one item.
# Use !bl for linebreak.
#
# For Main Menu related Notetags:
# <menu> 
# </menu>
#
# For Item/Skill Menu related Notetags:
# <menu desc> 
# </menu desc>
#
# For Shop Menu related Notetags:
# <shop desc>
# </shop desc>
#
# For Equip Menu related Notetags:
# <equip desc>
# </equip desc>
#
# For Battle Menu related Notetags:
# <battle desc>
# </battle desc>
#
# Example Usage, try putting this on any Skill/Item Notebox:
# <menu desc>
# Cost: 5 ENG !bl
# - Examines a single !bl
# target, giving !bl
# current/max HP
# </menu desc>
#
#==============================================================================

$imported = {} if $imported.nil?
$imported["YEL-MenuLuna-Description"] = true

#==============================================================================
# Editing anything past the engine's configuration script may potentially  
# result in causing computer damage, incontinence, explosion of user's head, 
# coma, death, and/or halitosis so edit at your own risk. 
# We're not liable for the risks you take should you pass this sacred grounds.
#==============================================================================

module MenuLuna
  module REGEXP
    START_MENU_DESC = /<menu desc>/i
    END_MENU_DESC = /<\/menu desc>/i
    
    START_SHOP_DESC = /<shop desc>/i
    END_SHOP_DESC = /<\/shop desc>/i
    
    START_EQUIP_DESC = /<equip desc>/i
    END_EQUIP_DESC = /<\/equip desc>/i
    
    START_BATTLE_DESC = /<battle desc>/i
    END_BATTLE_DESC = /<\/battle desc>/i
  end
end
 
module DataManager
  
  class <<self; alias load_database_blldct load_database; end
  def self.load_database
    load_database_blldct
    load_notetags_blldct
  end
  
  def self.load_notetags_blldct
    [$data_items, $data_skills, $data_weapons, $data_armors].each { |group|
      next if group.nil?
      group.each { |obj|
        next if obj.nil?
        obj.load_notetags_blldct
      }
    }
  end
  
end
 
class RPG::BaseItem
 
  def load_notetags_blldct
    @menu_desc = []
    @shop_desc = []
    @equip_desc = []
    @battle_desc = []
    #---
    menu = false
    shop = false
    equip = false
    battle = false
    #---
    self.note.split(/[\r\n]+/).each { |line|
      case line
      when MenuLuna::REGEXP::START_MENU_DESC
        menu = true
      when MenuLuna::REGEXP::END_MENU_DESC
        menu = false
      when MenuLuna::REGEXP::START_SHOP_DESC
        shop = true
      when MenuLuna::REGEXP::END_SHOP_DESC
        shop = false
      when MenuLuna::REGEXP::START_EQUIP_DESC
        equip = true
      when MenuLuna::REGEXP::END_EQUIP_DESC
        equip = false
      when MenuLuna::REGEXP::START_BATTLE_DESC
        battle = true
      when MenuLuna::REGEXP::END_BATTLE_DESC
        battle = false
      else
        @menu_desc.push(line) if menu
        @shop_desc.push(line) if shop
        @equip_desc.push(line) if equip
        @battle_desc.push(line) if battle
      end
    }
  end
  
  def menu_desc
    @menu_desc ||= []
    return nil if @menu_desc.size == 0
    @menu_desc.join.gsub(/\!bl/) { "\n" }
  end
  
  def shop_desc
    @shop_desc ||= []
    return nil if @shop_desc.size == 0
    @shop_desc.join.gsub(/\!bl/) { "\n" }
  end
  
  def equip_desc
    @equip_desc ||= []
    return nil if @equip_desc.size == 0
    @equip_desc.join.gsub(/\!bl/) { "\n" }
  end
  
  def battle_desc
    @battle_desc ||= []
    return nil if @battle_desc.size == 0
    @battle_desc.join.gsub(/\!bl/) { "\n" }
  end
  
end

if $imported["YEL-BattleLuna"]
class Window_BattleHelp < Window_Help
  
  def set_item(item)
    if item
      desc = item.battle_desc || item.description
    else
      desc = ""
    end
    set_text(desc)
  end
  
end
end

if $imported["YEL-MenuLuna"]
  
class Window_ItemHelp < Window_Help
  
  def set_item(item)
    if item
      desc = item.menu_desc || item.description
    else
      desc = ""
    end
    set_text(desc)
  end
  
end

class Window_SkillHelp < Window_Help
  
  def set_item(item)
    if item
      desc = item.menu_desc || item.description
    else
      desc = ""
    end
    set_text(desc)
  end
  
end

class Window_EquipHelp < Window_Help
  
  def set_item(item)
    if item
      desc = item.equip_desc || item.description
    else
      desc = ""
    end
    set_text(desc)
  end
  
end

class Window_ShopHelp < Window_Help
  
  def set_item(item)
    if item
      desc = item.shop_desc || item.description
    else
      desc = ""
    end
    set_text(desc)
  end
  
end

end