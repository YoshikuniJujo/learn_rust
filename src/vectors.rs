fn main() {
	let v = vec![1, 2, 3, 4, 5];
	let w = vec![0; 10];
	let i: usize = 0;

	println!("The third element of v is {}", v[2]);
	println!("{}", w[i]);

	match v.get(7) {
		Some(x) => println!("Item 7 is {}", x),
		None => println!("Sorry, this vector is too short.")
	}

//	println!("Item 7 is {}", v[7]);

	for i in &v {
		println!("A reference to {}", i);
	}

	let mut v = vec![1, 2, 3, 4, 5];

	for i in &mut v {
		println!("A mutable reference to {}", i);
	}

	for i in v {
		println!("Take ownership of the vector and its element {}", i);
	}

//	for i in w {
//		println!("Take ownership of the vector and its element {}", i);
//	}

//	println!("{}", v[3]);
//	println!("{}", w[3]);
}
