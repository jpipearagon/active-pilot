package com.activepilot.aircraft

import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.os.Bundle
import android.util.Log

import com.noke.nokemobilelibrary.NokeDevice

import org.json.JSONObject

import java.io.BufferedReader
import java.io.DataOutputStream
import java.io.IOException
import java.io.InputStream
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL
import java.security.KeyManagementException
import java.security.NoSuchAlgorithmException

import javax.net.ssl.SSLContext

/**
 * Created by Spencer on 2/7/18.
 * Demo Web Client for making requests to demo server and show API implementation
 *
 */

internal class DemoWebClient {
    private val serverUrl = "https://coreapi-beta.uc.r.appspot.com/"
    private var mDemoWebClientCallback: DemoWebClientCallback? = null

    fun requestUnlock(noke: NokeDevice, email: String) {
        /* Note: This is an example request to a demo server, it does not represent a request to the Noke Core API.
         * Requests should not be made to the Core API directly from the mobile app.
         * Please refer to the documentation for more details
         * (https://github.com/noke-inc/noke-mobile-library-android#nok%C4%93-mobile-library-for-android)
         */

        val thread = Thread(Runnable {
            try {

                val jsonObject = JSONObject()

                jsonObject.accumulate("session", noke.session)
                jsonObject.accumulate("mac", noke.mac)
                val url = serverUrl + "unlock/"

                Log.w(TAG, "JSON: $jsonObject")

                mDemoWebClientCallback?.onUnlockReceived(POST(url, jsonObject), noke)


            } catch (e: Exception) {
                e.printStackTrace()
            }
        })

        thread.start()
    }

    fun requestUnshackle(noke: NokeDevice, email: String) {
        /* Note: This is an example request to a demo server, it does not represent a request to the Noke Core API.
         * Requests should not be made to the Core API directly from the mobile app.
         * Please refer to the documentation for more details
         * (https://github.com/noke-inc/noke-mobile-library-android#nok%C4%93-mobile-library-for-android)
         */

        val thread = Thread(Runnable {
            try {

                val jsonObject = JSONObject()

                jsonObject.accumulate("session", noke.session)
                jsonObject.accumulate("mac", noke.mac)
                val url = serverUrl + "unshackle/"

                mDemoWebClientCallback?.onUnlockReceived(POST(url, jsonObject), noke)


            } catch (e: Exception) {
                e.printStackTrace()
            }
        })

        thread.start()
    }

    fun requestFobSync(noke: NokeDevice) {
        /* Note: This is an example request to a demo server, it does not represent a request to the Noke Core API.
         * Requests should not be made to the Core API directly from the mobile app.
         * Please refer to the documentation for more details
         * (https://github.com/noke-inc/noke-mobile-library-android#nok%C4%93-mobile-library-for-android)
         */

        val thread = Thread(Runnable {
            try {

                val jsonObject = JSONObject()

                jsonObject.accumulate("session", noke.session)
                jsonObject.accumulate("mac", noke.mac)
                val url = serverUrl + "fobs/sync/"

                mDemoWebClientCallback?.onUnlockReceived(POST(url, jsonObject), noke)


            } catch (e: Exception) {
                e.printStackTrace()
            }
        })

        thread.start()
    }


    fun setWebClientCallback(callback: DemoWebClientCallback) {
        this.mDemoWebClientCallback = callback
    }

    interface DemoWebClientCallback {

        fun onUnlockReceived(response: String, noke: NokeDevice)
    }

    companion object {

        private val TAG = DemoWebClient::class.java.simpleName
        private val privateKey = "eyJhbGciOiJOT0tFX1BSSVZBVEUiLCJ0eXAiOiJKV1QifQ.eyJhbGciOiJOT0tFX1BSSVZBVEUiLCJjb21wYW55X3V1aWQiOiIyZmQ2MGM1NS0xNGRmLTQxZWUtYWUyYS0wYjliOTY0OGQxNWUiLCJpc3MiOiJub2tlLmNvbSJ9.a1138da380ba229cf31d1ddd547e301e282492d8"

        private fun POST(urlStr: String, jsonObject: JSONObject): String {
            val conn: HttpURLConnection
            val inputStream: InputStream?
            var result = ""
            System.setProperty("http.keepAlive", "false")
            Log.w("CLIENT", "JSON: $jsonObject")

            try {
                val url = URL(urlStr)
                conn = url.openConnection() as HttpURLConnection

                //Create the SSL connection
                val sc: SSLContext
                sc = SSLContext.getInstance("TLS")
                sc.init(null, null, java.security.SecureRandom())

                //set Timeout and method
                conn.readTimeout = 60000
                conn.connectTimeout = 60000
                conn.requestMethod = "POST"
                conn.doInput = true
                conn.useCaches = false
                conn.setRequestProperty("Content-Type", "application/json")
                conn.setRequestProperty("Connection", "close")
                conn.setRequestProperty("charset", "utf-8")
                conn.setRequestProperty("Authorization", "Bearer $privateKey")

                val wr = DataOutputStream(conn.outputStream)
                wr.writeBytes(jsonObject.toString())
                wr.flush()
                wr.close()

                // Add any data you wish to post here
                conn.connect()
                inputStream = conn.inputStream

                if (inputStream != null) {
                    result = convertInputStreamToString(inputStream)
                } else {
                    result = "Did not work!"
                }
            } catch (e: IOException) {
                e.printStackTrace()
            } catch (e: NoSuchAlgorithmException) {
                e.printStackTrace()
            } catch (e: KeyManagementException) {
                e.printStackTrace()
            }

            return result
        }

        @Throws(IOException::class)
        private fun convertInputStreamToString(inputStream: InputStream): String {
            val bufferedReader = BufferedReader(InputStreamReader(inputStream))
            val result = StringBuilder()
            var line: String? = bufferedReader.readLine()
            while (line != null) {
                result.append(line)
                line = bufferedReader.readLine()
            }
            inputStream.close()
            return result.toString()
        }
    }
}