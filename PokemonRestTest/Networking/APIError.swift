//
//  APIError.swift
//  PokemonRestTest
//
//  Created by Viacheslav Markov on 30.05.2021.
//

import Foundation

enum APIError: Error, LocalizedError {
    case server(Error)
    case response(Int)
    case noData
    case wrongType(String)
    
    var descriptionError: String {
        switch self {
        case .server(let error):
            return error.localizedDescription
        case .response(let statusCode):
            return "Your status code is \(statusCode)"
        case .noData:
            return "No DATA"
        case .wrongType(let typeName):
            return "Your type name is \(typeName)"
        }
    }
}
