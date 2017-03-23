import PackageDescription

let package = Package(
    name: "RainbowDemo",
    dependencies: [
        .Package(url: "https://github.com/onevcat/Rainbow", majorVersion: 2)
    ]
)
