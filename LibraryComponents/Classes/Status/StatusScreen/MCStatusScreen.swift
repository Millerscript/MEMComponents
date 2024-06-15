//
//  MCStatusScreen.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 22/05/24.
//

import Foundation
import Kingfisher
import UIKit
import Combine
import MEMBase


// TODO: Remove
public class MCStatusScreen {
    
    // Proof Of Concept
    
    // https://i.pinimg.com/originals/07/32/a9/0732a926b2a3b8a308fca7cc48c9e221.jpg
    private var container: UIView = .newSet()
    private var blurImageView: UIImageView = .newSet()
    private var imageView: UIImageView = .newSet()
    
    // MARK: - Computed properties
    private var blurImageProcessor: ImageProcessor {
        BlurImageProcessor(blurRadius: 16)
    }
    
    public let subject: PassthroughSubject<Void, KingfisherError> = PassthroughSubject()
    public var cancellable = Set<AnyCancellable>()
    public init() {
        addHierarchy()
        setConstraints()
    }
    
    private func addHierarchy() {
        container.addSubview(blurImageView)
        container.addSubview(imageView)
    }
    
    private func setConstraints() {
        blurImageView.hookingToParentView()
        
        imageView.hook(.left, to: .left, of: container)
        imageView.hook(.right, to: .right, of: container)
        imageView.hookSafeArea(.top, to: .top, of: container, valueInset: 100)
        imageView.hook(.bottom, to: .bottom, of: container, valueInset: -80)
        
        imageView.contentMode = .scaleAspectFill
        blurImageView.contentMode = .scaleAspectFill
    }
    
    public func add(parent: UIView) {
        container.backgroundColor = .black.withAlphaComponent(0.6)
        parent.addSubview(container)
        container.hookingToParentView()        
    }
    
    public func downloadImage(imageUrl: String) {
        resetImage()
        let url = URL(string: imageUrl)
        guard let url = url else {return}
        download(url: url, options: [.scaleFactor(UIScreen.main.scale), .cacheOriginalImage])
    }
    
    private func resetImage() {
        imageView.image = nil
        blurImageView.image = nil
    }
    
    private func download(url: URL, options: KingfisherOptionsInfo) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, options: options) { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(let value):
                blurImageView.kf.setImage(with: value.source, options: [.processor(blurImageProcessor)])
                subject.send()
            case .failure(let error):
                subject.send(completion: .failure(error))
            }
        }
    }
    
}
