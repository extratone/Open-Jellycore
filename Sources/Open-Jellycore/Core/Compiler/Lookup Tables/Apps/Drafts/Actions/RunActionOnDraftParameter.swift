//
//  RunActionOnDraftParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct RunActionOnDraftParameter: ParameterProtocol, Codable {
	var action: Jelly_Action?
	var draft: Jelly_Draft?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = RunActionOnDraftParameter()

        if let value = call.first(where: { node in return node.slotName == "action" }) {
            parameters.action = Jelly_Action(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "runActionOnDraft", name: "action"), node: nil)
        }
        if let value = call.first(where: { node in return node.slotName == "draft" }) {
            parameters.draft = Jelly_Draft(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "runActionOnDraft", name: "draft"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"action": "Action(identifier: \"coolID\", displayString: \"My Custom Action\", name: \"My Custom Action\")",
			"draft": "Draft(identifier: \"F5BD82B1BA4\", displayString: \"Default Draft\", uuid: \"F5BD82B1BA4\", link: \"drafts://open?uuid=F5BD82B1BA4\", content: \"Some really cool content\", title: \"Default Draft\", tags: [\"Default Draft\"], folder: inbox, isFlagged: false, grammarType: GrammarType(displayString: \"Markdown\", identifier: \"Markdown\"))",

        ]
    }
}
