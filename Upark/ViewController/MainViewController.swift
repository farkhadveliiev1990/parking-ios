//
//  MainViewController.swift
//  Upark
//
//  Created by IT on 11/5/19.
//  Copyright © 2019 IT. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {

    @IBOutlet weak var logoUIV: UIView!
    @IBOutlet weak var menuUIB: UIButton!
    @IBOutlet weak var menuUIV: UIView!
    @IBOutlet weak var captureUIB: UIButton!
    @IBOutlet weak var historyUIB: UIButton!
    @IBOutlet weak var mapUIB: UIButton!
    @IBOutlet weak var contactUIB: UIButton!
    @IBOutlet weak var mainUIV: UIView!
    @IBOutlet weak var showUV: UIView!
    @IBOutlet weak var statusUV: UIView!
    
    var isClickedMenuUIB = false
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: captureDevice)
        } catch {
            return
        }
        
        if ((captureSession?.canAddInput(videoInput))!) {
            captureSession?.addInput(videoInput)
        } else {
            return
        }
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession!.addOutput(captureMetadataOutput)
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [
            AVMetadataObject.ObjectType.code128,
            AVMetadataObject.ObjectType.code93,
            AVMetadataObject.ObjectType.upce,
            AVMetadataObject.ObjectType.code39Mod43,
            AVMetadataObject.ObjectType.code39,
            AVMetadataObject.ObjectType.ean8,
            AVMetadataObject.ObjectType.ean13,
            AVMetadataObject.ObjectType.itf14,
            AVMetadataObject.ObjectType.interleaved2of5,
        ]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        captureSession!.startRunning()
        
        qrCodeFrameView = UIView()
         
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
        view.bringSubviewToFront(statusUV)
        view.bringSubviewToFront(showUV)
        
        initUIView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initUIView(){
        menuUIV.isHidden = true
         
        let maskPath = UIBezierPath.init(roundedRect: self.logoUIV.bounds, byRoundingCorners:[.bottomLeft, .bottomRight], cornerRadii: CGSize.init(width: 50.0, height: 50.0))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.logoUIV.bounds
        maskLayer.path = maskPath.cgPath
        self.logoUIV.layer.mask = maskLayer
        
        let maskPathCapturalUIB = UIBezierPath.init(roundedRect: self.captureUIB.bounds, byRoundingCorners:[.bottomLeft], cornerRadii: CGSize.init(width: 20.0, height: 20.0))
        let maskLayerCapturalUIB = CAShapeLayer()
        maskLayerCapturalUIB.frame = self.captureUIB.bounds
        maskLayerCapturalUIB.path = maskPathCapturalUIB.cgPath
        self.captureUIB.layer.mask = maskLayerCapturalUIB
        
        historyUIB.layer.masksToBounds = true
        historyUIB.layer.cornerRadius = historyUIB.frame.height/2
        historyUIB.layer.borderWidth = 2
        historyUIB.layer.borderColor = UIColor(named: "color_border")?.cgColor
        
        contactUIB.layer.masksToBounds = true
        contactUIB.layer.cornerRadius = contactUIB.frame.height/2
        contactUIB.layer.borderWidth = 2
        contactUIB.layer.borderColor = UIColor(named: "color_border")?.cgColor
        
        mapUIB.layer.masksToBounds = true
        mapUIB.layer.cornerRadius = mapUIB.frame.height/2
        mapUIB.layer.borderWidth = 2
        mapUIB.layer.borderColor = UIColor(named: "color_border")?.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleMainTap))
        mainUIV.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func handleMainTap(){
        logoUIV.isHidden = false
        menuUIB.isHidden = false
        menuUIV.isHidden = true
        isClickedMenuUIB = false
    }
    
    @IBAction func clickMenuUIB(_ sender: Any) {
        if isClickedMenuUIB == false {
           logoUIV.isHidden = true
           menuUIB.isHidden = true
           menuUIV.isHidden = false
           isClickedMenuUIB = true
       }
       else {
           logoUIV.isHidden = false
           menuUIB.isHidden = false
           menuUIV.isHidden = true
           isClickedMenuUIB = false
       }
    }
    
    @IBAction func clickCapturUIB(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CaptureViewController") as! CaptureViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickHistorialUIB(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickMapaUIB(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickContactUIB(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MainViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            print("No QR code is detected")
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type != AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                print(metadataObj.stringValue!)
            }
        }
    }
}

