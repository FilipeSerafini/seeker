//
//  PhotoPicker.swift
//  BookApp
//
//  Created by Sabrina Souza on 14/08/23.
//

import SwiftUI
import Combine

struct PhotoPicker : UIViewControllerRepresentable {
    @Binding var show: Bool
    @Binding var image: Data
    
    func makeCoordinator() -> PhotoPicker.Coordinator {
        return PhotoPicker.Coordinator(child1: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoPicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PhotoPicker>) {
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let child: PhotoPicker
        
        init(child1: PhotoPicker) {
            child = child1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.child.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage]as! UIImage
            let data = image.jpegData(compressionQuality: 0.45)
            
            self.child.image = data!
            self.child.show.toggle()
        }
        
       
    }
}
