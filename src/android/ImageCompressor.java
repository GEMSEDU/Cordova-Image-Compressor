
package com.cordova.imgcompressor;

import org.apache.cordova.*;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.apache.cordova.PluginResult.Status;
import org.json.JSONObject;
import org.json.JSONArray;
import org.json.JSONException;

import android.util.Log;
import android.net.Uri;
import android.content.ContentUris;
import android.graphics.Bitmap;

import java.util.Date;
import java.io.File;
import java.io.IOException;
import java.util.concurrent.Callable;
import android.os.Environment;

import java.io.OutputStream;
import java.io.ByteArrayOutputStream;
import android.graphics.BitmapFactory;
import android.util.Base64;

public class ImageCompressor extends CordovaPlugin {
  private static final String TAG = "ImageCompressor";
      private static final String GET_COMPRESS_IMAGE = "getComprBase64";
  private Bitmap.CompressFormat compressFormat = Bitmap.CompressFormat.JPEG;
   
  @Override
  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
    super.initialize(cordova, webView);

    Log.i(TAG, "Initializing ImageCompressor Plugin");
  }

    public boolean execute(String action, CordovaArgs args, CallbackContext callbackContext) throws JSONException {
      
        if (action.equals(GET_COMPRESS_IMAGE)) {
            getComprBase64(args.optString(0),callbackContext);
        } else {
            Log.i(TAG, "This action doesn't exist");
            return false;
        }
        return true;
    }
  
    public void getComprBase64(String base64,  CallbackContext callbackContext) {
     
                final Bitmap bitmapRes = ConvertBasetoBit(base64);
                final String compressedBase64 = BitMapToString(bitmapRes);
                Log.i(TAG, "Sucess Plugin base64 compressed Image" + compressedBase64);
                callbackContext.success(compressedBase64);
         
       // return compressedBase64;
    }
    
    public static Bitmap ConvertBasetoBit(final String base64) {
     
        final String encodedImage = base64;
        final byte[] decodedString = Base64.decode(encodedImage, 0);
              Log.i(TAG,"temp encodedImage==>"+ encodedImage);
        final Bitmap decodedByte = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
        return decodedByte;
    }
    
    public static String BitMapToString(final Bitmap bitmap) {
        final ByteArrayOutputStream baos = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.JPEG, 70, (OutputStream)baos);
        final byte[] b = baos.toByteArray();
        final String temp = new String(Base64.encode(b, 2));
        Log.i(TAG,"temp Bsde64==>"+ temp);
        return temp;
    }

}
