use std::thread;

fn main() {
  println!("main thread");

  thread::spawn(move || println!("inner thread")).join().unwrap();
}
