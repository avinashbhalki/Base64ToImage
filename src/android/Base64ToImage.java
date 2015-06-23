package com.samvas.Base64ToImage;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;




//import android.content.Context;
import android.os.Environment;
import android.util.Base64;
import android.util.Log;

public class Base64ToImage extends CordovaPlugin {


	@Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        if (action.equals("base64ToImage")) {
            
            String imageData = args.getString(0);
            String imageName = args.getString(1) + ".jpg";

            File directory = new File(Environment.getExternalStorageDirectory() + "/Android/data/com.samevainc.CloseOut/cache/CapturedPhotos/");

            Log.i("Plugin", "Path: " + directory.toString());
            System.out.println();
            
            boolean success = true;
            if (!directory.exists()) {
                success = directory.mkdir();
            }
            
            String extStorageDirectory = directory.toString();

            //Create New file and name it Image2.PNG
            File file1 = new File(extStorageDirectory, imageName );
            
            String testfile = file1.toString();
            try {
				file1.createNewFile();
				
				
				////////////////////////////////
				
				FileOutputStream fos = new FileOutputStream(testfile);
			    try
			    {

			    if (imageData != null) 
			    {
			    	byte[] decodedBytes = Base64.decode(imageData, 0);
			        fos.write(decodedBytes);

			        fos.flush();
			        fos.close();

			        }

			    } catch (Exception e)
			    {

			    } finally 
			    {	
			        if (fos != null)
			        {
			        	fos.close();
			        }
			    }
				///////////////////////////////////
				
		        
			} catch (IOException e) {
				e.printStackTrace();
			}
            
            this.base64ToImage("/" + imageName, callbackContext);
            
            return true;
            
        }
        return false;
        
    }

	private void base64ToImage(String message, CallbackContext callbackContext) {
        if (message != null && message.length() > 0) {
            callbackContext.success(message);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }
}