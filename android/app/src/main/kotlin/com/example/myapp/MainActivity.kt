package com.example.myapp

import android.os.Bundle
import android.provider.MediaStore
import android.content.ContentValues
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.OutputStream

class MainActivity : FlutterActivity() {
    private val CHANNEL = "media_store_channel"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL).setMethodCallHandler {
            call, result -> if(call.method == "saveFileToDownloads"){
                val bytes = call.argument<ByteArray>("bytes")
                val fileName = call.argument<String>("fileName")
                val mimeType = call.argument<String>("mimeType")
                val folderName = call.argument<String>("folder")
                if(bytes != null && fileName != null && mimeType != null && folderName != null){
                    try{
                        val resolver = applicationContext.contentResolver
                        val contentValues = ContentValues().apply {
                            put(MediaStore.MediaColumns.DISPLAY_NAME,fileName)
                            put(MediaStore.MediaColumns.MIME_TYPE,mimeType)
                            put(MediaStore.MediaColumns.RELATIVE_PATH, "Download/$folderName")
                            put(MediaStore.MediaColumns.IS_PENDING,1)
                        }
                        val uri : Uri? = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI,contentValues)
                        if(uri != null){
                            val outputStream : OutputStream? = resolver.openOutputStream(uri)
                                outputStream?.write(bytes)
                                outputStream?.close()
                                contentValues.clear()
                                contentValues.put(MediaStore.MediaColumns.IS_PENDING,0)
                                resolver.update(uri,contentValues,null,null)

                        result.success("Download Completed: $fileName")


                    }else{
                        result.error("URI_NULL","URI null returned",null)
                    }
                }catch(e: Exception){
                    result.error("ERROR",e.message,null)

                } 

            }else{
                result.error("INVALID_ARGS","Invalid Arguments",null)

            }
        } else{
            result.notImplemented()
        }
    }
}}
