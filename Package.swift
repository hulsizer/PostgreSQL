// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "PostgreSQL",
    dependencies: [
        .Package(url: "https://github.com/stepanhruda/libpq-darwin", majorVersion: 9)
    ]
)
