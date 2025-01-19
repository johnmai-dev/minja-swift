//
//  ChatTemplate.swift
//  minja-swift
//
//  Created by John Mai on 2025/1/16.
//
import Cminja
import CxxStdlib
import Foundation

public class ChatTemplate {
  private let template: minja.chat_template
  public let source: String

  public init(source: String, bosToken: String, eosToken: String) {
    self.source = source
    template = minja.chat_template(std.string(source), std.string(bosToken), std.string(eosToken))
  }

  // apply
  // https://github.com/google/minja/blob/ca5aae276acc3eb7343bff86e4a1c42163bcab94/include/minja/chat-template.hpp#L119
  public func apply(
    messages: [[String: Any]],
    tools: [[String: Any]] = [],
    addGenerationPrompt: Bool,
    extraContext: [String: Any] = [:]
  ) throws -> String {
    let messagesData = try JSONSerialization.data(withJSONObject: messages)
    let toolsData = try JSONSerialization.data(withJSONObject: tools)
    let extraContextData = try JSONSerialization.data(withJSONObject: extraContext)

    guard let messagesString = String(data: messagesData, encoding: .utf8),
      let toolsString = String(data: toolsData, encoding: .utf8),
      let extraContextString = String(data: extraContextData, encoding: .utf8)
    else {
      throw NSError(
        domain: "ChatTemplateErrorDomain",
        code: -1,
        userInfo: [NSLocalizedDescriptionKey: "Failed to convert data to string"]
      )
    }

    let result = minja_chat_template_apply(
      template,
      std.string(messagesString),
      std.string(toolsString),
      addGenerationPrompt,
      std.string(extraContextString)
    )

    return String(result)
  }

  // supports_tools
  // https://github.com/google/minja/blob/ca5aae276acc3eb7343bff86e4a1c42163bcab94/include/minja/chat-template.hpp#L116
  func supportsTools() -> Bool {
    template.supports_tools()
  }

  // supports_parallel_tool_calls
  // https://github.com/google/minja/blob/ca5aae276acc3eb7343bff86e4a1c42163bcab94/include/minja/chat-template.hpp#L52
  func supportsParallelToolCalls() -> Bool {
    template.supports_parallel_tool_calls()
  }
}
