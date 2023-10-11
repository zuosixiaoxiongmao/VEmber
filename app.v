interface IHumen {
	do_i()
}

struct Chr {
	mut:
		age u64
}

fn (self Chr)do_i(){
	print('fuck wangzixian')
}

fn (mut self Chr)set_age(){
	self.age = 18
}

struct Wzx {
	name string = 'wzx'
}

struct Child {
	mut:
		dady Chr
		mom Wzx
}

fn (self Wzx)do_i(){
	print('wzx have sex with chr')
}

fn covert(wzx Wzx) Wzx{
	return wzx
}

fn marry<T>() T {
	return T{}
}

fn wzx_love_chr(){
	mom := Wzx{}
	dady := Chr{}
	child := Child{dady:dady, mom:mom}
	mother := child.mom
	child.mom.do_i()
	wzx_ptr := covert(child.mom)
	println(wzx_ptr)
	mut children := map[string]Child
	children['cw'] = child
	println(children)
	marry<Wzx>()
}





