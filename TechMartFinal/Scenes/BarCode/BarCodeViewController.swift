//
//  BarCodeViewController.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/30/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class BarCodeViewController: UIViewController, BindableType, AVCaptureMetadataOutputObjectsDelegate {

    var viewModel: BarCodeViewModel!
    var video = AVCaptureVideoPreviewLayer()
    var barCode = PublishSubject<String>()
    
    @IBOutlet private weak var scanImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "BarCode"
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        barCode.onNext("")
    }
    
    func configView() {
        let session = AVCaptureSession()
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        } catch  {
            print("Error!")
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr,AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.code128,AVMetadataObject.ObjectType.code39, AVMetadataObject.ObjectType.code39Mod43,AVMetadataObject.ObjectType.code93, AVMetadataObject.ObjectType.dataMatrix,AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.ean8,AVMetadataObject.ObjectType.face, AVMetadataObject.ObjectType.interleaved2of5,AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.pdf417]
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        self.view.bringSubview(toFront: scanImageView)
        session.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            barCode.onNext(object.stringValue ?? "")
            return
        }
    }
    
    func bindViewModel() {
        let input = BarCodeViewModel.Input(barCode: barCode.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.goDetail
            .drive()
            .disposed(by: rx.disposeBag)
    }
}
extension BarCodeViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = Storyboards.barCode
}
