use std::thread;

fn main() {
  // I believe we need thread stuff to force libpthread to be linked.
  thread::spawn(move || println!("inner thread")).join().unwrap();
}
