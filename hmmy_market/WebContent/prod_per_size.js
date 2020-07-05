function line(data,key){
	ldata = [];
	loptions= [];
	for(i=0; i<data.length; i++){
		ldata.push(data[i]);
		loptions.push(key[i]);
	}
	aux = [];
	for(i=0; i<ldata.length; i++){ 
		aux.push({y: ldata[i], label: loptions[i]});
	}
	var chart = new CanvasJS.Chart("chartContainer", {
		animationEnabled: true,
		exportEnabled: true,
		title:{
			text: "Products bought per store size"
		},
		axisY:{ 
			includeZero: false, 
			
		},
		data: [{
			type: "stepLine",
			markerSize: 5,
			dataPoints: aux
		}]
	});
	chart.render();

	}