use std::io;

fn main() {
	println!("Please type 5.");

	let mut n = String::new();

	io::stdin().read_line(&mut n)
		.expect("Please type a number!");

	let n: u32 = n.trim().parse()
		.expect("Please type a number");

	if n == 5 {
		println!("n is five!");
	}
}
