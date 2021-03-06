using Toybox.WatchUi as Ui;

class GradeadjustedpaceView extends Ui.SimpleDataField {

	var previousAltitude = null;
	
    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();
        label = "GAP";
    }

	// 30 meters of climbing costs around 20 seconds extra
    function compute(info) {
    	if (previousAltitude == null) {
    		previousAltitude = info.altitude;
    	}
    	
    	var currentAltitude = info.altitude;
    	var altitudeDiff = currentAltitude - previousAltitude;
    	var paceAdjustment = (altitudeDiff / 30f) * 20;
    	if (info.currentSpeed <= 0f) {
    		return "-:--";
    	} else {
	    	var adjustedPaceSecondForKilometer = ((1000f / info.currentSpeed) - paceAdjustment).toLong(); 
	    	System.println(adjustedPaceSecondForKilometer);
	    	previousAltitude = currentAltitude;
	    	
	    	var paceMinutes = (adjustedPaceSecondForKilometer % 3600) / 60;
	    	var paceSeconds = (adjustedPaceSecondForKilometer % 3600) % 60;
	        return paceMinutes + ":" + paceSeconds;
		}
    }

}