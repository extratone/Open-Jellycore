//
//  OpenMultiredditParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct OpenMultiredditParameter: ParameterProtocol, Codable {
	var multiredditName: JellyString?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = OpenMultiredditParameter()

        if let value = call.first(where: { node in return node.slotName == "multiredditName" }) {
            parameters.multiredditName = JellyString(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "openMultireddit", name: "multiredditName"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"multiredditName": "Tech",

        ]
    }
}