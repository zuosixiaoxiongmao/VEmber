module utilities

import toml
import os
import regex

pub struct ConfigParser {
	mut:
		kvalues map[string]string={}
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

fn (mut self ConfigParser) load_file1(path string) {
	content := os.read_file(path) or {
			return
	}
	toml_doc := toml.parse_text(content) or { panic(err) }
}

pub fn (self ConfigParser) get_value<T>(path string) T {
	return T(self.kvalues[path])
} 