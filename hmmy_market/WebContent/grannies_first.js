function charts(keys,values1,values2,values3,values4,iter){ 
	var lcolour1=[];
	var lcolour2=[];
	var lcolour3=[];
	var lcolour4=[];
	var ldata1=[];
	var ldata2=[];
	var ldata3=[];
	var ldata4=[];
	var lprod = [];
	for(var i=0; i<values1.length; i++){
		lcolour1.push('rgba(255, 99, 132, 0.6)') ;
		ldata1.push(values1[i]);
		lcolour2.push('rgba(54, 162, 235, 0.6)');
		ldata2.push(values2[i]);
		lcolour3.push('rgba(0,255,0,0.3)');
		ldata3.push(values3[i]);
		lcolour4.push('rgba(255,255,0,0.3)');
		ldata4.push(values4[i]);
		lprod.push(keys[i]);
    }
	let myChart=document.getElementById('myChart'+iter).getContext('2d');
	let massPopChart = new Chart(myChart, {
		type:'bar',
		data:{
			labels:lprod,
			datasets:[
				{
					label: "Children",
					data:ldata1,
					backgroundColor:lcolour1
        },{
        	label: "Young",
			data:ldata2,
			backgroundColor:lcolour2
        },
        {
        	label: "Middle age",
			data:ldata3,
			backgroundColor:lcolour3
        },
        {
        	label: "Old adults",
			data:ldata4,
			backgroundColor:lcolour4
        }

      ],
        
}
})
}