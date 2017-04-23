#==============================================================================
# ** TDS_Script_Disabler
#    Ver: 1.2
#------------------------------------------------------------------------------
#  * Description:
#  This Script allows you to disable a group of scripts.
#------------------------------------------------------------------------------
#  * Features: 
#  Disable scripts.
#------------------------------------------------------------------------------
#  * Instructions:
#
#  To disable a group of scripts make 2 new blank scripts and in their name
#  add this:
#
#  <Disabled_Scripts>
#
#  </Disabled_Scripts>
#
#  Any scripts put between these 2 new scripts will be disabled at the start
#  of the game.
#------------------------------------------------------------------------------
#  * Notes:
#  The script names are the names on the left side box not inside the script
#  itself.
#
#  There is no limit to the amount of scripts groups you can disable.
#------------------------------------------------------------------------------
# WARNING:
#
# Do not release, distribute or change my work without my expressed written 
# consent, doing so violates the terms of use of this work.
#
# If you really want to share my work please just post a link to the original
# site.
#
# * Not Knowing English or understanding these terms will not excuse you in any
#   way from the consequenses.
#==============================================================================
# * Import to Global Hash *
#==============================================================================
($imported ||= {})[:TDS_Script_Disabler] = true

# Delete Activd Flag
delete_active =  false
# Go through Scripts
$RGSS_SCRIPTS.each_with_index {|data, i|
  # Activate or Deactivate Delete Active Flag
  delete_active = true  if data.at(1) =~ /<Disabled_Scripts>/i
  delete_active = false if data.at(1) =~ /<\/Disabled_Scripts>/i
  # Clear Text in Scripts data
  $RGSS_SCRIPTS.at(i)[2] = $RGSS_SCRIPTS.at(i)[3] = "" if delete_active
}