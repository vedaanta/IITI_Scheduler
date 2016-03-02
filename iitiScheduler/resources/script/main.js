function createTable(tsid,sem){
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (xhttp.readyState == 4 && xhttp.status == 200) {
     			document.getElementById("status").innerHTML = xhttp.responseText;
    		}
  	};
  	xhttp.open("GET", "http://localhost:9999/iitiScheduler/createTable.jsp?batid="+tsid+"&sem="+sem, true);
  	xhttp.send();
}