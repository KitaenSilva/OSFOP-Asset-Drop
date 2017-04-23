#~ class Spriteset_Battle ## Re-overwrites the overwritten method... again! :)
#~   def create_actors  ## Creates the actor sprites.
#~     @extra_sprites = []
#~     @actor_sprites = $game_party.battle_members.collect do |actor|
#~       create_viewed_battler(actor)
#~     end
#~     @actor_sprites.each {|sprite| sprite.viewport4 = @viewport4}
#~   end
#~ end

#~ class Sprite_Battler < Sprite_Base
#~   def update_bitmap ## Removes a line from the Luna version of this method.
#~     battle_luna_update_bitmap
#~   end
#~ end