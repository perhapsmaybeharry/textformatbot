//
//  main.swift
//  format-bot
//
//  Created by Harry Wang on 21/1/17.
//  Copyright © 2017 thisbetterwork. All rights reserved.
//

import Foundation

while (true) {
	
	autoreleasepool {
		
		do {
			
			let bot = Teleswift("328964654:AAEyqzzdVp4FRJEv7dACnvs779k7PRZa90A")
			
			var updates: [Update] = [Update]()
			updates = try bot.getAndClearUpdates()
			
			for update in updates {
				
				print("update id: \(update.update_id)")
				print("message from: \(update.message.chat.first_name) \(update.message.chat.last_name)")
				print("contents of update: \(update.message.text)")
				let markdownType = discernMarkdownType(update.message.text)
				print("markdown type: \(markdownType)")
				
				_ = try bot.sendMessage(chat_id: update.message.chat.id, text: update.message.text, parse_mode: markdownType)
				
			}
			
		}
		catch apiError.notOK {print("Invalid Request")}
		catch apiError.noConnection {print("No Internet connection detected")}
		catch classError.jsonNotAllValuesPresent(let err) {print("Not all required values are present. Missing: \(err)")}
		catch apiError.unknown(let err) {print(err)}
		catch classError.unknown(let err) {print(err)}
		catch apiError.invalidParameter(let err) {print(err)}
		catch tgError.unauthorized {print("Unauthorized. Token revoked?")}
		catch tgError.unknown(let err) {print(err)}
		catch tgError.chat_not_found {print("chat not found")}
		catch let err {print(err)}
		
		usleep(500000)
		
	}
	
}
