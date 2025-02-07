//
//  MakeGIFParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct MakeGIFParameter: ParameterProtocol, Codable {
	var WFInput: JellyVariableReference?
	var WFMakeGIFActionDelayTime: JellyString?
	var WFMakeGIFActionLoopEnabled: JellyBoolean?
	var WFMakeGIFActionLoopCount: JellyDouble?
	var WFMakeGIFActionAutoSize: JellyBoolean?
	var WFMakeGIFActionManualSizeHeight: JellyString?
	var WFMakeGIFActionManualSizeWidth: JellyString?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = MakeGIFParameter()

        if let variableCall = call.first(where: { node in return node.slotName == "content" })?.item {
            if let variable = Scope.find(variableCall.content, in: scopedVariables) {
                parameters.WFInput = JellyVariableReference(variable, scopedVariables: scopedVariables)
            } else {
                ErrorReporter.shared.reportError(error: .variableDoesNotExist(variable: variableCall.content), node: nil)
            }
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "makeGIF", name: "content"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "frameTime" }) {
            parameters.WFMakeGIFActionDelayTime = JellyString(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "makeGIF", name: "frameTime"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "loopOn" }) {
            parameters.WFMakeGIFActionLoopEnabled = JellyBoolean(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "makeGIF", name: "loopOn"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "loopCount" }) {
            parameters.WFMakeGIFActionLoopCount = JellyDouble(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "makeGIF", name: "loopCount"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "autoSize" }) {
            parameters.WFMakeGIFActionAutoSize = JellyBoolean(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "makeGIF", name: "autoSize"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "width" }) {
            parameters.WFMakeGIFActionManualSizeHeight = JellyString(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "makeGIF", name: "width"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "height" }) {
            parameters.WFMakeGIFActionManualSizeWidth = JellyString(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "makeGIF", name: "height"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"content": "images",
			"frameTime": "1",
			"loopOn": "true",
			"loopCount": "5",
			"autoSize": "false",
			"width": "512",
			"height": "512",

        ]
    }
}