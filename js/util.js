var Color = 
{
	rgb: function(r, g, b)
	{
		return Qt.rgba(r / 255, g / 255, b / 255, 1);
	},
	rgba: function(r, g, b, a)
	{
		a = (a == undefined)? 1: a;
		return Qt.rgba(r / 255, g / 255, b / 255, a);
	}
}

var Message = 
{
	error: function(message, title)
	{
		msg.show(message, title);
	},
	susses: function(message, title)
	{
		msg.show(message, title);
	},
	alert: function(message, title)
	{
		msg.show(message, title);
	},
	espera: function(message, title)
	{
		msg.showEspera(message, title);
	},
	confirm: function(message, title)
	{
		msg_confirm.show(message, title);
	},	
	hide: function()
	{
		msg.hide();
	}
}
var Qml = 
{
	getName: function(father, name)
	{
		var response = [];
		for(var i = 0; i < father.children.length; i++) {
		    if(father.children[i].name == name)
		    	response.push(father.children[i]);
		}
		return response;
	},
	get: function(father, key, value)
	{
		var response = [];
		for(var i = 0; i < father.children.length; i++) {
		    if(father.children[i][key] == value)
		    	response.push(father.children[i]);
		}
		return response;
	}
}
var Font = 
{
	getSize: function(alto, divisor)
	{
		var rt = parseInt(alto / divisor);
        if(rt > 0)
            return rt;
        else
            return 16; 
	},
	getDefaultSize: function(divisor)
	{
		return 16; 
	}
}