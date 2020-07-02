function check_store(t,cit){
	t = t.toString();
	var cit=cit.toString();
	var a = document.getElementById("store"+t);
	var b = document.getElementById("city"+cit);
	var nodes = a.childNodes;
	var text = '';
	for(var i = 0; i < nodes.length; i++) {                        
	    switch(nodes[i].nodeName) {
	        case '#text'    : text = text + nodes[i].nodeValue;   break;
	        case 'BR'       : text = text + '\n';      break;
	    }	    
	}
	var store = text;
	var nodes = b.childNodes;
	var text = '';
	for(var i = 0; i < nodes.length; i++) {                        
	    switch(nodes[i].nodeName) {
	        case '#text'    : text = text + nodes[i].nodeValue;   break;
	        case 'BR'       : text = text + '\n';      break;
	    }	    
	}
	store = text+" "+store;
	window.location.replace("find_transaction.jsp?store="+store);
}