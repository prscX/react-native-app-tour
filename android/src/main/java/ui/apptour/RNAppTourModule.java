package ui.apptour;

import android.app.Activity;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.graphics.Color;
import android.util.Log;
import android.support.annotation.Nullable;
import android.app.Dialog;
import android.view.View;
import android.app.AlertDialog;

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

    public RNAppTourModule(ReactApplicationContext reactContext) {
        super(reactContext);
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
        final Activity activity = this.getCurrentActivity();
        final List<TapTarget> targetViews = new ArrayList<TapTarget>();

        final Dialog dialog = new AlertDialog.Builder(activity).create();

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                UIManagerModule uiManager = getReactApplicationContext().getNativeModule(UIManagerModule.class);

                uiManager.addUIBlock(new UIBlock() {
                    @Override
                    public void execute(NativeViewHierarchyManager nativeViewHierarchyManager) {
                        for (int i = 0; i < views.size(); i++) {
                            int view = views.getInt(i);

                            View refView = nativeViewHierarchyManager.resolveView(view);
                            targetViews.add(generateTapTarget(refView, props.getMap(String.valueOf(view))));
                        }

                        TapTargetSequence tapTargetSequence = new TapTargetSequence(dialog).targets(targetViews);
                        tapTargetSequence.listener(new TapTargetSequence.Listener() {
                            @Override
                            public void onSequenceFinish() {
                                WritableMap params = Arguments.createMap();
                                params.putBoolean("finish", true);

                                sendEvent(getReactApplicationContext(), "onFinishSequenceEvent", params);

                                // dismiss dialog on finish
                                if (dialog != null && dialog.isShowing()) {
                                    dialog.dismiss();
                                }
                            }

                            @Override
                            public void onSequenceStep(TapTarget lastTarget, boolean targetClicked) {
                                WritableMap params = Arguments.createMap();
                                params.putBoolean("next_step", true);

                                sendEvent(getReactApplicationContext(), "onShowSequenceStepEvent", params);
                            }

                            @Override
                            public void onSequenceCanceled(TapTarget lastTarget) {
                                WritableMap params = Arguments.createMap();
                                params.putBoolean("cancel_step", true);

                                sendEvent(getReactApplicationContext(), "onCancelStepEvent", params);
                            }
                        })
                                .continueOnCancel(true);
                        tapTargetSequence.start();
                    }
                });
            }
        });
    }

    @ReactMethod
    public void ShowFor(final int view, final ReadableMap props, final Promise promise) {
        final Activity activity = getCurrentActivity();
        final Dialog dialog = new AlertDialog.Builder(activity).create();

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                UIManagerModule uiManager = getReactApplicationContext().getNativeModule(UIManagerModule.class);

                uiManager.addUIBlock(new UIBlock() {
                    @Override
                    public void execute(NativeViewHierarchyManager nativeViewHierarchyManager) {
                        View refView = nativeViewHierarchyManager.resolveView(view);
                        TapTarget targetView = generateTapTarget(refView, props);

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
        String outerCircleColor = null;
        String targetCircleColor = null;
        String titleTextColor = null;
        String descriptionTextColor = null;
        String textColor = null;
        String dimColor = null;

        if (props.hasKey("description") && !props.isNull("description")) {
            description = props.getString("description");
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
        if (props.hasKey("textColor") && !props.isNull("textColor")) {
            textColor = props.getString("textColor");
        }
        if (props.hasKey("dimColor") && !props.isNull("dimColor")) {
            dimColor = props.getString("dimColor");
        }


        //Other Props
        float outerCircleAlpha = 0.96f;
        int titleTextSize = 20;
        int descriptionTextSize = 10;
        boolean drawShadow = true;
        boolean cancelable = true;
        boolean tintTarget = true;
        boolean transparentTarget = true;
        int targetRadius = 60;

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


        //Populate Props
        TapTarget targetView = TapTarget.forView(view, title, description);

        if (outerCircleColor != null && outerCircleColor.length() > 0)
            targetView.outerCircleColorInt(Color.parseColor(outerCircleColor));
        if (targetCircleColor != null && targetCircleColor.length() > 0)
            targetView.targetCircleColorInt(Color.parseColor(targetCircleColor));
        if (titleTextColor != null && titleTextColor.length() > 0)
            targetView.titleTextColorInt(Color.parseColor(titleTextColor));
        if (descriptionTextColor != null && descriptionTextColor.length() > 0)
            targetView.descriptionTextColorInt(Color.parseColor(descriptionTextColor));
        if (textColor != null && textColor.length() > 0)
            targetView.textColorInt(Color.parseColor(textColor));
        if (dimColor != null && dimColor.length() > 0)
            targetView.dimColorInt(Color.parseColor(dimColor));


        targetView.outerCircleAlpha(outerCircleAlpha);
        targetView.titleTextSize(titleTextSize);
        targetView.descriptionTextSize(descriptionTextSize);
        targetView.drawShadow(drawShadow);
        targetView.cancelable(cancelable);
        targetView.tintTarget(tintTarget);
        targetView.transparentTarget(transparentTarget);
        targetView.targetRadius(targetRadius);

        return targetView;
    }
}
