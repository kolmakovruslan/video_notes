package io.github.kolmakovruslan.videonotes

import android.content.Intent
import android.os.Bundle
import android.support.v4.content.FileProvider
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File

class MainActivity : FlutterActivity() {

    private val channel = "io.github.kolmakovruslan.videonotes/share"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(flutterView, channel).setMethodCallHandler { call, result ->
            val url = call.arguments as String
            val intent = Intent(Intent.ACTION_SEND)
            intent.flags = Intent.FLAG_GRANT_READ_URI_PERMISSION
            val uri = FileProvider.getUriForFile(this, BuildConfig.APPLICATION_ID, File(url))
            intent.apply {
                action = Intent.ACTION_SEND
                putExtra(Intent.EXTRA_STREAM, uri)
                type = "video/mp4"
            }
            val pm = packageManager
            if (intent.resolveActivity(pm) != null) startActivity(intent)
        }
    }
}
