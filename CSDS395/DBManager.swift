//
//  DBManager.swift
//  CSDS395
//
//  Created by Prarthana Gajjala on 11/24/23.
//

import Foundation
import SotoDynamoDB


struct DBManager {
        
    func uploadToDB(item: [String: SotoDynamoDB.DynamoDB.AttributeValue]) async {
        let client = AWSClient(
            credentialProvider: .static(accessKeyId: "AKIA2ARVCSNBIO4SS2HU", secretAccessKey: "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"),
            httpClientProvider: .createNew
        )
        let dynamoDB = DynamoDB(client: client, region: .useast2)
        let putItemInput = DynamoDB.PutItemInput(item: item, tableName: "quicode")
        do {
            let response = try await dynamoDB.putItem(putItemInput)
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
    
    func updateDB(key: [String: SotoDynamoDB.DynamoDB.AttributeValue], expressionAttributeValues: [String: SotoDynamoDB.DynamoDB.AttributeValue], updateExpression: String) async {
        let client = AWSClient(
            credentialProvider: .static(accessKeyId: "AKIA2ARVCSNBIO4SS2HU", secretAccessKey: "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"),
            httpClientProvider: .createNew
        )
        let dynamoDB = DynamoDB(client: client, region: .useast2)
        let updateItemInput = DynamoDB.UpdateItemInput(expressionAttributeValues: expressionAttributeValues, key: key, tableName: "quicode", updateExpression: updateExpression)
        do {
            let response = try await dynamoDB.updateItem(updateItemInput)
            print("Added item to db: \(response)")
            
    } catch{
        print("Error updating item: \(error)")
    }
    
            
        print("Updaated table?")
        do {
            try client.syncShutdown()
        }
        catch {
            print("Error shutting down hehe")
        }
    }

    
}
