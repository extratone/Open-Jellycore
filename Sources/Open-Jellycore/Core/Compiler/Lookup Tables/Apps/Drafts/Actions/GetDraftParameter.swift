//
//  GetDraftParameter.swift
//  Open-Jellycore
//
//  Created by Taylor Lineman on 6/02/23.
//

struct GetDraftParameter: ParameterProtocol, Codable {
	var draft: Jelly_Draft?


    static func build(call: [FunctionCallParameterItem], scopedVariables: [Variable]) -> ParameterProtocol {
        var parameters = GetDraftParameter()

        if let value = call.first(where: { node in return node.slotName == "draft" }) {
            parameters.draft = Jelly_Draft(parameterItem: value, scopedVariables: scopedVariables)
        } else {
            ErrorReporter.shared.reportError(error: .missingParameter(function: "getDraft", name: "draft"), node: nil)
        }

        return parameters
    }
     
    static func getDefaultValues() -> [String: String] {
        return [
			"draft": "Draft(identifier: \"F5BD82B1BA4\", displayString: \"Default Draft\", uuid: \"F5BD82B1BA4\", link: \"drafts://open?uuid=F5BD82B1BA4\", content: \"Some really cool content\", title: \"Default Draft\", tags: [\"Default Draft\"], folder: inbox, isFlagged: false, grammarType: GrammarType(displayString: \"Markdown\", identifier: \"Markdown\"))",

        ]
    }
}
