# Rust Darwin builder

This is a plain-and-simple docker image that allows you to cross-compile Rust applications for macOS. Currently, it only supports MacOSX 10.10 SDK, and only x86 systems. I've tried to find something that can cross-compile for a newer SDK and for ARM systems as well (like the M1, M2, etc), but couldn't find anything so far. Please do open an issue if you come across any way to implement it. That being said, Rosetta seems to be able to handle x86 Rust applications pretty well. We use it regularly for our CLI for [Patr](https://patr.cloud) and we're so far able to run the CLI on M1 macs just as well as Intel ones.

## How to use

This image is based off of `rust:1.65` directly. So you can use the image the same way you would rust the official rust image.

Just do:

```
docker run -v $(pwd):/app -w /app patrcloud/rust-macos:1.64 cargo build --target x86_64-apple-darwin
```

### Notes on OpenSSL

If you're not able to get openssl to compile well on macOS, try adding this to your `Cargo.toml` dependencies:

```toml
openssl = { version = "0.10", features = ["vendored"] }
```
