function pie_charts(data,key,title){
	var aux = [];
	for(i=0; i<data.length; i++){ 
		aux.push({y: data[i], label: key[i]});
	}
	var chart = new CanvasJS.Chart("chartContainer", {
		animationEnabled: true,
		title: {
			text: title
		},
		data: [{
			type: "pie",
			startAngle: 240,
			yValueFormatString: "##0.00\"%\"",
			indexLabel: "{label} {y}",
			dataPoints: aux
		}]
	});
	chart.render();

	}