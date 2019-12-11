
package com.sunxingzhe.switchappicon;

import android.app.Activity;
import android.content.ComponentName;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

public class RNSwitchAppIconModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;
  private final PackageManager packageManager;
  private final String packageName;

  public RNSwitchAppIconModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
    this.packageManager = this.reactContext.getPackageManager();
    this.packageName = this.reactContext.getPackageName();
  }

  @Override
  public String getName() {
    return "RNSwitchAppIcon";
  }

  //启用组件
  public void enableComponent(ComponentName componentName){
    this.packageManager.setComponentEnabledSetting(componentName, PackageManager.COMPONENT_ENABLED_STATE_ENABLED, PackageManager.DONT_KILL_APP);
  }

  //禁用组件
  public void disableComponent(ComponentName componentName){
    this.packageManager.setComponentEnabledSetting(componentName, PackageManager.COMPONENT_ENABLED_STATE_DISABLED, PackageManager.DONT_KILL_APP);
  }

  @ReactMethod
  public void switchAppIconWithName(String name, Callback callback) {
    final Activity currentActivity = getCurrentActivity();
    if (currentActivity == null) {
      callback.invoke("activity is null");
    } else if (name.equals("")) {
      callback.invoke("name is empty string");
      ComponentName currentComponentName = currentActivity.getComponentName();
      if (!currentComponentName.getClassName().equals(this.packageName)) {
        ComponentName activityAlias = new ComponentName(this.packageName, this.packageName);
        disableComponent(currentComponentName);
        enableComponent(activityAlias);
        callback.invoke("");
      }
    } else {
      ComponentName currentComponentName = currentActivity.getComponentName();
      if (!currentComponentName.getClassName().equals(this.packageName + "." + name)) {
        ComponentName activityAlias = new ComponentName(this.packageName, this.packageName + "." + name);
        disableComponent(currentComponentName);
        enableComponent(activityAlias);
        callback.invoke("");
      }
    }
  }
}