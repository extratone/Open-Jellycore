//
//  SetVolumeParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct SetVolumeParameter: ParameterProtocol, Codable {
	var WFVolume: JellyDouble?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = SetVolumeParameter()

        if let value = call.first(where: { node in return node.slotName == "level" }) {
            parameters.WFVolume = JellyDouble(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "setVolume", name: "level"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"level": "0",

        ]
    }
}