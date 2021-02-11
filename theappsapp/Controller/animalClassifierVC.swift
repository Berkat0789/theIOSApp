//
//  animalClassifierVC.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/10/21.
//

import UIKit
import CoreML
import Vision

class animalClassifierVC: UIViewController {
    @IBOutlet weak var selectedImage: UIImageView!
    
    var imagePick = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePick.delegate = self
        imagePick.sourceType = .camera
        imagePick.allowsEditing = false
        
        // Do any additional setup after loading the view.
    }
    @IBAction func cameraPressed(_ sender: Any) {
        present(imagePick, animated: true, completion: nil)
    }
    
    

}


extension animalClassifierVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    //Getting the image from camera
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        self.selectedImage.image = image
        // WE will need a ci Image that the ML model can process, as well at dismiss the image picker
        guard let ciImage = CIImage(image: image) else {return}
        imagePick.dismiss(animated: true, completion: nil)
        // Applying detect function tothe ciimage
        self.detect(image: ciImage)
    }
    
    // WEwill need a function to detect the image that is passed
    private func detect(image: CIImage) {
        // lets import the model that will handle the image recognition
        do {
            let model = try VNCoreMLModel(for: animalClassifier().model)
            // Now that we have our model we need to send the request to them model to classify the passed image
            let request = VNCoreMLRequest(model: model) { (request, error) in
                //Checking for the error
                if let err = error {
                    //There was an error
                    print("There was an error with image request \(err)")
                } else {
                    //There was no error
                    guard let results = request.results as? [VNClassificationObservation] else {return}
                    // Lets get the first results since this will be he mose accurate probability form the model
                    print(results)
                    let first = results.first
                    //Setting navigation title to the classification model returns
                    self.navigationItem.title = first?.identifier.uppercased()
                }
            }
            //Applyitnh handler
            self.handler(image: image, request: request)
        } catch {
            print("There was an error loading model \(error.localizedDescription)")
        }
    }
    
    // WE will need a function to handle the request to the model
    private func handler(image: CIImage, request: VNCoreMLRequest) {
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        }catch {
            print("There was a issue processing request \(error.localizedDescription)")
        }
    }
}
