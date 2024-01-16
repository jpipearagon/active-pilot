import UIKit
import Flutter
import NokeMobileLibrary

enum Actions: String {
    case initNoke
    case unlockNoke
}


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, NokeDeviceManagerDelegate, DemoWebClientDelegate {
    
    private var eventChannel: FlutterEventChannel?
    private var methodChannel: FlutterMethodChannel?
    var currentNoke: NokeDevice?
    var flutterResult: FlutterResult?
    var serialNoke: String = ""
    var checkSerial: Bool = false
    private let linkStreamHandler = LinkStreamHandler()
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        
        NokeDeviceManager.shared().setAPIKey("eyJhbGciOiJOT0tFX1BSSVZBVEUiLCJ0eXAiOiJKV1QifQ.eyJhbGciOiJOT0tFX1BSSVZBVEUiLCJjb21wYW55X3V1aWQiOiIyZmQ2MGM1NS0xNGRmLTQxZWUtYWUyYS0wYjliOTY0OGQxNWUiLCJpc3MiOiJub2tlLmNvbSJ9.a1138da380ba229cf31d1ddd547e301e282492d8")
        NokeDeviceManager.shared().setLibraryMode(NokeLibraryMode.PRODUCTION)
        NokeDeviceManager.shared().setAllowAllNokeDevices(true)
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let nokeDiscoveryChannel = FlutterMethodChannel(name: "com.activepilot.aircraft/noke",
                                                        binaryMessenger: controller.binaryMessenger)
        
        nokeDiscoveryChannel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall,
                                                    result: @escaping FlutterResult) -> Void in
            guard let self = self else { return }
            self.flutterResult = result
            
            if call.method == Actions.initNoke.rawValue {
                if let args = call.arguments as? [String: Any] {
                    self.serialNoke = args["serial"] as? String ?? ""
                    self.checkSerial = args["checkSerial"] as? Bool ?? false
                }
                NokeDeviceManager.shared().delegate = self
            }
            
            if call.method == Actions.unlockNoke.rawValue {
                guard let currentNoke = self.currentNoke else {
                    result("No current Noke")
                    return
                }
                
                /*if checkSerial {
                    if serialNoke == noke.serial {
                        
                    } else {
                        flutterResult("NoSerial")
                    }
                } else {
                    flutterResult("Unlocked")
                }*/
                
                DemoWebClient.shared().delegate = self
                DemoWebClient.shared().requestUnlock(noke: currentNoke)
            }
        })
        
        methodChannel = FlutterMethodChannel(name: "acpi.com.activepilot.aircraft/channel", binaryMessenger: controller.binaryMessenger)
           
        methodChannel?.setMethodCallHandler({ (call: FlutterMethodCall, result: FlutterResult) in
              guard call.method == "initialLink" else {
                result(FlutterMethodNotImplemented)
                return
              }
            })
        
        eventChannel = FlutterEventChannel(name: "acpi.com.activepilot.aircraft/events", binaryMessenger: controller.binaryMessenger)
              
        eventChannel?.setStreamHandler(linkStreamHandler)
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
       eventChannel?.setStreamHandler(linkStreamHandler)
       return linkStreamHandler.handleLink(url.absoluteString)
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
            var statusResult: [String: Any] = [:]
            if checkSerial {
                if serialNoke == noke.mac {
                    statusResult["status"] = "Connected"
                    flutterResult(statusResult)
                    currentNoke = noke
                } else {
                    statusResult["status"] = "NoSerial"
                    statusResult["serial"] = "Serial back: \(serialNoke) Serial Noke: \(noke.mac)"
                    flutterResult(statusResult)
                }
            } else {
                statusResult["status"] = "Connected"
                flutterResult(statusResult)
                currentNoke = noke
            }
            break
        case .Unlocked:
            guard let flutterResult = flutterResult else {
                return
            }
            var statusResult: [String: Any] = [:]
            statusResult["status"] = "Unlocked"
            flutterResult(statusResult)
            
            NokeDeviceManager.shared().startScanForNokeDevices()
            break
        case .Error:
            debugPrint("Error")
            break
        default:
            break
        }
    }
    
    func nokeDeviceDidShutdown(noke: NokeDevice, isLocked: Bool, didTimeout: Bool) {
        debugPrint("nokeDeviceDidShutdown")
    }
    
    func nokeErrorDidOccur(error: NokeDeviceManagerError, message: String, noke: NokeDevice?) {
        debugPrint("nokeErrorDidOccur")
    }
    
    func didUploadData(result: Int, message: String) {
        debugPrint("didUploadData")
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
            }else{
                DispatchQueue.main.sync {
                    guard let flutterResult = flutterResult else {
                        return
                    }
                    var statusResult: [String: Any] = [:]
                    statusResult["status"] = "failed"
                    flutterResult(statusResult)
                }
            }
        }
    }
}

class LinkStreamHandler:NSObject, FlutterStreamHandler {
  
  var eventSink: FlutterEventSink?
  
  // links will be added to this queue until the sink is ready to process them
  var queuedLinks = [String]()
  
  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = events
    queuedLinks.forEach({ events($0) })
    queuedLinks.removeAll()
    return nil
  }
  
  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    self.eventSink = nil
    return nil
  }
  
  func handleLink(_ link: String) -> Bool {
    guard let eventSink = eventSink else {
      queuedLinks.append(link)
      return false
    }
    eventSink(link)
    return true
  }
}
