struct Point {
	x: i32,
	y: i32,
}

struct PointRef<'a> {
	x: &'a mut i32,
	y: &'a mut i32,
}

fn main() {
	let origin = Point { x: 0, y: 0 };

	println!("The origin is at ({}, {})", origin.x, origin.y);

	let mut point = Point { x: 0, y: 0 };

	point.x = 5;

	let point = point;

	println!("The point is at ({}, {})", point.x, point.y);

//	point.y = 6;

	let mut point = Point { x: 0, y: 0 };

	{
		let r = PointRef { x: &mut point.x, y: &mut point.y };
		*r.x = 5;
		*r.y = 6;
	}

	assert_eq!(5, point.x);
	assert_eq!(6, point.y);
}
