//
//  UploadPhotosParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct UploadPhotosParameter: ParameterProtocol, Codable {
	var ImageInput: JellyVariableReference?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = UploadPhotosParameter()

        if let variableCall = call.first(where: { node in return node.slotName == "photos" })?.item {
            if let variable = Scope.find(variableCall.content, in: scopedVariables) {
                parameters.ImageInput = JellyVariableReference(variable, scopedVariables: scopedVariables)
            } else {
                ErrorReporter.shared.reportError(error: .variableDoesNotExist(variable: variableCall.content), node: nil)
            }
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "uploadPhotos", name: "photos"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"photos": "Clipboard",

        ]
    }
}