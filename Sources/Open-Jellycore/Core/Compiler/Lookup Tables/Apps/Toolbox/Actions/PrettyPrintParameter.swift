//
//  PrettyPrintParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct PrettyPrintParameter: ParameterProtocol, Codable {
	var dictionary: JellyArray<JellyVariableReference>?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = PrettyPrintParameter()

        if let value = call.first(where: { node in return node.slotName == "dictionary" }) {
            parameters.dictionary = JellyArray<JellyVariableReference>(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "prettyPrint", name: "dictionary"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"dictionary": "[\"${My Starter Dictionary}\"]",

        ]
    }
}