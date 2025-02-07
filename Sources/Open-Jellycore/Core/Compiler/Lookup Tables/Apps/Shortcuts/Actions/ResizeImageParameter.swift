//
//  ResizeImageParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct ResizeImageParameter: ParameterProtocol, Codable {
	var WFImage: JellyVariableReference?
	var WFImageResizeHeight: JellyDouble?
	var WFImageResizeWidth: JellyDouble?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = ResizeImageParameter()

        if let variableCall = call.first(where: { node in return node.slotName == "image" })?.item {
            if let variable = Scope.find(variableCall.content, in: scopedVariables) {
                parameters.WFImage = JellyVariableReference(variable, scopedVariables: scopedVariables)
            } else {
                ErrorReporter.shared.reportError(error: .variableDoesNotExist(variable: variableCall.content), node: nil)
            }
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "resizeImage", name: "image"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "height" }) {
            parameters.WFImageResizeHeight = JellyDouble(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "resizeImage", name: "height"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "width" }) {
            parameters.WFImageResizeWidth = JellyDouble(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "resizeImage", name: "width"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"image": "Clipboard",
			"height": "1024",
			"width": "1024",

        ]
    }
}