
import regex
import os
import v.eval
import v.pref
import v.util
import v.checker
import v.builder


import ember.utilities {ConfigParser}
import ember.core {Context, Ecs, Entity}
import plugins


fn run_regex() {
	blurb := "rounter_port=7000-8000"
	query := r'(.)*=(.)*'
	mut re := regex.regex_opt(query) or { panic(err) }
	arr := re.find_all_str(blurb)
	for str in arr {
		println(str)
	}
}


fn main_task(mut context &Context) {
	for {
			context.ecs.update()
		}
}


//__global (
// f1    = f64(34.0625)
//
// )
//__global wzx  Wzx
fn main() {
	//os.setenv("VEXE", "D:\\GitHup\\v\\v.exe", true)

	mut context := Context{Ecs.new()}
	plugins.ConfigPlugin.start(context)
	plugins.RounterPlugin.start(context)
	plugins.NetworkPlugin.start(context)

	//main_task(mut &context)
	//go main_task(mut &context)

	//mut e := eval.create()
	//repl_main(mut e)
	//e.run("fn calc(x int, y int) int { return x + y } print(calc(1,2))")!
	//e.run("import script")!
	//e.add_file("scripts/script.vv")
	//wzx := Wzx{}
	//age := eval.Int {} 
	//e.run("test_script()", 1)!
	
}