module parts

import os
import regex
import toml


import core {Ecs, System, Entity}

pub struct ConfigComponent{
	pub mut:
		rounter_port int
		gate_port int
		internal_port int
		external_port int
}

pub struct ConfigSystem {
	System
	mut:
		toml_doc toml.Doc
}

pub fn (mut self ConfigSystem)init() {
	for entity in self.ecs.selector().and<ConfigComponent>().query() {
		self.load_file(entity, "res/ember.conf")
	}
}


fn (mut self ConfigSystem) load_file(entity Entity, path string) {
	content := os.read_file(path) or {
			return
	}
	mut config_com := self.ecs.get_component<ConfigComponent>(entity)
	self.toml_doc = toml.parse_text(content) or { panic(err) }
	tconfig := self.toml_doc.reflect[ConfigComponent]()
	config_com.rounter_port = tconfig.rounter_port
	config_com.gate_port = tconfig.gate_port
	config_com.internal_port = tconfig.internal_port
	config_com.external_port = tconfig.external_port
} 

fn (self ConfigSystem) get_value(key string) toml.Any {
	return	self.toml_doc.value(key)
}