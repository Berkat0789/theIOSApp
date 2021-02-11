//
//  inceptionImageRecognizerVC.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/9/21.
//

import UIKit
import CoreML
//Allows us to process images eanser without writing a lot of code
import Vision

class inceptionImageRecognizerVC: UIViewController {
    @IBOutlet weak var selectedImage: UIImageView!
    
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cameraPressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    

}



extension inceptionImageRecognizerVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        self.selectedImage.image = image
        self.imagePicker.dismiss(animated: true, completion: nil)
        // WE need to convert the image to a CI image -> so tht th emodel can process it
        guard let ciimage = CIImage(image: image) else {fatalError("count no convert image to ciimage")}
        // need a method to process the ciimage
        detect(image: ciimage)
    }
    private func detect(image:CIImage) {
        //Useing the inception V3 model
        do {
            let model = try VNCoreMLModel(for: Inceptionv3().model)
            // there was no errors in processing model , we will send a request to the model
            let request = VNCoreMLRequest(model: model) { (req, error) in
                if let err = error {
                    //There was an error
                    print("There was an error with the image request \(err)")
                } else {
                    //There was no error
                    //We need the cn clasificaiton observation
                    guard let results = req.results as? [VNClassificationObservation] else {fatalError("model ailed to process image")}
                    guard let first = results.first else {return}
                    if first.identifier.contains("hotdog") {
                        self.navigationItem.title = "Hot Dog".capitalized
                    }else {
                        self.navigationItem.title = "Not Hotdog".capitalized
                    }
                }
            }
            //Pricess Request here
            self.handler(image: image, request: request)
        } catch {
            print("There was an error processing model \(error.localizedDescription)")
        }
    }
    private func handler(image: CIImage, request: VNCoreMLRequest) {
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        }catch {
            print("THere was a error hadling request \(error.localizedDescription)")
        }
    }
    
}
