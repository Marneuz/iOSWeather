//
//  NetworkError.swift
//  WeatherApp
//
//  Created by user241563 on 21/11/23.
//

import Foundation

enum NetworkError: Error {
    case nilResponse
    case badUrl
    case encoding
    case response(Int)
}
