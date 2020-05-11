# cordova-plugin-CompressImage

Cordova plugin for CompressImage 


## Notes
This plugin supports iOS and Android.    

## Installation
    cordova plugin add Cordova-Image-Compressor

## Quick Example

Call below function wherever required

```javascript

 ImageCompressor.getComprBase64('base64value', function(success){
   console.log('success') 
}, function(err){
    console.error(err);
});

```

#### Request Failed

Make sure you check the APK on a real device and not on an emulator.

