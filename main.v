
import regex
import ember.utilities {ConfigParser}
import os
import v.eval
import v.pref
import v.util
import v.checker
import v.builder

fn run_regex() {
	blurb := "rounter_port=7000-8000"
	query := r'(.)*=(.)*'
	mut re := regex.regex_opt(query) or { panic(err) }
	arr := re.find_all_str(blurb)
	for str in arr {
		println(str)
	}
}



fn main() {
	parser := ConfigParser.new()
	gate_port := parser.get_value<string>('gate_port')
	println("test config parse : ${gate_port}")
	mut e := eval.create()
	//repl_main(mut e)
	e.run("fn calc(x int, y int) int { return x + y } print(calc(1,2))")!
}