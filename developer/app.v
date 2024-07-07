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

struct Point {
	x int
	y int
}


struct Vector3D {
	x int
	y int
	z int
}

fn look_at(point Vector3D, dir Vector3D) Vector3D {
	normail := Vector3D{1, 2, 3}
	return normail
}

struct Wzx {
	age int
}

__global wzx Wzx

fn main() {
	p1 := Vector3D{0,1,2}
	p2 := Vector3D{0,1,1}
	dir := look_at(p1, p2)
	println("i do love with wzx")
	wzx = Wzx{18}
}