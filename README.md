# QCoordinator
Coordinator using SwiftUI
API implementation
Clean architecture

# Installation
## Setup gRPC and generate proto
### Install protobuf
`brew install swift-protobuf`

### Clone repo grpc-swift
`git clone https://github.com/grpc/grpc-swift.git`

`cd grpc-swift`

### Build plugins
`swift build -c release --product protoc-gen-grpc-swift`

### Copy PATH
`sudo cp .build/release/protoc-gen-grpc-swift /usr/local/bin/`

`sudo chmod +x /usr/local/bin/protoc-gen-grpc-swift`

### Verify
which protoc-gen-grpc-swift

Ex: cd to your location have .proto file

run: `protoc --swift_out=. --grpc-swift_out=. <your_file.proto>`

3. 
