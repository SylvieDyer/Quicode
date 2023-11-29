//
//  DBManager.swift
//  CSDS395
//
//  Created by Prarthana Gajjala on 11/24/23.
//

import Foundation
import SotoDynamoDB

struct DBManager {
        
    func uploadToDB() async {
        let client = AWSClient(
            credentialProvider: .static(accessKeyId: "AKIA2ARVCSNBIO4SS2HU", secretAccessKey: "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"),
            httpClientProvider: .createNew
        )
        let dynamoDB = DynamoDB(client: client, region: .useast1)
        let putItemInput = DynamoDB.PutItemInput(item: ["userID": .s("TESTID")], tableName: "quicode")
        do {
            var response = try await dynamoDB.putItem(putItemInput)
            print("Added item to db: \(response)")
            
    } catch{
        print("Error adding item: \(error)")
    }
    
            
        print("Uploaded to table?")
        do {
            try client.syncShutdown()
        }
        catch {
            print("Error shutting down hehe")
        }
    }

    
}
