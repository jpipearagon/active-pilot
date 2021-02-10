import UIKit
import Flutter
import NokeMobileLibrary

enum Actions: String {
    case initNoke
    case unlockNoke
}


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, NokeDeviceManagerDelegate, DemoWebClientDelegate {
    
    var currentNoke: NokeDevice?
    var resultStatus: String?
    var flutterResult: FlutterResult?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        
        NokeDeviceManager.shared().setAPIKey("eyJhbGciOiJOT0tFX01PQklMRV9TQU5EQk9YIiwidHlwIjoiSldUIn0.eyJhbGciOiJOT0tFX01PQklMRV9TQU5EQk9YIiwiY29tcGFueV91dWlkIjoiYjEwNDBlMWEtNWZhNS00Zjc0LThkYzctNTVlMGRlOWYxZWYwIiwiaXNzIjoibm9rZS5jb20ifQ.08b5ec24a8f67846ff446c99b32042172db38702")
        NokeDeviceManager.shared().setLibraryMode(NokeLibraryMode.SANDBOX)
        NokeDeviceManager.shared().setAllowAllNokeDevices(true)
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let nokeDiscoveryChannel = FlutterMethodChannel(name: "com.activepilot.aircraft/noke",
                                                        binaryMessenger: controller.binaryMessenger)
        
        nokeDiscoveryChannel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall,
                                                    result: @escaping FlutterResult) -> Void in
            guard let self = self else { return }
            self.flutterResult = result
            
            if call.method == Actions.initNoke.rawValue {
                NokeDeviceManager.shared().delegate = self
            }
            
            if call.method == Actions.unlockNoke.rawValue {
                guard let currentNoke = self.currentNoke else {
                    result("No current Noke")
                    return
                }
                DemoWebClient.shared().delegate = self
                DemoWebClient.shared().requestUnlock(noke: currentNoke)
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func nokeDeviceDidUpdateState(to state: NokeDeviceConnectionState, noke: NokeDevice) {
        switch state {
        case .Disconnected:
            NokeDeviceManager.shared().cacheUploadQueue()
            NokeDeviceManager.shared().startScanForNokeDevices()
            currentNoke = nil
            break
        case .Discovered:
            NokeDeviceManager.shared().stopScan()
            NokeDeviceManager.shared().connectToNokeDevice(noke)
            break
        case .Connected:
            guard let flutterResult = flutterResult else {
                return
            }
            flutterResult("Connected")
            currentNoke = noke
            break
        case .Unlocked:
            NokeDeviceManager.shared().startScanForNokeDevices()
            break
        default:
            break
        }
    }
    
    func nokeDeviceDidShutdown(noke: NokeDevice, isLocked: Bool, didTimeout: Bool) {
        
    }
    
    func nokeErrorDidOccur(error: NokeDeviceManagerError, message: String, noke: NokeDevice?) {
        
    }
    
    func didUploadData(result: Int, message: String) {
        
    }
    
    func bluetoothManagerDidUpdateState(state: NokeManagerBluetoothState) {
        switch (state) {
        case NokeManagerBluetoothState.poweredOn:
            debugPrint("NOKE MANAGER ON")
            NokeDeviceManager.shared().startScanForNokeDevices()
            break
        case NokeManagerBluetoothState.poweredOff:
            debugPrint("NOKE MANAGER OFF")
            break
        default:
            debugPrint("NOKE MANAGER UNSUPPORTED")
            break
        }
    }
    
    func nokeReadyForFirmwareUpdate(noke: NokeDevice) {
        
    }
    
    func didReceiveUnlockResponse(data: Data) {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        if let dictionary = json as? [String: Any]{
            let result = dictionary["result"] as! String
            if(result == "success"){
                print("REQUEST WORKED")
                let dataobj = dictionary["data"] as! [String:Any]
                let commandString = dataobj["commands"] as! String
                currentNoke?.sendCommands(commandString)
                guard let flutterResult = flutterResult else {
                    return
                }
                flutterResult("SUCCESS")
            }else{
                DispatchQueue.main.sync {
                    guard let flutterResult = flutterResult else {
                        return
                    }
                    flutterResult("REQUEST FAILED")
                    print("REQUEST FAILED")
                    
                }
            }
        }
    }
}
