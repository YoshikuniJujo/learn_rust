use std::io;

fn main() {
	loop {
		println!("Loop forever!");

		let mut ln = String::new();
		io::stdin().read_line(&mut ln).expect("...");

		if ln.trim() == "quit" { break; }
		println!("{}", ln.trim());
	}

	let mut x = 5;
	let mut done = false;

	while !done {
		x += x - 3;

		println!("{}", x);

		if x % 5 == 0 {
			done = true;
		}
	}

	for x in 0..10 {
		println!("{}", x);
	}

	for (i, j) in (5 .. 10).enumerate() {
		println!("i = {} and j = {}", i, j);
	}

	let lines = "hello\nworld".lines();

	for (linenumber, line) in lines.enumerate() {
		println!("{}: {}", linenumber, line);
	}

	for x in 0 ..10 {
		if x % 2 == 0 { continue; }
		println!("{}", x);
	}

	'outer: for x in 0..10 {
		'inner: for y in 0..10 {
			if x % 2 == 0 { continue 'outer; }
			if y % 2 == 0 { continue 'inner; }
			println!("x : {}, y: {}", x, y);
		}
	}
}
