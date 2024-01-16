package com.activepilot.aircraft

import android.Manifest
import android.app.AlertDialog
import android.bluetooth.BluetoothManager
import android.content.*
import android.content.pm.PackageManager
import android.location.LocationManager
import android.os.*
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.noke.nokemobilelibrary.*
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import org.json.JSONException
import org.json.JSONObject
import java.lang.Exception


class MainActivity: FlutterActivity(), DemoWebClient.DemoWebClientCallback {

    private val EVENTS = "acpi.com.activepilot.aircraft/events"
    private var linksReceiver: BroadcastReceiver? = null
    private val CHANNEL = "acpi.com.activepilot.aircraft/channel"
    private var startString: String? = null
    private val CHANNEL_NOKE = "com.activepilot.aircraft/noke"
    private var resultNoke: MethodChannel.Result? = null
    private var mNokeService: NokeDeviceManagerService? = null
    private var currentNoke: NokeDevice? = null
    private var serialNoke: String = ""
    private var checkSerial: Boolean = false

    private val mServiceConnection = object : ServiceConnection {

        override fun onServiceConnected(className: ComponentName, rawBinder: IBinder) {
            Log.w(TAG, "ON SERVICE CONNECTED")
            //Store reference to service
            mNokeService = (rawBinder as NokeDeviceManagerService.LocalBinder).getService(NokeDefines.NOKE_LIBRARY_SANDBOX)
            mNokeService?.setAllowAllDevices(true);
            //Register callback listener
            mNokeService?.registerNokeListener(mNokeServiceListener)
            //Start bluetooth scanning
            mNokeService?.let {
                try {
                    it.startScanningForNokeDevices()
                } catch (e: Error) {
                    Log.d(TAG,e.toString())
                }
            }
            mNokeService?.let {
                if (!it.initialize()) {
                    Log.e(TAG, "Unable to initialize Bluetooth")
                }
            }
        }

        override fun onServiceDisconnected(classname: ComponentName) {
            mNokeService = null
        }
    }

    private val mNokeServiceListener = object : NokeServiceListener {
        override fun onNokeDiscovered(noke: NokeDevice) {
            var lockState = ""
            when (noke.lockState) {
                NokeDefines.NOKE_LOCK_STATE_LOCKED -> lockState = "Locked"
                NokeDefines.NOKE_LOCK_STATE_UNLOCKED -> lockState = "Unlocked"
                NokeDefines.NOKE_LOCK_STATE_UNSHACKLED -> lockState = "Unshackled"
                NokeDefines.NOKE_LOCK_STATE_UNKNOWN -> lockState = "Unknown"
            }
            currentNoke = noke
            mNokeService?.connectToNoke(currentNoke)
        }

        override fun onNokeConnecting(noke: NokeDevice) {
            Log.d(TAG,"onNokeConnecting")
        }

        override fun onNokeConnected(noke: NokeDevice) {
            if (checkSerial) {
                if(serialNoke == noke.mac) {
                    currentNoke = noke
                    mNokeService?.stopScanning()
                    this@MainActivity.runOnUiThread(java.lang.Runnable {
                        val statusResult = mapOf<String, Any>("status" to "Connected")
                        resultNoke?.success(statusResult)
                    })
                } else {
                    mNokeService?.stopScanning()
                    this@MainActivity.runOnUiThread(java.lang.Runnable {
                        val statusResult = mapOf<String, Any>("status" to "NoSerial", "serial" to "Serial back: $serialNoke Serial Noke: ${noke.serial}")
                        resultNoke?.success(statusResult)
                    })
                }
            } else {
                currentNoke = noke
                mNokeService?.stopScanning()
                this@MainActivity.runOnUiThread(java.lang.Runnable {
                    val statusResult = mapOf<String, Any>("status" to "Connected")
                    resultNoke?.success(statusResult)
                })
            }
        }

        override fun onNokeSyncing(noke: NokeDevice) {
            Log.d(TAG,"onNokeSyncing")
        }

        override fun onNokeUnlocked(noke: NokeDevice) {
            this@MainActivity.runOnUiThread(java.lang.Runnable {
                val statusResult = mapOf<String, Any>("status" to "Unlocked")
                resultNoke?.success(statusResult)
            })
        }

        override fun onNokeShutdown(noke: NokeDevice, isLocked: Boolean?, didTimeout: Boolean?) {
            Log.d(TAG,"onNokeShutdown")
        }

        override fun onNokeDisconnected(noke: NokeDevice) {
            currentNoke = null
            mNokeService?.startScanningForNokeDevices()
            mNokeService?.setBluetoothScanDuration(8000)
        }

        override fun onDataUploaded(result: Int, message: String) {
            Log.w(TAG, "DATA UPLOADED: $message")
        }

        override fun onBluetoothStatusChanged(bluetoothStatus: Int) {
            Log.d(TAG,"onBluetoothStatusChanged")
        }

        override fun onError(noke: NokeDevice, error: Int, message: String) {
            Log.e(TAG, "NOKE SERVICE ERROR $error: $message")
            when (error) {
                NokeMobileError.ERROR_LOCATION_PERMISSIONS_NEEDED -> {
                }
                NokeMobileError.ERROR_LOCATION_SERVICES_DISABLED -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    val handler = Handler(Looper.getMainLooper())
                    handler.post {
                        val alertDialog = AlertDialog.Builder(this@MainActivity).create()
                        alertDialog.setTitle(getString(R.string.location_access_required))
                        alertDialog.setMessage(getString(R.string.location_permission_request_message))
                        alertDialog.setButton(AlertDialog.BUTTON_NEUTRAL, "OK",
                                DialogInterface.OnClickListener { dialog, which -> dialog.dismiss() })
                        alertDialog.setOnDismissListener(DialogInterface.OnDismissListener { requestPermissions(arrayOf(Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION), PERMISSION_REQUEST_COARSE_LOCATION) })
                        alertDialog.show()
                    }
                }
                NokeMobileError.ERROR_BLUETOOTH_DISABLED -> {
                }
                NokeMobileError.ERROR_BLUETOOTH_GATT -> {
                }
                NokeMobileError.DEVICE_ERROR_INVALID_KEY -> {
                }
            }
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, CHANNEL_NOKE).setMethodCallHandler {
            call, result ->

            this.resultNoke = result

            if (call.method == "initNoke") {
                serialNoke = call.argument<String>("serial").toString();
                checkSerial = call.argument<Boolean>("checkSerial") as Boolean;
                initiateNokeService()
            } else if (call.method == "unlockNoke") {
                currentNoke?.let {
                    val demoWebClient = DemoWebClient()
                    demoWebClient.setWebClientCallback(this@MainActivity)
                    currentNoke?.let {
                        if (it.hardwareVersion.toLowerCase().contains("f")) {
                            demoWebClient.requestFobSync(it)
                        } else {
                            demoWebClient.requestUnlock(it, "")
                        }
                    }
                }
            }
        }

        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "initialLink") {
                if (startString != null) {
                    result.success(startString)
                }
            }
        }

        EventChannel(flutterEngine.dartExecutor, EVENTS).setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(args: Any?, events: EventChannel.EventSink) {
                        linksReceiver = createChangeReceiver(events)
                    }

                    override fun onCancel(args: Any?) {
                        linksReceiver = null
                    }
                }
        )
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        if (intent.action === Intent.ACTION_VIEW) {
            linksReceiver?.onReceive(this.applicationContext, intent)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val intent = getIntent()
        startString = intent.data?.toString()
    }

    private fun initiateNokeService() {

        if (ActivityCompat.checkSelfPermission(this@MainActivity,
                        Manifest.permission.ACCESS_FINE_LOCATION) ==
                PackageManager.PERMISSION_GRANTED || ActivityCompat.checkSelfPermission(this@MainActivity,
                        Manifest.permission.ACCESS_COARSE_LOCATION) ==
                PackageManager.PERMISSION_GRANTED) {
            openNoke()
        } else {
            requestPermission()
        }
    }

    private fun openNoke() {
        val mBluetoothManager = getSystemService(BLUETOOTH_SERVICE) as BluetoothManager

        if (mBluetoothManager != null) {
            var mBluetoothAdapter = mBluetoothManager.adapter
            if (mBluetoothAdapter == null || !mBluetoothAdapter.isEnabled) {
                val handler = Handler(Looper.getMainLooper())
                handler.post {
                    val alertDialog = AlertDialog.Builder(this@MainActivity,  R.style.MyAlertDialogStyle).create()
                    alertDialog.setTitle(getString(R.string.bluetooth_turn_on))
                    alertDialog.setMessage(getString(R.string.bluetooth_request_message))
                    alertDialog.setButton(AlertDialog.BUTTON_NEUTRAL, "OK",
                            DialogInterface.OnClickListener { dialog, which -> dialog.dismiss() })
                    alertDialog.setOnDismissListener(DialogInterface.OnDismissListener {

                    })
                    alertDialog.show()
                }
            } else {

                val lm = applicationContext.getSystemService(LOCATION_SERVICE) as LocationManager
                var gps_enabled = false
                var network_enabled = false
                try {
                    if (lm != null) {
                        gps_enabled = lm.isProviderEnabled(LocationManager.GPS_PROVIDER)
                        network_enabled = lm.isProviderEnabled(LocationManager.NETWORK_PROVIDER)
                    }
                } catch (e: Exception) { }
                if (!gps_enabled && !network_enabled) {
                    val handler = Handler(Looper.getMainLooper())
                    handler.post {
                        val alertDialog = AlertDialog.Builder(this@MainActivity,  R.style.MyAlertDialogStyle).create()
                        alertDialog.setTitle(getString(R.string.location_turn_on))
                        alertDialog.setMessage(getString(R.string.location_request_message))
                        alertDialog.setButton(AlertDialog.BUTTON_NEUTRAL, "OK",
                                DialogInterface.OnClickListener { dialog, which -> dialog.dismiss() })
                        alertDialog.setOnDismissListener(DialogInterface.OnDismissListener {

                        })
                        alertDialog.show()
                    }
                } else {
                    val nokeServiceIntent = Intent(this, NokeDeviceManagerService::class.java)
                    bindService(nokeServiceIntent, mServiceConnection, Context.BIND_AUTO_CREATE)
                }
            }
        }
    }

    private fun requestPermission() {
        if (ActivityCompat.shouldShowRequestPermissionRationale(this@MainActivity,
                        Manifest.permission.ACCESS_FINE_LOCATION)) {
            ActivityCompat.requestPermissions(this@MainActivity,
                    arrayOf(Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.WRITE_EXTERNAL_STORAGE), PERMISSION_REQUEST_COARSE_LOCATION)

        } else {
            ActivityCompat.requestPermissions(this@MainActivity,
                    arrayOf(Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.WRITE_EXTERNAL_STORAGE), PERMISSION_REQUEST_COARSE_LOCATION)

        }
    }

    fun createChangeReceiver(events: EventChannel.EventSink): BroadcastReceiver? {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) { // NOTE: assuming intent.getAction() is Intent.ACTION_VIEW
                val dataString = intent.dataString ?:
                events.error("UNAVAILABLE", "Link unavailable", null)
                events.success(dataString)
            }
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int,
                                            @NonNull permissions: Array<String>, @NonNull grantResults: IntArray) {

        if (requestCode == PERMISSION_REQUEST_COARSE_LOCATION) {
            if (grantResults.size == 3 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                openNoke()
            } else {
                Toast.makeText(applicationContext, "Permission Denied", Toast.LENGTH_SHORT).show()
            }
        }
    }

    override fun onUnlockReceived(response: String, noke: NokeDevice) {

        Log.d(TAG, "Unlock Received: $response")
        try {
            val obj = JSONObject(response)
            val result = obj.getString("result")
            if (result == "success") {
                val data = obj.getJSONObject("data")
                val commandString = data.getString("commands")
                currentNoke?.sendCommands(commandString)
            } else {
                this@MainActivity.runOnUiThread(java.lang.Runnable {
                    val statusResult = mapOf<String, Any>("status" to "Error")
                    resultNoke?.success(statusResult)
                })
            }
        } catch (e: JSONException) {
            Log.e(TAG, e.toString())
        }

    }

    companion object {

        val TAG = MainActivity::class.java.simpleName
        private val PERMISSION_REQUEST_COARSE_LOCATION = 1
        private val PERMISSION_REQUEST_FINE_LOCATION = 2
    }
}
