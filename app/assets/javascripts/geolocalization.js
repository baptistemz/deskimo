$("#geoloc").click(geoTag);
$("#geo-open-space").click(geoTag);
$("#geo-closed-office").click(geoTag);
$("#geo-meeting-room").click(geoTag);
$("#geo-itinerary").click(geoIt);

function geoTag() {
  var myPosition = new Array();

  $(document).ready(function() {
    navigator.geolocation.getCurrentPosition(
            onSuccess,
            onError, {
                enableHighAccuracy: true,
                timeout: 20000,
                maximumAge: 120000
    });
    function onSuccess(position) {
      myPosition[0] = position.coords.latitude;
      myPosition[1] = position.coords.longitude;
      document.cookie = "lat_lng=" + escape(myPosition);
      window.location = 'companies';
      }


    function onError(err) {
      var message;
      switch (err.code) {
        case 0:
          message = 'Unknown error: ' + err.message;
          break;
        case 1:
          message = 'You denied permission to retrieve a position.' + err.message;
          break;
        case 2:
          message = 'The browser was unable to determine a position: ' + err.message;
          break;
        case 3:
          message = 'The browser timed out before retrieving the position.';
          break;
      }
    }
  });
};

function geoIt() {
  // var myPosition = new Array();

  $(document).ready(function() {
    navigator.geolocation.getCurrentPosition(
            onSuccess,
            onError, {
                enableHighAccuracy: true,
                timeout: 20000,
                maximumAge: 120000
    });
    function onSuccess(position) {
      // myPosition[0] = position.coords.latitude;
      // myPosition[1] = position.coords.longitude;
      // document.cookie = "lat_lng=" + escape(myPosition);
      // window.location = 'companies';
      // "https://maps.google.com?saddr="+position.coords.latitude+position.coords.longitude+"&daddr=#{@company.address.gsub(/\s+/, "+")},#{@company.postcode},#{@company.city.gsub(/\s+/, "+")}"
      location.href = "https://www.google.com/maps/dir/"+position.coords.latitude+","+position.coords.longitude+"/"+$('#company_address').text()
      }


    function onError(err) {
      var message;
      switch (err.code) {
        case 0:
          message = 'Unknown error: ' + err.message;
          break;
        case 1:
          message = 'You denied permission to retrieve a position.' + err.message;
          break;
        case 2:
          message = 'The browser was unable to determine a position: ' + err.message;
          break;
        case 3:
          message = 'The browser timed out before retrieving the position.';
          break;
      }
    }
  });
};

