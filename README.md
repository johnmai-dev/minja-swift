# minja-swift

minja-swift is a swift wrapper of the [Minja](https://github.com/google/minja).

> [Minja](https://github.com/google/minja) is a minimalistic C++ Jinja templating engine for LLM chat templates

> [!WARNING]  
> TL;DR: use of Minja is *at your own risk*, and the risks are plenty! See [Security & Privacy](https://github.com/google/minja/tree/main?tab=readme-ov-file#security--privacy) section below.

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

And then set `Swift Compiler - Language` to `C++/Objective-C++ Interoperability` in the `Build Settings` tab of your target.

## To Do

- [x] Wapper for [chat-template.hpp](https://github.com/google/minja/blob/main/include/minja/chat-template.hpp)
- [ ] Wapper for [minja.hpp](https://github.com/google/minja/blob/main/include/minja/minja.hpp)

# License

[MIT License](LICENSE)


