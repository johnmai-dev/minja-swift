//
//  minja.cpp
//  minja-swift
//
//  Created by John Mai on 2025/1/16.
//
#include <string>
#include <minja/chat-template.hpp>
#include <minja/minja.hpp>

#ifndef minja_hpp
#define minja_hpp

const std::string minja_chat_template_apply(const minja::chat_template &tmpl, const std::string &messages, const std::string &tools, const bool add_generation_prompt, const std::string &extra_context)
{
    return tmpl.apply(nlohmann::ordered_json::parse(messages), nlohmann::ordered_json::parse(tools), add_generation_prompt, nlohmann::ordered_json::parse(extra_context));
}

#endif /* minja_hpp */
