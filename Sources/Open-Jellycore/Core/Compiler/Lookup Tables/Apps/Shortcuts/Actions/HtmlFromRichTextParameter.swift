//
//  HtmlFromRichTextParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct HtmlFromRichTextParameter: ParameterProtocol, Codable {
	var WFInput: JellyVariableReference?
	var WFMakeFullDocument: JellyBoolean?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = HtmlFromRichTextParameter()

        if let variableCall = call.first(where: { node in return node.slotName == "text" })?.item {
            if let variable = Scope.find(variableCall.content, in: scopedVariables) {
                parameters.WFInput = JellyVariableReference(variable, scopedVariables: scopedVariables)
            } else {
                ErrorReporter.shared.reportError(error: .variableDoesNotExist(variable: variableCall.content), node: nil)
            }
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "htmlFromRichText", name: "text"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "fullDocument" }) {
            parameters.WFMakeFullDocument = JellyBoolean(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "htmlFromRichText", name: "fullDocument"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"text": "Rich Text",
			"fullDocument": "false",

        ]
    }
}