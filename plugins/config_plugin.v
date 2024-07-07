module plugins

import ember.core {Ecs, System}
import ember.parts

struct ConfigPlugin{

}

pub fn ConfigPlugin.start(context core.Context) {
	mut ecs := context.ecs
	entity := ecs.root_entity

	ecs.add_component<parts.ConfigComponent>(entity)
	ecs.add_system<parts.ConfigSystem>()
}
