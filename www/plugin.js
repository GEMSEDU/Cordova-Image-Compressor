
cordova.addConstructor(function() {
    function ImageCompressor() {

    }

    ImageCompressor.prototype.getComprBase64 = function( base64, successCallback, errorCallback ){
        cordova.exec(successCallback, errorCallback, "ImageCompressor", "getComprBase64", [base64]);
    }

   
    window.ImageCompressor = new ImageCompressor()
    return window.ImageCompressor
});
