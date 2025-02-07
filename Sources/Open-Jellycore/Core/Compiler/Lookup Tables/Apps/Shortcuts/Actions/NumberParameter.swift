//
//  NumberParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct NumberParameter: ParameterProtocol, Codable {
	var WFNumberActionNumber: JellyDouble?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = NumberParameter()

        if let value = call.first(where: { node in return node.slotName == "value" }) {
            parameters.WFNumberActionNumber = JellyDouble(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "number", name: "value"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"value": "42",

        ]
    }
}