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
    	System.println( "Altitude diff: " +  altitudeDiff);
    	var paceAdjustment = (altitudeDiff / 30f) * 20;
    	if (info.currentSpeed <= 0f) {
    		return "-";
    	} else {
    		System.println("Current speed: " + info.currentSpeed);
    		System.println("Pace (second per kilomter): " + (1000f / info.currentSpeed));
	    	var adjustedPace = (1000f / info.currentSpeed) - paceAdjustment; 
	    	previousAltitude = currentAltitude;
	        System.println("Adjusted Pace: " + adjustedPace);
	        return adjustedPace;
		}
    }

}