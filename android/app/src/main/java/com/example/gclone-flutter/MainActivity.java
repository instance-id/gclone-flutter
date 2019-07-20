package com.example.gclone;
import android.os.Bundle;
import gonativelib.DataProcessor;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {
  DataProcessor goNativeDataProcessor = new DataProcessor();
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
  }
}