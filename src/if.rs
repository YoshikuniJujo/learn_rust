use std::io;

fn main() {
	println!("Please type 5 or 6.");

	let mut n = String::new();

	io::stdin().read_line(&mut n)
		.expect("Please type a number!");

	let n: u32 = n.trim().parse()
		.expect("Please type a number");

	if n == 5 {
		println!("n is five!");
	} else if n == 6 {
		println!("n is six!");
	} else {
		println!("n is not five or six :(");
	}

	let y = if n == 5 { 10 } else { 15 };
	println!("{}", y);

}
