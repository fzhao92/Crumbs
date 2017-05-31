//
//  FirebaseClient.swift
//  Crumbs
//
//  Created by Forrest Zhao on 5/30/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import UIKit


class FirebaseClient {
    
    static func createUser(_ newUser: User, withEmail email: String, andPassword password: String) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            var newUser = newUser
            if let error = error {
                print("Failed to create user: \(error)")
                return
                // - TODO: error notifications
            }
            print("Successfully created user")
            
            if let image = newUser.profileImage {
                let filename = NSUUID().uuidString
                uploadImageToStorage(image, withName: filename, andPath: "profile_images", quality: 0.3, completion: { (url) in
                    newUser.profileImageUrl = url
                    guard let uid = user?.uid else { return }
                    let values = [uid: newUser.convertToFirebaseJSON()]
                    FIRDatabase.database().reference().child("users").updateChildValues(values)
                })
            } else {
                guard let uid = user?.uid else { return }
                let values = [uid: newUser.convertToFirebaseJSON()]
                FIRDatabase.database().reference().child("users").updateChildValues(values)
            }
            
        })
    }
    
    static func uploadImageToStorage(_ image: UIImage, withName name: String, andPath path: String, quality: CGFloat, completion: @escaping (String) -> Void) {
        guard let uploadImage = UIImageJPEGRepresentation(image, quality) else {
            print("Failed to convert image")
            // - TODO: handle image conversion error
            return
        }
        FIRStorage.storage().reference().child(path).child(name).put(uploadImage, metadata: nil, completion: { (metadata, error) in
            if let error = error {
                print("Failed to upload image: \(error)")
                // - TODO: handle image upload error
            }
            guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else {
                print("No url string availabel")
                return
            }
            completion(profileImageUrl)
        })
    }
    
    
}
