//
//  CreateAlbumParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct CreateAlbumParameter: ParameterProtocol, Codable {
	var WFInput: JellyVariableReference?
	var AlbumName: JellyString?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = CreateAlbumParameter()

        if let variableCall = call.first(where: { node in return node.slotName == "photos" })?.item {
            if let variable = Scope.find(variableCall.content, in: scopedVariables) {
                parameters.WFInput = JellyVariableReference(variable, scopedVariables: scopedVariables)
            } else {
                ErrorReporter.shared.reportError(error: .variableDoesNotExist(variable: variableCall.content), node: nil)
            }
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "createAlbum", name: "photos"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "name" }) {
            parameters.AlbumName = JellyString(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "createAlbum", name: "name"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"photos": "Ask",
			"name": "New Album",

        ]
    }
}