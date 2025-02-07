//
//  ValueForParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct ValueForParameter: ParameterProtocol, Codable {
	var WFDictionaryKey: JellyString?
	var WFInput: JellyVariableReference?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = ValueForParameter()

        if let value = call.first(where: { node in return node.slotName == "key" }) {
            parameters.WFDictionaryKey = JellyString(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "valueFor", name: "key"), node: nil)
        }
        if let variableCall = call.first(where: { node in return node.slotName == "dictionary" })?.item {
            if let variable = Scope.find(variableCall.content, in: scopedVariables) {
                parameters.WFInput = JellyVariableReference(variable, scopedVariables: scopedVariables)
            } else {
                ErrorReporter.shared.reportError(error: .variableDoesNotExist(variable: variableCall.content), node: nil)
            }
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "valueFor", name: "dictionary"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"key": "\"Name\"",
			"dictionary": "Meta",

        ]
    }
}