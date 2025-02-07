//
//  SaveFileDropboxParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct SaveFileDropboxParameter: ParameterProtocol, Codable {
	var WFInput: JellyVariableReference?
	var WFAskWhereToSave: JellyBoolean?
	var WFFileDestinationPath: JellyString?
	var WFSaveFileOverwrite: JellyBoolean?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = SaveFileDropboxParameter()

        if let variableCall = call.first(where: { node in return node.slotName == "file" })?.item {
            if let variable = Scope.find(variableCall.content, in: scopedVariables) {
                parameters.WFInput = JellyVariableReference(variable, scopedVariables: scopedVariables)
            } else {
                ErrorReporter.shared.reportError(error: .variableDoesNotExist(variable: variableCall.content), node: nil)
            }
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "saveFileDropbox", name: "file"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "askToSave" }) {
            parameters.WFAskWhereToSave = JellyBoolean(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "saveFileDropbox", name: "askToSave"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "path" }) {
            parameters.WFFileDestinationPath = JellyString(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "saveFileDropbox", name: "path"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "overwrite" }) {
            parameters.WFSaveFileOverwrite = JellyBoolean(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "saveFileDropbox", name: "overwrite"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"file": "Ask",
			"askToSave": "false",
			"path": "files/saves/",
			"overwrite": "false",

        ]
    }
}