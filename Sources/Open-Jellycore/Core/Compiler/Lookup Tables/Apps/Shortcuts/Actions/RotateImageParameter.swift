//
//  RotateImageParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct RotateImageParameter: ParameterProtocol, Codable {
	var WFImage: JellyVariableReference?
	var WFImageRotateAmount: JellyDouble?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = RotateImageParameter()

        if let variableCall = call.first(where: { node in return node.slotName == "image" })?.item {
            if let variable = Scope.find(variableCall.content, in: scopedVariables) {
                parameters.WFImage = JellyVariableReference(variable, scopedVariables: scopedVariables)
            } else {
                ErrorReporter.shared.reportError(error: .variableDoesNotExist(variable: variableCall.content), node: nil)
            }
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "rotateImage", name: "image"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "degrees" }) {
            parameters.WFImageRotateAmount = JellyDouble(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "rotateImage", name: "degrees"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"image": "Clipboard",
			"degrees": "180",

        ]
    }
}