//
//  ImageCell.swift
//  InstaDownloader
//
//  Created by Vu Duc Trong on 16/04/2023.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet var instaImageView: UIImageView!
    @IBOutlet var downloadButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        configSubView()
        setupButtonTarget()
    }

    private func configSubView() {
        downloadButton.roundCorners(with: 15)
    }

    private func setupButtonTarget() {
        downloadButton.addTarget(self, action: #selector(downloadAndSaveImage), for: .touchUpInside)
    }

    @objc private func downloadAndSaveImage() {
        guard let image = instaImageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image to photo library: \(error.localizedDescription)")

            let dismiddAction = UIAlertAction(title: "Cancel", style: .default)
            showAlert("Image saved to photo library!", "", actions: [dismiddAction])
        } else {
            print("Image saved to photo library!")

            let dismiddAction = UIAlertAction(title: "OK", style: .default)
            showAlert("Image saved to photo library!", "", actions: [dismiddAction])
        }
    }

    private func showAlert(_ title: String, _ message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: "Image saved to photo library!",
                                      message: "",
                                      preferredStyle: .alert)
        actions.forEach {
            alert.addAction($0)
        }
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
