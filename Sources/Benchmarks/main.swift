//
//  main.swift
//  minja-swift
//
//  Created by John Mai on 2025/1/19.
//

import Benchmark
import Jinja
import Minja

let iterations = [1000, 2500, 5000, 10000]

let source =
  "{% for message in messages %}{{ '<|' + message['role'] + '|>\\n' + message['content'] + '<|end|>' + '\\n' }}{% endfor %}"
let messages = [["role": "user", "content": "Hello"], ["role": "assistant", "content": "Hi"]]

let bosToken = "<|startoftext|>"
let eosToken = "<|endoftext|>"

let addGenerationPrompt = true

func minjaSwiftBenchmark() throws {
  let template = ChatTemplate(
    source: source,
    bosToken: bosToken,
    eosToken: eosToken
  )

  let _ = try template.apply(
    messages: messages,
    addGenerationPrompt: addGenerationPrompt
  )
}

benchmark("minja-swift benchmark -> ") {
  try minjaSwiftBenchmark()
}

for iteration in iterations {
  benchmark("minja-swift \(iteration) benchmark -> ", settings: Iterations(iteration)) {
    try minjaSwiftBenchmark()
  }
}

func jinjaSwiftBenchmark() throws {
  let _ = try Template(source).render([
    "messages": [["role": "user", "content": "Hello"], ["role": "assistant", "content": "Hi"]],
    "bos_token": bosToken,
    "eos_token": eosToken,
    "add_generation_prompt": addGenerationPrompt,
  ])
}

benchmark("jinja-swift benchmark -> ") {
  try jinjaSwiftBenchmark()
}

for iteration in iterations {
  benchmark("jinja-swift \(iteration) benchmark -> ", settings: Iterations(iteration)) {
    try jinjaSwiftBenchmark()
  }
}

Benchmark.main()
