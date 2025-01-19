# minja-swift

minja-swift is a swift wrapper of the [Minja](https://github.com/google/minja).

> [Minja](https://github.com/google/minja) is a minimalistic C++ Jinja templating engine for LLM chat templates

> [!WARNING]  
> TL;DR: use of Minja is *at your own risk*, and the risks are plenty!
> See [Security & Privacy](https://github.com/google/minja/tree/main?tab=readme-ov-file#security--privacy) section below.

# Usage

```swift
let template = ChatTemplate(
    source:
    "{% for message in messages %}{{ '<|' + message['role'] + '|>\\n' + message['content'] + '<|end|>' + '\\n' }}{% endfor %}",
    bosToken: "<|start|>",
    eosToken: "<|end|>"
)

let result = try template.apply(
    messages: [
        ["role": "user", "content": "Hello"],
        ["role": "assistant", "content": "Hi"]
    ],
    tools: [
    [
        "type": "function",
        "function": [
            "name": "google_search",
            "arguments": ["query": "2+2"],
        ],
    ]
    ],
    addGenerationPrompt: true
)
```

# Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/johnmai-dev/minja-swift", from: "0.0.1")
]
```

And then add `minja-swift` as a dependency for your target:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "Minja", package: "minja-swift")
        ]
    )
]
```

And then set `Swift Compiler - Language` to `C++/Objective-C++ Interoperability` in the `Build Settings` tab of your
target.

## Benchmark [Minja Swift](https://github.com/johnmai-dev/minja-swift) vs [Jinja Swift](https://github.com/johnmai-dev/Jinja)

benchmark branch: https://github.com/johnmai-dev/minja-swift/tree/benchmark

```bash
name                            time           std        iterations
--------------------------------------------------------------------
minja-swift benchmark ->         440583.000 ns ±   2.48 %       3103
minja-swift 1000 benchmark ->    440083.000 ns ±   1.75 %       1000
minja-swift 2500 benchmark ->    441125.000 ns ±   1.80 %       2500
minja-swift 5000 benchmark ->    443209.000 ns ±   2.41 %       5000
minja-swift 10000 benchmark ->   443375.000 ns ±   1.85 %      10000
jinja-swift benchmark ->        1057916.000 ns ±   0.96 %       1318
jinja-swift 1000 benchmark ->   1058583.000 ns ±   0.99 %       1000
jinja-swift 2500 benchmark ->   1058292.000 ns ±   1.03 %       2500
jinja-swift 5000 benchmark ->   1060417.000 ns ±   2.31 %       5000
jinja-swift 10000 benchmark ->  1059875.000 ns ±   2.07 %      10000
```

## To Do

- [x] Wapper for [chat-template.hpp](https://github.com/google/minja/blob/main/include/minja/chat-template.hpp)
- [ ] Wapper for [minja.hpp](https://github.com/google/minja/blob/main/include/minja/minja.hpp)

# License

[MIT License](LICENSE)


