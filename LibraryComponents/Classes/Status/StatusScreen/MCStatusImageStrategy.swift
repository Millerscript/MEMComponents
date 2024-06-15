//
//  MCStatusImageStrategy.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 11/06/24.
//

import Foundation
import UIKit
import Kingfisher
import Combine
import MEMBase

class MCStatusImageStrategy: MCStatusStrategy {

    private var container: UIView = .newSet()
    private var blurImageView: UIImageView = .newSet()
    private var imageView: UIImageView = .newSet()
    public var subject: PassthroughSubject<Void, NSError> = PassthroughSubject()
    public var cancellable = Set<AnyCancellable>()
    
    // MARK: - Computed properties
    private var blurImageProcessor: ImageProcessor {
        BlurImageProcessor(blurRadius: 16)
    }
    
    public init() {
        addHierarchy()
        setConstraints()
    }
    
    func attach(parent: UIView) {
        container.tag = 200000
        container.backgroundColor = .black.withAlphaComponent(0.6)
        parent.addSubview(container)
        container.hookingToParentView()
    }
    
    func download<T>(data: T) {
        guard let data = data.self as? URL else { return }
        resetImage()
        download(url: data, options: [.scaleFactor(UIScreen.main.scale), .cacheOriginalImage])
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
                
                subject.send(completion: .failure(NSError(domain: error.localizedDescription, code: error.errorCode)))
            }
        }
    }
    
}
