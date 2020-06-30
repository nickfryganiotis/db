function diagrams(keys,values){
	var lcolour=[];
    var ldata=[];
    var lprod = [];
    for(var i=0; i<values.length; i++){
        lcolour.push('rgba(255, 99, 132, 0.6)') ;
        if(values[i]!=0){
        	ldata.push(values[i]);
        	lprod.push(keys[i]);
        }
        
    }
    let myChart=document.getElementById('myChart').getContext('2d');
    let massPopChart = new Chart(myChart, {
        type:'bar',
        data:{
            labels:lprod,
        datasets:[
            {
                label: "Money Spent",
                data:ldata,
                backgroundColor:lcolour
            }
 
          ],
            
    }
    })
}