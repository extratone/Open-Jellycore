//
//  AddToPlaylistParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct AddToPlaylistParameter: ParameterProtocol, Codable {
	var WFInput: JellyVariableReference?
	var WFPlaylistName: JellyString?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = AddToPlaylistParameter()

        if let variableCall = call.first(where: { node in return node.slotName == "music" })?.item {
            if let variable = Scope.find(variableCall.content, in: scopedVariables) {
                parameters.WFInput = JellyVariableReference(variable, scopedVariables: scopedVariables)
            } else {
                ErrorReporter.shared.reportError(error: .variableDoesNotExist(variable: variableCall.content), node: nil)
            }
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "addToPlaylist", name: "music"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "playlist" }) {
            parameters.WFPlaylistName = JellyString(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "addToPlaylist", name: "playlist"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"music": "ShortcutInput",
			"playlist": "My Music Library",

        ]
    }
}