//
//  StorageManager.swift
//  Messenger
//
//  Created by James Ogilvie on 29/9/2022.


import Foundation
import FirebaseStorage

final class StorageManager {

    static let shared = StorageManager()

    private let storage = Storage.storage().reference()


    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void

    /// Uploads image that will be sent in a conversation
    
    public func uploadMessagePhoto(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
            storage.child("message_images/\(fileName)").putData(data, metadata: nil, completion: { metadata, error in
                guard error == nil else {
                    // failed
                    print("failed to upload data to firebase for picture")
                    completion(.failure(StorageErrors.failedToUpload))
                    return
                }

                self.storage.child("message_images/\(fileName)").downloadURL(completion: { url, error in
                    guard let url = url else {
                        print("Failed to get download url")
                        completion(.failure(StorageErrors.failedToGetDownloadUrl))
                        return
                    }

                    let urlString = url.absoluteString
                    print("download url returned: \(urlString)")
                    completion(.success(urlString))
                })
            })
        }


    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }

    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child(path)

        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }

            completion(.success(url))
        })
    }
}
