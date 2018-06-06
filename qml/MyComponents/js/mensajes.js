function aviso(container, message, time)
{
	//console.log(container.children.length);
	var component = Qt.createComponent('../MensajeSimple.qml'), msg;
	if(component.status == Component.Ready)
	{
		msg = component.createObject(container);
		msg.height = container.height;
		msg.width = container.width;
		msg.time = time | 2000;
		msg.show(message, "");
	}
	return msg;
}
function error(container, message, time, espera)
{
	var component = Qt.createComponent('../MensajeError.qml'), msg;
	if(component.status == Component.Ready)
	{
		msg = component.createObject(container);
		msg.height = container.height;
		msg.width = container.width;
		msg.time = time || 0;
		msg.espera = espera || false;
		msg.show(message, "");
	}
	return msg;
}
function esperar(container, message)
{
	hide();
	var component = Qt.createComponent('../Espera.qml');
	if(component.status == Component.Ready)
	{
		root.message_espera = component.createObject(root);
		root.message_espera.height = root.height;
		root.message_espera.width = root.width;
		root.message_espera.showEspera(message, "");
	} else {
		console.log("no se pudo cargar el elemento");
	}
}
function confirmar(container, message, callback)
{
	var component = Qt.createComponent('../Confirm.qml'), msg;
	if(component.status == Component.Ready)
	{
		msg = component.createObject(container);
		msg.height = container.height;
		msg.width = container.width;
		msg.closed.connect(callback);
		msg.show(message, "");
	}
	return msg;
}
function prompt(container, message, callback)
{
	var component = Qt.createComponent('../Prompt.qml');
	if(component.status == Component.Ready)
	{
		var msg = component.createObject(container);
		msg.height = container.height;
		msg.width = container.width;
		msg.closed.connect(callback);
		var mensajes = message.split('#');
		if(message.length > 0)
			msg.show(mensajes[0], mensajes[1]);
		else
			msg.show(message, "");
	}
	return msg;
}
function prompt2(container, message, valor_pred, callback)
{
	var component = Qt.createComponent('../Prompt.qml');
	if(component.status == Component.Ready)
	{
		var msg = component.createObject(container);
		msg.height = container.height;
		msg.width = container.width;
		if(callback)
			msg.closed.connect(callback);
		var mensajes = message.split('#');
		if(message.length > 0)
			msg.show2(mensajes[0], mensajes[1], valor_pred);
		else
			msg.show2(message, "", valor_pred);
	}
	return msg;
}
function selFecha(container, callback)
{
	var component = Qt.createComponent('../Fecha.qml');
	if(component.status == Component.Ready)
	{
		var fecha = component.createObject(container);
		fecha.height = container.height;
		fecha.width = container.width;
		fecha.selFecha.connect(callback);
	}
}
function selHora(container, callback)
{
	var component = Qt.createComponent('../Hora.qml');
	if(component.status == Component.Ready)
	{
		var hora = component.createObject(container);
		hora.height = container.height;
		hora.width = container.width;
		hora.selHora.connect(callback);
	}
}
function hide()
{
	if(root.message_espera)
	{
		if(root.message_espera.destroy != undefined)
		{
			root.message_espera.destroy();
			root.message_espera = null;
		}
	}
}