//
//  WaitParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct WaitParameter: ParameterProtocol, Codable {
	var WFDelayTime: JellyDouble?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = WaitParameter()

        if let value = call.first(where: { node in return node.slotName == "seconds" }) {
            parameters.WFDelayTime = JellyDouble(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "wait", name: "seconds"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"seconds": "1",

        ]
    }
}