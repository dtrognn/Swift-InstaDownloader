//
//  HomeViewController.swift
//  InstaDownloader
//
//  Created by Vu Duc Trong on 16/04/2023.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet var urlTextField: UITextField!
    @IBOutlet var downloadButton: UIButton!

    @IBOutlet var instaCollectionView: UICollectionView!

    private var images = [UIImage]()

    private let numberOfItemInRow: CGFloat = 2
    private let cellPaddingLeft: CGFloat = 10
    private let cellPaddingRight: CGFloat = 10
    private let minimumLineSpacing: CGFloat = 10
    private let minimumInteritemSpacing: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()

        configCollectionView(instaCollectionView)
    }

    override func configSubViews() {
        downloadButton.roundCorners(with: 15)
        downloadButton.addShadow()
        urlTextField.addShadow()
        urlTextField.roundCorners(with: 5)
        urlTextField.placeholder = "Enter your image link"
        urlTextField.border(width: 1, color: .purple)
    }

    private func configCollectionView(_ collectionView: UICollectionView) {
        collectionView.register(.init(nibName: "\(ImageCell.self)", bundle: nil),
                                forCellWithReuseIdentifier: "\(ImageCell.self)")

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    @IBAction func touchUpInsideDisplayImageButton(_ sender: Any) {
        if let urlString = urlTextField.text,
           !urlString.isEmpty,
           let url = URL(string: urlString)
        {
            displayIndicator(isShow: true)
            displayImageToCell(url, urlString)
            displayIndicator(isShow: false)
        } else {
            let dismissAction = UIAlertAction(title: "Cancel", style: .default)
            showAlert(title: "Invalid URL", message: "", actions: [dismissAction])
        }
    }

    private func displayImageToCell(_ url: URL, _ urlString: String) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }

            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data returned from URL: \(urlString)")
                return
            }

            guard let image = UIImage(data: data) else {
                print("Invalid image data returned from URL: \(urlString)")
                return
            }

            DispatchQueue.main.async {
                self.images.append(image)
                self.instaCollectionView.reloadData()
            }
        }

        task.resume()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageCell.self)", for: indexPath) as! ImageCell

        cell.instaImageView.image = images[indexPath.row]

        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let widthContainer: CGFloat = view.frame.size.width
        let widthCell = floor((widthContainer - cellPaddingLeft - cellPaddingRight - (numberOfItemInRow - 1) * minimumInteritemSpacing) / numberOfItemInRow)
        let heightCell: CGFloat = widthCell + 55

        return CGSize(width: widthCell, height: heightCell)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return minimumLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return minimumInteritemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: cellPaddingLeft, bottom: 0, right: cellPaddingRight)
    }
}
