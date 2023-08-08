//
//  BarCodeScanner.swift
//  BookApp
//
//  Created by Sabrina Souza on 06/08/23.
//

import UIKit
import SwiftUI
import AVFoundation
import Combine


struct BarCodeScanner: UIViewControllerRepresentable {
    
    var isbn: String?
    @Binding var foundBook: Book?
    @Environment(\.presentationMode) var presentationMode
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.black
        
        context.coordinator.captureSession = AVCaptureSession()
        
        guard let videoCaptureDevide = AVCaptureDevice.default(for: .video) else { fatalError() }
        let videoInput: AVCaptureDeviceInput
        videoInput = try! AVCaptureDeviceInput(device: videoCaptureDevide)
        
        if (context.coordinator.captureSession.canAddInput(videoInput)) {
            context.coordinator.captureSession.addInput(videoInput)
        } else {
            print("Could not add input to capture session")
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (context.coordinator.captureSession.canAddOutput(metadataOutput)) {
            context.coordinator.captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            print("Output problem")
        }
        
        context.coordinator.previewLayer = AVCaptureVideoPreviewLayer(session: context.coordinator.captureSession)
        context.coordinator.previewLayer.frame = vc.view.layer.bounds
        context.coordinator.previewLayer.videoGravity = .resizeAspectFill
        vc.view.layer.addSublayer(context.coordinator.previewLayer)
        
        context.coordinator.captureSession.startRunning()
        
        return vc
        
    }
}

class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate, ObservableObject {
    var parent: BarCodeScanner
    @Binding var foundBook: Book?

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    private let service: BookService = BookService()
    private var subscriptions = Set<AnyCancellable>()
    var returnEmpty: Bool = true
    #warning("usar a variavel returnEmpty para retorno vazio da API")
    
    init(parent: BarCodeScanner) {
        self.parent = parent
        self._foundBook = parent.$foundBook

    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as?
                    AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            captureSession.stopRunning()
            parent.presentationMode.wrappedValue.dismiss()
            
        }
    }
    
    private func found(code: String) {
        parent.isbn = code
        
        self._foundBook.wrappedValue = books.isEmpty ? nil : books[0]  // Atualize o binding do livro encontrado
        self.service.fetchBooks(searchedText: code, page: 0, filter: .isbn)
            .mapAPIBookToBook()
            .setBookImages(withService: self.service)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    return
                }
            }, receiveValue: { books in
                if books.isEmpty {
                    print("aaa")
                } else {
                    self.parent.foundBook = books[0]
                    self.returnEmpty = false
                    print("returnEmpty ", self.returnEmpty)
                }
            })
            .store(in: &subscriptions)
    }
}
