using Toybox.WatchUi as Ui;

class GradeadjustedpaceView extends Ui.SimpleDataField {

	var slopeMultiplierForAdjustment = -0.04f;
	
	var slopeCorrection =  0.98f;
	
	var previousAltitude = null;
	
	var previousDistance = 0;
	
    function initialize() {
        SimpleDataField.initialize();
        label = "GAP";
    }

	// formula: 30 meters of climbing costs distracts 20 second from the pace
    function compute(info) {
    	if (info.currentSpeed <= 0f || info.elapsedDistance == null || info.altitude == null) {
    		return "-:--";
    	}
    	
    	if (previousAltitude == null) {
    		previousAltitude = info.altitude;
    	}

    	var altitudeDiff = info.altitude - previousAltitude;
    	var distanceDiff = info.elapsedDistance - previousDistance;
    	System.println("Distance diff: " + distanceDiff);
    	System.println("Altitude diff: " + altitudeDiff);
    	var slope = ((distanceDiff / 100) * altitudeDiff);
    	System.println("Slope: " + slope);
    	var paceInSeconds =  1000f / info.currentSpeed;
    	System.println("Pace in seconds: " + paceInSeconds);
    	var paceAdjustedInSeconds = (paceInSeconds * (slopeMultiplierForAdjustment * slope + slopeCorrection)).toLong();
    	System.println("Adjusted pace in seconds: " + paceAdjustedInSeconds);

    	//var adjustedPaceSecondForKilometer = ((1000f / info.currentSpeed) - paceAdjustment).toLong(); 
    	previousAltitude = info.altitude;
    	previousDistance = info.elapsedDistance;
    	var paceMinutes = (paceAdjustedInSeconds % 3600) / 60;
    	var paceSeconds = (paceAdjustedInSeconds % 3600) % 60;
        return paceMinutes + ":" + paceSeconds;
		
    }

}