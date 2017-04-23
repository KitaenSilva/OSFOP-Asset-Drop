#~ #==============================================================================
#~ # ■ Kread Animated Battler Compatibility Script
#~ #==============================================================================
#~ # This is to ensure that the Kread's Animated Battlers are compatible with the 
#~ # Luna Engine. If you want to use his script, this is a must-have.
#~ #==============================================================================
#~ # Editing anything past the engine's configuration script may potentially  
#~ # result in causing computer damage, incontinence, explosion of user's head, 
#~ # coma, death, and/or halitosis so edit at your own risk. 
#~ # We're not liable for the risks you take should you pass this sacred grounds.
#~ #==============================================================================

#~ class Sprite_Battler < Sprite_Base
#~   
#~   if $imported['KRX-AnimatedBattlers']
#~   alias battle_luna_kab_get_current_pose get_current_pose
#~   def get_current_pose
#~     return unless @battler
#~     new_pose = @battler.animation_data(:stand)
#~     if @battler.dead?
#~       new_pose = @battler.animation_data(:dead)
#~     elsif @battler.is_a?(Game_Actor) && @battler.victory_pose
#~       new_pose = @battler.animation_data(:victory)
#~     elsif @battler.is_moving? && @battler.movement_type == 0
#~       new_pose = @battler.animation_data(:move_f)
#~     elsif @battler.is_moving? && @battler.movement_type == 1
#~       new_pose = @battler.animation_data(:move_b)
#~     elsif @battler.guard?
#~       new_pose = @battler.animation_data(:guard)
#~     elsif @battler.skill_pose_active
#~       new_pose = @battler.skill_battler_anim(@battler.current_action.item.id)
#~     elsif @battler.item_pose_active
#~       new_pose = @battler.item_battler_anim(@battler.current_action.item.id)
#~     elsif @battler.result.hp_damage > 0 && @battler.result.added_states.size == 0
#~       new_pose = @battler.animation_data(:hit)
#~     elsif @battler.states.size > 0 || @battler.result.added_states.size > 0
#~       new_pose = @battler.animation_data(:stand)
#~       @battler.sort_states.each do |state|
#~         if @battler.state_battler_anim(state)
#~           new_pose = @battler.state_battler_anim(state)
#~           break
#~         end
#~       end
#~     elsif @battler.hp_rate < 0.5
#~       new_pose = @battler.animation_data(:danger)
#~     end
#~     new_pose = @next_pose if @next_pose
#~     new_pose = @battler.animation_data(:hit) if new_pose.nil?
#~     new_pose = @battler.animation_data(:stand) if new_pose.nil?
#~     return unless new_pose
#~     battle_luna_kab_get_current_pose
#~   end
#~   end
#~   
#~ end