module app


import core {Vec3}

pub struct Transform {
	mut:
	position Vec3
	rotation Vec3
	scale	Vec3
}

pub struct UnitData {
	mut:
		proto_id u64
		name string
}

pub struct InputData {
	mut:
		position Vec3
		rotation Vec3
		button u64
}


pub struct ConfigComponent {
}