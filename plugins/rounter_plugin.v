module plugins

import ember.core {Ecs, System}
import ember.parts
import ember.app.rounter

struct RounterPlugin{

}

pub fn RounterPlugin.start(context core.Context) {
	mut ecs := context.ecs
	entity := ecs.root_entity

	ecs.add_component<rounter.HttpComponent>(entity)
	ecs.add_system<rounter.HttpSystem>()
}
