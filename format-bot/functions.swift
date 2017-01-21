//
//  functions.swift
//  format-bot
//
//  Created by Harry Wang on 21/1/17.
//  Copyright © 2017 thisbetterwork. All rights reserved.
//

import Foundation

extension String {
	func regex (_ pattern: String) -> [String] {
		do {
			let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
			let nsstr = self as NSString
			let all = NSRange(location: 0, length: nsstr.length)
			var matches : [String] = [String]()
			regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: all) {
				(result : NSTextCheckingResult?, _, _) in
				if let r = result {
					let result = nsstr.substring(with: r.range) as String
					matches.append(result)
				}
			}
			return matches
		} catch {
			return [String]()
		}
	}
}

func discernMarkdownType(_ text: String) -> String {
	
	if (text.contains("<em>") && text.contains("</em>")) || (text.contains("<strong>") && text.contains("<strong>")) {
		return "HTML"
	} else if text.regex("\\_[\\S\\s]+\\*").count > 0 || text.regex("\\*[\\S\\s]+\\*").count > 0 {
		return "Markdown"
	}
	
	return String()
	
}
