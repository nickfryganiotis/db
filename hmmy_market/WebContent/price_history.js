function line(data,start_date,end_date,barcode){
	ldata = [];
	loptions= [];
	for(i=0; i<data.length; i++){
		ldata.push(data[i]);
		ldata.push(data[i]);
		loptions.push(start_date[i]);
		loptions.push(end_date[i]);
	}
	aux = [];
	for(i=0; i<ldata.length; i++){ 
		aux.push({y: ldata[i], label: loptions[i]});
	}
	var chart = new CanvasJS.Chart("chartContainer", {
		animationEnabled: true,
		exportEnabled: true,
		title:{
			text: "barcode: "+barcode
		},
		axisY:{ 
			title: "Prices",
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
