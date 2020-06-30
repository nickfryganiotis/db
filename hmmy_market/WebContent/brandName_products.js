function pie_charts(brand_name_percentage,category_name,title){
	var aux = [];
	for(i=0; i<brand_name_percentage.length; i++){ 
		aux.push({y: brand_name_percentage[i], label: category_name[i]});
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