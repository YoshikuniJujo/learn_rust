use std::cell::Cell;

struct Point {
	x: i32,
	y: Cell<i32>,
}

fn main() {
	let mut x = 5;
	x = 6;
	let mut z = 8;

	let mut y = &mut x;
	y = &mut z;

	let point = Point { x: 5, y: Cell::new(6) };

	point.y.set(7);

	println!("mutability");
	println!("y: {:?}", point.y);
}
