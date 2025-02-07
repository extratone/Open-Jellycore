//
//  SpokenAudioFromTextParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct SpokenAudioFromTextParameter: ParameterProtocol, Codable {
	var WFInput: JellyString?
	var language: Jelly_WFSpeakTextLanguage?
	var WFSpeakTextPitch: JellyDouble?
	var WFSpeakTextRate: JellyDouble?
	var voice: Jelly_WFSpeakTextVoice?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = SpokenAudioFromTextParameter()

        if let value = call.first(where: { node in return node.slotName == "text" }) {
            parameters.WFInput = JellyString(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "spokenAudioFromText", name: "text"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "language" }) {
            parameters.language = Jelly_WFSpeakTextLanguage(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "spokenAudioFromText", name: "language"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "pitch" }) {
            parameters.WFSpeakTextPitch = JellyDouble(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "spokenAudioFromText", name: "pitch"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "rate" }) {
            parameters.WFSpeakTextRate = JellyDouble(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "spokenAudioFromText", name: "rate"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "voice" }) {
            parameters.voice = Jelly_WFSpeakTextVoice(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "spokenAudioFromText", name: "voice"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"text": "Hello World!",
			"language": "en-US",
			"pitch": "1.0",
			"rate": "0.5",
			"voice": "Alex",

        ]
    }
}