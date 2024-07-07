module utilities

import toml
import os
import regex

pub struct Config{
	mut:
		rounter_port string
		gate_port string
		internal_port string
		external_port string
}

pub struct ConfigParser {
	mut:
		config Config
		toml_doc toml.Doc
}

pub fn  ConfigParser.new() &ConfigParser {
	mut connfig_parser := &ConfigParser{}
	connfig_parser.load_file("res/ember.conf")
	return connfig_parser
}

fn (mut self ConfigParser) load_file1(path string) {
	content := os.read_file(path) or {
			return
	}
	content.split
	query := r"[\r]*"
	mut re := regex.regex_opt(query) or { panic(err) }
	arr := re.find_all_str(content)
	println(arr)
	for ts in arr {
		//kv := ts.split('=')
		//self.kvalues[kv[0].trim_space()] = kv[1].trim_space()
	}
}

fn (mut self ConfigParser) load_file(path string) {
	content := os.read_file(path) or {
			return
	}
	self.toml_doc = toml.parse_text(content) or { panic(err) }
	self.config = self.toml_doc.reflect[Config]()
} 

pub fn (self ConfigParser) get_value(key string) toml.Any {
	return	self.toml_doc.value(key)
}