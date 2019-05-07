use std::io;

fn main() {

	println!("Please type a number.");

	let mut num = String::new();

	io::stdin().read_line(&mut num)
		.expect("Failed to read line");

	let num: u64 = num.trim().parse()
		.expect("Please type a number!");

	println!("{}", fib(num).0);
}

fn fib(n: u64) -> (u64, u64) {
	match n {
		0 => (0, 1),
		_ => {
			let (a, b) = fib(n - 1);
			(b, a + b)
		}
	}
}
