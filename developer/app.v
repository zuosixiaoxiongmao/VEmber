import regex


fn run_regex() {
	blurb := "rounter_port=7000-8000"
	query := r'(.)*=(.)*'
	mut re := regex.regex_opt(query) or { panic(err) }
	arr := re.find_all_str(blurb)
	for str in arr {
		println(str)
	}
}

run_regex()
