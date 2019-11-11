package ui.apptour;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.graphics.Color;
import android.graphics.Rect;
import android.graphics.Typeface;
import android.util.Log;
import androidx.annotation.Nullable;
import android.app.Dialog;
import android.view.View;
import android.app.AlertDialog;
import android.content.Context;
import android.content.res.AssetManager;

import com.facebook.react.uimanager.UIManagerModule;
import com.facebook.react.uimanager.UIBlock;
import com.facebook.react.uimanager.NativeViewHierarchyManager;

import com.facebook.common.internal.Objects;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactContext;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;

import com.facebook.react.modules.core.DeviceEventManagerModule;

import com.getkeepsafe.taptargetview.TapTargetSequence;
import com.getkeepsafe.taptargetview.TapTargetView;
import com.getkeepsafe.taptargetview.TapTarget;

import java.util.ArrayList;
import java.util.List;



public class RNAppTourModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;
    private AssetManager AssetManager;

    public RNAppTourModule(ReactApplicationContext reactContext) {
        super(reactContext);

        this.reactContext = reactContext;
        this.AssetManager = reactContext.getApplicationContext().getAssets();
    }

    @Override
    public String getName() {
        return "RNAppTour";
    }

    private void sendEvent(ReactContext reactContext,
                           String eventName,
                           @Nullable WritableMap params) {
        reactContext
        .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
        .emit(eventName, params);
    }

    @ReactMethod
    public void ShowSequence(final ReadableArray views, final ReadableMap props, final Promise promise) {
        // findViewById is faster than UIManagerModule, avoid bug
        boolean canGetRefAllViews = true;
        final List<TapTarget> targetViews = new ArrayList<TapTarget>();
        for (int i = 0; i < views.size(); i++) {
            int viewId = views.getInt(i);
            View view = this.getCurrentActivity().findViewById(viewId);
            if (view == null) {
              canGetRefAllViews = false;
              break;
            }
            targetViews.add(generateTapTarget(view, props.getMap(String.valueOf(viewId))));
        }

        if (canGetRefAllViews) {
          showSequence(targetViews);
        }
        else {
          // Try to get reference by UIManagerModule
          UIManagerModule uiManager = reactContext.getNativeModule(UIManagerModule.class);
          targetViews.clear();
          uiManager.addUIBlock(new UIBlock() {
              @Override
              public void execute(NativeViewHierarchyManager nativeViewHierarchyManager) {
                  for (int i = 0; i < views.size(); i++) {
                      int viewId = views.getInt(i);
                      View view = nativeViewHierarchyManager.resolveView(viewId);
                      targetViews.add(generateTapTarget(view, props.getMap(String.valueOf(viewId))));
                  }
                  showSequence(targetViews);
              }
          });
        }
    }

    private void showSequence(final List<TapTarget> targetViews) {
      final Activity activity = this.getCurrentActivity();
      final Dialog dialog = new AlertDialog.Builder(activity).create();
      activity.runOnUiThread(new Runnable() {
          @Override
          public void run() {
              TapTargetSequence tapTargetSequence = new TapTargetSequence(dialog).targets(targetViews);
              tapTargetSequence.listener(new TapTargetSequence.Listener() {
                  @Override
                  public void onSequenceFinish() {
                      WritableMap params = Arguments.createMap();
                      params.putBoolean("finish", true);
                      sendEvent(reactContext, "onFinishSequenceEvent", params);
                      // dismiss dialog on finish
                      if (dialog != null && dialog.isShowing()) {
                          dialog.dismiss();
                      }

                  }

                  @Override
                  public void onSequenceStep(TapTarget lastTarget, boolean targetClicked) {
                      WritableMap params = Arguments.createMap();
                      params.putBoolean("next_step", true);
                      sendEvent(reactContext, "onShowSequenceStepEvent", params);
                  }

                  @Override
                  public void onSequenceCanceled(TapTarget lastTarget) {
                      WritableMap params = Arguments.createMap();
                      params.putBoolean("cancel_step", true);
                      sendEvent(reactContext, "onCancelStepEvent", params);
                      if (dialog != null && dialog.isShowing()) {
                          dialog.dismiss();
                      }
                  }

              })
              .continueOnCancel(true);
              tapTargetSequence.start();
          }
    });
    }

    @ReactMethod
    public void ShowFor(final int view, final ReadableMap props, final Promise promise) {
        final Activity activity = this.getCurrentActivity();
        final Dialog dialog = new AlertDialog.Builder(activity).create();

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                UIManagerModule uiManager = reactContext.getNativeModule(UIManagerModule.class);

                uiManager.addUIBlock(new UIBlock() {
                    @Override
                    public void execute(NativeViewHierarchyManager nativeViewHierarchyManager) {
                        View refView = nativeViewHierarchyManager.resolveView(view);
                        // We don't support skip button
                        TapTarget targetView = generateTapTarget(refView, props);
                        targetView.skipTextVisible(false);
                        TapTargetView.showFor(dialog, targetView);
                    }
                });
            }
        });
    }

    private TapTarget generateTapTarget(final View view, final ReadableMap props) {
        final Activity activity = this.getCurrentActivity();

        final String title = props.getString("title");
        String description = null;
        String skipText = "skip";
        String outerCircleColor = null;
        String targetCircleColor = null;
        String titleTextColor = null;
        String descriptionTextColor = null;
        String skipTextColor = null;
        String skipButtonBackgroundColor = null;
        String textColor = null;
        String dimColor = null;
        String fontFamily = null;

        if (props.hasKey("description") && !props.isNull("description")) {
            description = props.getString("description");
        }
        if (props.hasKey("skipText") && !props.isNull("skipText")) {
            skipText = props.getString("skipText");
        }
        if (props.hasKey("outerCircleColor") && !props.isNull("outerCircleColor")) {
            outerCircleColor = props.getString("outerCircleColor");
        }
        if (props.hasKey("targetCircleColor") && !props.isNull("targetCircleColor")) {
            targetCircleColor = props.getString("targetCircleColor");
        }
        if (props.hasKey("titleTextColor") && !props.isNull("titleTextColor")) {
            titleTextColor = props.getString("titleTextColor");
        }
        if (props.hasKey("descriptionTextColor") && !props.isNull("descriptionTextColor")) {
            descriptionTextColor = props.getString("descriptionTextColor");
        }
        if (props.hasKey("skipTextColor") && !props.isNull("skipTextColor")) {
            skipTextColor = props.getString("skipTextColor");
        }
        if (props.hasKey("skipButtonBackgroundColor") && !props.isNull("skipButtonBackgroundColor")) {
            skipButtonBackgroundColor = props.getString("skipButtonBackgroundColor");
        }
        if (props.hasKey("textColor") && !props.isNull("textColor")) {
            textColor = props.getString("textColor");
        }
        if (props.hasKey("dimColor") && !props.isNull("dimColor")) {
            dimColor = props.getString("dimColor");
        }
        if (props.hasKey("fontFamily") && !props.isNull("fontFamily")) {
            fontFamily = props.getString("fontFamily");
        }


        //Other Props
        float outerCircleAlpha = 0.96f;
        int titleTextSize = 20;
        int descriptionTextSize = 10;
        int skipTextSize = 24;
        int targetRadius = 60;
        int rectTargetBorderRadius = 0;
        int skipButtonMargin = -1;
        int skipButtonMarginLeft = -1;
        int skipButtonMarginRight = -1;
        int skipButtonMarginTop = -1;
        int skipButtonMarginBottom = -1;
        int skipButtonMarginHorizontal = -1;
        int skipButtonMarginVertical = -1;
        boolean drawShadow = true;
        boolean cancelable = true;
        boolean tintTarget = true;
        boolean transparentTarget = true;
        boolean isRect = false;
        boolean skipTextVisible = false;

        try {
            outerCircleAlpha = (float) props.getDouble("outerCircleAlpha");
        } catch (Exception e) {
        }
        try {
            titleTextSize = props.getInt("titleTextSize");
        } catch (Exception e) {
        }
        try {
            descriptionTextSize = props.getInt("descriptionTextSize");
        } catch (Exception e) {
        }
        try {
            skipTextSize = props.getInt("skipTextSize");
        } catch (Exception e) {
        }
        try {
            rectTargetBorderRadius = props.getInt("rectTargetBorderRadius");
        } catch (Exception e) {
        }
        try {
            drawShadow = props.getBoolean("drawShadow");
        } catch (Exception e) {
        }
        try {
            cancelable = props.getBoolean("cancelable");
        } catch (Exception e) {
        }
        try {
            tintTarget = props.getBoolean("tintTarget");
        } catch (Exception e) {
        }
        try {
            transparentTarget = props.getBoolean("transparentTarget");
        } catch (Exception e) {
        }
        try {
            targetRadius = props.getInt("targetRadius");
        } catch (Exception e) {
        }
        try {
            skipTextVisible = props.getBoolean("isSkipButtonVisible");
        } catch (Exception e) {
        }
        try {
            isRect = props.getBoolean("isRect");
        } catch (Exception e) {
        }
        try {
            skipButtonMargin = props.getInt("skipButtonMargin");
        } catch (Exception e) {
        }
        try {
            skipButtonMarginLeft = props.getInt("skipButtonMarginLeft");
        } catch (Exception e) {
        }
        try {
            skipButtonMarginRight = props.getInt("skipButtonMarginRight");
        } catch (Exception e) {
        }
        try {
            skipButtonMarginTop = props.getInt("skipButtonMarginTop");
        } catch (Exception e) {
        }
        try {
            skipButtonMarginBottom = props.getInt("skipButtonMarginBottom");
        } catch (Exception e) {
        }
        try {
            skipButtonMarginHorizontal = props.getInt("skipButtonMarginHorizontal");
        } catch (Exception e) {
        }
        try {
            skipButtonMarginVertical = props.getInt("skipButtonMarginVertical");
        } catch (Exception e) {
        }


        float finalOuterCircleAlpha = outerCircleAlpha;
        int finalTitleTextSize = titleTextSize;
        int finalDescriptionTextSize = descriptionTextSize;
        int finalSkipTextSize = skipTextSize;
        boolean finalDrawShadow = drawShadow;
        boolean finalCancelable = cancelable;
        boolean finalTintTarget = tintTarget;
        boolean finalTransparentTarget = transparentTarget;
        boolean finalIsRect = isRect;
        int finalTargetRadius = targetRadius;
        int finalRectTargetBorderRadius = rectTargetBorderRadius;

        TapTarget targetView = TapTarget.forView(view, title, description, skipText);

        if (outerCircleColor != null && outerCircleColor.length() > 0)
            targetView.outerCircleColorInt(Color.parseColor(outerCircleColor));
        if (targetCircleColor != null && targetCircleColor.length() > 0)
            targetView.targetCircleColorInt(Color.parseColor(targetCircleColor));
        if (titleTextColor != null && titleTextColor.length() > 0)
            targetView.titleTextColorInt(Color.parseColor(titleTextColor));
        if (descriptionTextColor != null && descriptionTextColor.length() > 0)
            targetView.descriptionTextColorInt(Color.parseColor(descriptionTextColor));
        if (skipTextColor != null && skipTextColor.length() > 0)
            targetView.skipTextColorInt(Color.parseColor(skipTextColor));
        if (skipButtonBackgroundColor != null && skipButtonBackgroundColor.length() > 0)
            targetView.skipButtonBackgroundColorInt(Color.parseColor(skipButtonBackgroundColor));
        if (textColor != null && textColor.length() > 0)
            targetView.textColorInt(Color.parseColor(textColor));
        if (dimColor != null && dimColor.length() > 0)
            targetView.dimColorInt(Color.parseColor(dimColor));
        if (fontFamily != null && fontFamily.length() > 0) {
            Typeface font = Typeface.createFromAsset(this.AssetManager, "fonts/" + fontFamily + ".ttf");
            targetView.textTypeface(font);
        }

        targetView.outerCircleAlpha(finalOuterCircleAlpha);
        targetView.titleTextSize(finalTitleTextSize);
        targetView.descriptionTextSize(finalDescriptionTextSize);
        targetView.skipTextSize(finalSkipTextSize);
        targetView.drawShadow(finalDrawShadow);
        targetView.cancelable(finalCancelable);
        targetView.tintTarget(finalTintTarget);
        targetView.transparentTarget(finalTransparentTarget);
        targetView.targetRadius(finalTargetRadius);
        targetView.skipTextVisible(skipTextVisible);
        targetView.rectTarget(finalIsRect);
        targetView.rectTargetBorderRadius(finalRectTargetBorderRadius);
        
        // margin skipButton
        if (skipButtonMargin != -1) {
            targetView.skipButtonMargin(skipButtonMargin);
        }
        if (skipButtonMarginLeft != -1) {
            targetView.skipButtonMarginLeft(skipButtonMarginLeft);
        }
        if (skipButtonMarginRight != -1) {
            targetView.skipButtonMarginRight(skipButtonMarginRight);
        }
        if (skipButtonMarginTop != -1) {
            targetView.skipButtonMarginTop(skipButtonMarginTop);
        }
        if (skipButtonMarginBottom != -1) {
            targetView.skipButtonMarginBottom(skipButtonMarginBottom);
        }
        if (skipButtonMarginHorizontal != -1) {
            targetView.skipButtonMarginHorizontal(skipButtonMarginHorizontal);
        }
        if (skipButtonMarginVertical != -1) {
            targetView.skipButtonMarginVertical(skipButtonMarginVertical);
        }

        return targetView;
    }
}
