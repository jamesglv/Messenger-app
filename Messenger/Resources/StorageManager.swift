//
//  StorageManager.swift
//  Messenger
//
//  Created by James Ogilvie on 29/9/2022.
//
//
//import Foundation
//import FirebaseStorage
//
//final class StorageManager {
//
//    static let shared = StorageManager()
//
//    private let storage = Storage.storage().reference()
//
//
//    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
//
//    /// Uploads picture to firebase storage and returns completion with url string to download
//
//    public enum StorageErrors: Error {
//        case failedToUpload
//        case failedToGetDownloadUrl
//    }
//
//    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
//        let reference = storage.child(path)
//
//        reference.downloadURL(completion: { url, error in
//            guard let url = url, error == nil else {
//                completion(.failure(StorageErrors.failedToGetDownloadUrl))
//                return
//            }
//
//            completion(.success(url))
//        })
//    }
//}
