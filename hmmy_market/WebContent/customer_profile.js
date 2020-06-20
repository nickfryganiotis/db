function check_customer(counter){
	c = counter.toString();
	var a = document.getElementById("customer_name"+c);	
	var nodes = a.childNodes;
	var text = '';
	for(var i = 0; i < nodes.length; i++) {                        
	    switch(nodes[i].nodeName) {
	        case '#text'    : text = text + nodes[i].nodeValue;   break;
	        case 'BR'       : text = text + '\n';      break;
	    }
	}
	var customer_name=text.split(" ");
	customer_name[2] = customer_name[2].replace(/(\r\n|\n|\r)/gm, "");
	window.location.replace("user.jsp?name="+customer_name[1]+" "+customer_name[2]);
}

