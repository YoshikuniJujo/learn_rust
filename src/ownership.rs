fn main() {
	let v = vec![1, 22, 333];

//	let v2 = v;


//	take(v);
//	let v2 = foo(v);

	for x in v {
		println!("{}", x);
	}

	let v = 1;

	let _v2 = v;

	println!("{}", v);
}

fn _take(v: Vec<i32>) {
	println!("Ha! Ha! Ha! I stole variable v");
	println!("v[1] = {}", v[1]);
}

fn foo(v: Vec<i32>) -> Vec<i32> {
	v
}
