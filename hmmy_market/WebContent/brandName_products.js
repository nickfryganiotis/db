function diagrams(brand_name_percentage,category_name){
	var lcolour=[];
    var ldata=[];
    var lprod = [];
    for(var i=0; i<brand_name_percentage.length; i++){
        lcolour.push('rgba(255, 99, 132, 0.6)') ;
        ldata.push(brand_name_percentage[i]);
        lprod.push(category_name[i]);
    }
    let myChart=document.getElementById('myChart').getContext('2d');
    let massPopChart = new Chart(myChart, {
        type:'bar',
        data:{
            labels:lprod,
        datasets:[
            {
                label: "Percentages %",
                data:ldata,
                backgroundColor:lcolour
            }
 
          ],
            
    }
    })
}