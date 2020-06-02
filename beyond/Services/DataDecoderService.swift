//
//  JsonService.swift
//  beyond
//
//  Created by Alexander on 02.06.2020.
//

import Foundation

public typealias DecodableCompletion<D: Decodable> = (_ result: Result<D, Error>) -> Void

protocol DataDecoderService {
    func decode<D: Decodable>(jsonFileName: String, completion: @escaping DecodableCompletion<D>)
}

struct BeyondDataDecoderService: DataDecoderService {
    func decode<D>(jsonFileName: String, completion: @escaping DecodableCompletion<D>) where D : Decodable {
        if let path = Bundle.main.path(forResource: jsonFileName, ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(D.self, from: jsonData)
                    completion(.success(model))

                } catch {
                    completion(.failure(error))
                }

            } catch {
                completion(.failure(error))
            }
        }
    }
}
