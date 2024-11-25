//
//  ViewController.swift
//  Atlys.com
//
//  Created by MacBook on 23/11/24.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet weak var pageControl: UIPageControl!
    // MARK: - Properties
    var bannerWidth: CGFloat = 0
    
    var imageViews: [UIImageView] = []  // Array to hold the UIImageViews
    
    private var viewModel: LaunchScreenViewModelTypeProtocol?
    
    private var countriesImages: [String] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LaunchScreenViewModel(from: self)
        countriesImages = self.viewModel?.input?.countriesImagesCarousel ?? []
        setupScrollView()
        setupBannerWidth()
        setupPageControl()
        adjustContentInset()
        populateStackViewWithImages()  // Dynamically add images
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.decelerationRate = .fast
        scrollView.clipsToBounds = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyRoundedCornersToImagesInStackView()
    }
    
    private func applyRoundedCornersToImagesInStackView() {
        for imageView in imageViews {
            imageView.layer.cornerRadius = 16
            imageView.layer.masksToBounds = true
        }
    }
    
    // MARK: - Setup Methods
    private func setupBannerWidth() {
        bannerWidth = UIScreen.main.bounds.width * 0.7
    }
    
    private func adjustContentInset() {
        let sideInset = UIScreen.main.bounds.width * 0.15
        scrollView.contentInset = UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = countriesImages.count
        pageControl.currentPage = 0
    }
    
    // Dynamically populate the stack view with images
    private func populateStackViewWithImages() {
        for (indx,imge) in countriesImages.enumerated() {
        
            let imageView = UIImageView(image: UIImage(named: imge) )
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            // Add the imageView to the stackView
            stackView.addArrangedSubview(imageView)
            
            // Maintain a 1:1 aspect ratio (height == width)
            imageView.widthAnchor.constraint(equalToConstant: bannerWidth).isActive = true
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true  // 1:1 aspect ratio
            imageViews.append(imageView)  // Add to the array for future reference
        }
    }
}

extension ViewController: LaunchScreenViewModelOutputProtocol {}
