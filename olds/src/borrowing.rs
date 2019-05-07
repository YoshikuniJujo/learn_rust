fn main() {

	fn sum_vec(v: &Vec<i32>) -> i32 {
		return v.iter().fold(0, |a, &b| a + b);
	}

	fn foo(v1: &Vec<i32>, v2: &Vec<i32>) -> i32 {
		let s1 = sum_vec(v1);
		let s2 = sum_vec(v2);
		s1 + s2
	}

	let v1 = vec![1, 2, 3];
	let v2 = vec![4, 5, 6];

	let answer = foo(&v1, &v2);
	println!("{}", answer);

	let mut x = 5;
	{
		let y = &mut x;
		*y += 1;
		println!("{}", y);
	}
	println!("{}", x);

	let x = 5;
	let y: &i32;
	y = &x;

	println!("{}", y);
}

// fn foo(v: &Vec<i32>) {
//	v.push(5);
// }
