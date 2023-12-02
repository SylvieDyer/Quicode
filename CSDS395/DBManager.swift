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
            print("Updated db: \(response)")
            
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

    func convertAttributeValueToString(_ attributeValue: DynamoDB.AttributeValue) -> String? {
        switch attributeValue {
        case .s(let stringValue):
            return stringValue
        default:
            return nil // Handle other types or return a default value as needed
        }
    }
    func queryDB(userID: String) async -> [String : String] {
        var responseItems : [String : String] = [:]
        let client = AWSClient(
            credentialProvider: .static(accessKeyId: "AKIA2ARVCSNBIO4SS2HU", secretAccessKey: "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"),
            httpClientProvider: .createNew
        )
        let dynamoDB = DynamoDB(client: client, region: .useast2)
        let queryInput = DynamoDB.QueryInput( expressionAttributeValues: [
            ":userID": .s(userID)
        ], keyConditionExpression: "userID = :userID", tableName: "quicode"
        )
        do {
            let response = try await dynamoDB.query(queryInput)
            print("Queried: \(response)")
            if let items = response.items {
                for item in items{
                    if let userID = item["userID"], let userIDString = convertAttributeValueToString(userID),
                       let moduleName = item["moduleName"], let moduleNameString = convertAttributeValueToString(moduleName),
                       let blockName = item["blockName"], let blockNameString = convertAttributeValueToString(blockName),
                       let questionDifficulty = item["questionDifficulty"], let difficultyString = convertAttributeValueToString(questionDifficulty) {

                        responseItems = ["userID" : "\(userIDString)", "moduleName" : "\(moduleNameString)", "blockName" : "\(blockNameString)", "questionDifficulty" : "\(difficultyString)"]
                        } else {
                               print("Error: Failed to convert attributes to String")
                        }
                }
            }
            
        } catch{
            print("Error updating item: \(error)")
        }
        
        print("Queried table")
        do {
            try await client.shutdown()
        }
        catch {
            print("Error shutting down hehe")
        }
        return responseItems
    }
    
    
}
