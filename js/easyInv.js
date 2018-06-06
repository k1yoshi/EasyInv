
var LOG = {
	ins_pantalla: null,
	mostrar: function(msg){
		Mensaje.error(this.ins_pantalla, msg);
	}
}

//##### CONEXION CON EL SERVIDOR => ENVIO - RECEPCION DE DATOS
var EVENTOS_REQUES = function(callbackOk, callbackError){
	this.url = "";
	this.callbackOK = (callbackOk != undefined) ? callbackOk : null;
	this.callbackERROR = (callbackError != undefined) ? callbackError : null;
	this.recibiOk = function(datos){
		if(this.callbackOK != null)
			this.callbackOK(datos);
	}
	this.recibiError = function(status){
		if(this.callbackError != null)
			this.callbackError(status);
		else {
			Mensaje.hide();
            Mensaje.error(root, (status+" >> "+this.url), 0, true);
            console.log(status);
            console.log(this.url);
            Db.cerrarEn(5000);
		}
	}
}
var REQUEST = {
	tipo_envio: "POST",
	tipo_respuesta: "json",
	//url_servidor: "http://127.0.0.1/easyInv/peticiones.php",
	url_servidor: "https://easyinv.000webhostapp.com/php/peticiones.php",
	enviar: function(nom_fun, datos_json, callbackOK, callbackERROR){
		var parametros = "func="+nom_fun+"&"+ this.convertirJson(datos_json),
		url = this.url_servidor;
		var httpRequest = new XMLHttpRequest(); 
		httpRequest.responseType = this.tipo_respuesta;
        httpRequest.open(this.tipo_envio, url, true);
        httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        httpRequest.setRequestHeader("Content-length", parametros.length);
        httpRequest.setRequestHeader("Connection", "close");

        var eventos_escucha = new EVENTOS_REQUES(callbackOK, callbackERROR);
        eventos_escucha.url = url;
        //console.log(url);
        httpRequest.onreadystatechange = function(){
        	if (httpRequest.readyState == 4) {
	            if (httpRequest.status == 200) 
	                eventos_escucha.recibiOk(httpRequest.response);
	            else 
	            	eventos_escucha.recibiError(httpRequest.status);
	        }
        };
        httpRequest.send(parametros);
	},
	convertirJson: function(json){//recibe los parametros en formato json y los devuelve en formato URL(clave=valor&clave2...)
		var response = '';
		for(var id in json)
			response += id+'='+json[id]+'&';
		response = response.substring(0, response.length - 1);
		return response;
	}
}
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


/*
	## A TENER EN CUENTA

	@FOMATO JSON DE RESPUESTA EN REQUEST PARA CASOS DE LISTAS
	{
		@posicion: {
			@id_reg: 0,
			@params...
		}
	}
*/
function MODEL(lst_model){
	var id_en_uso = null;
	var index_en_uso = null;
	var display = "";
	var listModel = lst_model;
	var json_datos = {};
	var array_orden = [];

	this.getId = function(){return id_en_uso;};
	this.getIndex = function(){return index_en_uso;};
	this.getDisplay = function(){return display};

	this.setFId = function(id_reg){id_en_uso = id_reg;}
	this.setDisplay = function(texto){ display = texto;}
	this.setId = function(id_reg){
		if(json_datos[id_reg] == undefined)
			return false;
		id_en_uso = id_reg;
		for(var i = 0 ; i < array_orden.length; i ++){
			array_orden[i] == id_en_uso;
			index_en_uso = i;
			break;
		}
		return true;
	};
	this.setIndex = function(nIndex){
		if(array_orden[nIndex] == undefined)
			return false;
		index_en_uso = nIndex;
		id_en_uso = array_orden[index_en_uso];
		display = json_datos[id_en_uso].nombre;
		return true;
	}
	this.setIndexId = function(id){
		var nIndex = 0, contador = 0;
		for(var id_in in json_datos){
			if(id_in == id){
				nIndex = contador;
				break;
			}
			contador ++;
		}
		this.setIndex(nIndex);
	}
	this.setDatos = function (json_d){
		json_datos = {};
		array_orden = [];
		for(var id in json_d){
			array_orden.push(json_d[id].id_reg);
			json_datos[json_d[id].id_reg] = json_d[id];
			delete json_datos[json_d[id].id_reg].id_reg;
		}
	};
	this.addItems = function(json_regs){
		for(var id in json_regs){
			array_orden.push(id);
			json_datos[id] = json_regs[id];
		}
	}
	this.resetOrden = function(){
		if(typeof listModel != "object")
			return;
		array_orden = [];
		for(var i = 0; i < listModel.count; i ++){
			array_orden.push(listModel.get(i).id);
		}
	};
	this.resetModel = function(json_formato){
		if(typeof listModel != "object")
			return;
		listModel.clear();
		for(var i = 0; i < array_orden.length; i ++){
			var id_reg = array_orden[i],
				parm_add = {};
			if(json_formato == undefined){
				parm_add = json_datos[id_reg];
				
			} else {
				for(var id in json_formato){
					parm_add[id] = (json_datos[id_reg][id] == undefined) ? json_formato[id] : json_datos[id_reg][id];
				}
			}
			parm_add["id"] = id_reg;
			listModel.append(parm_add);
		}
	};
	this.resetModelFOrden = function(json_formato){
		array_orden = [];
		for(var id in json_datos){
			array_orden.push(id);
		}
		this.resetModel(json_formato);
	}
	this.getJson = function(){return json_datos;};
	this.getModel = function(){return listModel;};
}

function CUENTA(){
	this.id = 0;
	this.email = "";
	this.enviar = 0;
	this.servidor = "";
	this.tipo_envio = 0;
	var recordar_datos = false;
	var pw_usr = "";
	var THIS = this;
	this.callback = function(status, msg){
		console.log("callback que si se pudo llamar");
	};

	if(Db.getSetting("recordar_cuenta") == "Unknown")
		Db.setSetting("recordar_cuenta", "no");
	if(Db.getSetting("nombre_usuario") == "Unknown")
		Db.setSetting("nombre_usuario", "");
	if(Db.getSetting("pw_usuario") == "Unknown")
		Db.setSetting("pw_usuario", "");

	this.iniciar = function(recordar, email_ingreso, pw_ingreso, callbackR){
		if(callbackR != undefined)
			this.callback = callbackR;
		this.email = email_ingreso;
		pw_usr = pw_ingreso;
		recordar_datos = recordar;
		var datos = {
            "parm_email": this.email,
            "parm_pw": pw_usr
        }
		REQUEST.enviar("ingresar", datos, this.reciboDatos);
	};
	this.crear = function(email_ingreso, pw_ingreso, username, callbackR){
		if(callbackR != undefined)
			this.callback = callbackR;
		this.email = email_ingreso;
		pw_usr = pw_ingreso;
		recordar_datos = 0;
		var datos = {
            "parm_email": this.email,
            "parm_pw": pw_usr,
            "parm_username": username
        }
		REQUEST.enviar("nuevaCuenta", datos, this.reciboDatos);
	};
	this.guardarConfig = function(enviar, servidor, tipo_envio, callbackR){
		if(callbackR != undefined)
			this.callback = callbackR;
		var datos = {
            "parm_cuenta": this.id,
            "parm_enviar": enviar,
            "parm_servidor": servidor,
            "parm_tipo": tipo_envio
        }
		REQUEST.enviar("guardar_config", datos, function(data){
			if(data.status == 1){
				THIS.enviar = datos.parm_enviar;
				THIS.servidor = datos.parm_servidor;
				THIS.tipo_envio = datos.parm_tipo;
			}
			THIS.callback(data.status, data.msg);
		});
	};
	this.salir = function(callbackR){
		this.id = 0;
		this.nombre = "";
		this.email= "";
		this.model = null;
		callbackR(1, "ok");
	}
	this.reciboDatos = function(data){};
	this.preparar = function(chk, txt_usr, txt_pw){
		if(Db.getSetting("recordar_cuenta") == "si"){
			chk.checked = true;
			txt_usr.text = Db.getSetting("nombre_usuario");
			txt_pw.text = Db.getSetting("pw_usuario");
		} else {
			chk.checked = false;
			txt_usr.text = "";
			txt_pw.text = "";
			Db.setSetting("nombre_usuario", "");
			Db.setSetting("pw_usuario", "");
		}
	};
	this.guardarDatos = function(){
		if(recordar_datos){
			Db.setSetting("recordar_cuenta", "si");
			Db.setSetting("nombre_usuario", this.email);
			Db.setSetting("pw_usuario", pw_usr);
		} else {
			Db.setSetting("recordar_cuenta", "no");
			Db.setSetting("nombre_usuario", "");
			Db.setSetting("pw_usuario", "");
		}
	}
}

function SOPORTE(main_qml){
	var THIS = this;
	var callback_interno = function(status, msg){};
	this.main_qml = main_qml;

	this.callback = function(status, msg){};
	this.nuevo = function(id_cuenta, nota, callbackR){
		callback_interno = callbackR;
		
	};
}
function INVENTARIOS(lst_model, main_qml){
	MODEL.call(this, lst_model);
	var THIS = this;
	var callback_interno = function(status, msg){};
	this.main_qml = main_qml;
	this.callback = function(status, msg){};
	this.nuevo = function(id_cuenta, alias, descrip, fecha, hora, callbackR){
		callback_interno = callbackR;
		var dato_fecha = new Date();
		var mes = (dato_fecha.getMonth() +1) + "";
		if(mes.length == 1)
			mes = "0"+mes+"";
		var dia = dato_fecha.getDate()+"";
		if(dia.length == 1)
			dia = "0"+dia+"";
		var ampm = "am";
		var hora = dato_fecha.getHours() + "";
		if(hora.length == 1)
			hora = "0"+hora+"";
		var min = dato_fecha.getMinutes()+"";
		if(min.length == 1)
			min = "0"+min+"";

		var hora =  hora+":"+min+":00";
		var fecha =  dato_fecha.getFullYear() +"-"+mes+"-"+dia;
		var parametros = {
            "parm_cuenta": id_cuenta,
            "parm_alias": alias,
            "parm_descrip": descrip,
            "parm_fecha": fecha,
            "parm_hora": hora
        }
        REQUEST.enviar("nuevo_inv", parametros, function(data){
            if(data.status == 1){
        		THIS.setDatos(data.json_inv);
        		THIS.resetModel();
        	}
            callback_interno(data.status, data.msg);
        });
	};
	this.eliminar = function(id_cuenta, id_reg, callbackR){
		callback_interno = callbackR;
		var parametros = {
            "parm_cuenta": id_cuenta,
            "parm_inv": id_reg
        }
        REQUEST.enviar("eliminar_inv", parametros, function(data){
            if(data.status == 1){
        		THIS.setDatos(data.json_inv);
        		THIS.resetModel();
        	}
            callback_interno(data.status, data.msg);
        });
	};
	this.modificar = function(id_cuenta, id, nombre, fecha, hora, callbackR){
		callback_interno = callbackR;
		var parametros = {
            "parm_cuenta": id_cuenta,
            "parm_inv": id,
            "parm_nombre": nombre,
            "parm_fecha": fecha,
            "parm_hora": hora
        }
        REQUEST.enviar("modificar_inv", parametros, function(data){
        	if(data.status == 1){
        		THIS.getJson()[data.id_inv]["nombre"] = parametros.parm_nombre;
        		THIS.getJson()[data.id_inv]["fecha"] = parametros.parm_fecha;
        		THIS.getJson()[data.id_inv]["hora"] = parametros.parm_hora;
        		THIS.resetModel();
        	}
        	callback_interno(data.status, data.msg);
        })
	};
	this.cargarResumen = function(id_inv, callbackR){
	};
	this.finalizar = function(id_inv, callbackR){
		callback_interno = callbackR;
		var parametros = {
            "parm_inv": id_inv
        }
        REQUEST.enviar("finalizar_inv", parametros, function(data){
        	if(data.status == 1){
        		THIS.getJson()[parametros.parm_inv].estado = "FINALIZADO";
        		THIS.resetModel();
        	}
        	callback_interno(data.status, data.msg);
        })
	};
}
INVENTARIOS.prototype = Object.create(MODEL.prototype);
INVENTARIOS.prototype.constructor = INVENTARIOS;

function MODELO_N1(lst_model, main_qml){
	MODEL.call(this, lst_model);
	var THIS = this;
	var callback_interno = function(status, msg){};
	this.main_qml = main_qml;
	this.callback = function(status, msg){};
	this.modificarNombre = function(id, nuevoNombre, callbackR){
		
	};
	this.eliminar = function(id, callbackR){
		
	};
}
MODELO_N1.prototype = Object.create(MODEL.prototype);
MODELO_N1.prototype.constructor = MODELO_N1;

function GRUPOS(lst_model, main_qml){
	MODEL.call(this, lst_model);
	var THIS = this;
	var callback_interno = function(status, msg){};
	this.main_qml = main_qml;
	this.callback = function(status, msg){};
	this.nuevo = function(id_cuenta, id_inv, nombre, callbackR){
		callback_interno = callbackR;
		var parametros = {
            "parm_cuenta": id_cuenta,
            "parm_inv": id_inv,
            "parm_nombre": nombre
        }
        REQUEST.enviar("nuevo_grupo", parametros, function(data){
        	var rpt = data.msg;
        	if(data.status == 1){
        		var reg_grupo = {};
        		reg_grupo[data.id_reg] = {
        			"id_inv": data.id_inv,
					"nombre": data.nombre,
					"text": data.nombre,
					"cant_items": "0",
					"es_principal": "0"
        		}
        		THIS.addItems(reg_grupo);
        		THIS.resetModel();
        		rpt = data.id_reg;
        	}
        	callback_interno(data.status, rpt);
        })
	};
	this.modificarNombre = function(nIndex, nuevoNombre, callbackR){
		callback_interno = callbackR;
		var id_reg = this.getModel().get(nIndex).id;
		var parametros = {
            "parm_bar": id_reg,
            "parm_nombre": nuevoNombre
        }
        REQUEST.enviar("upd_bar", parametros, function(data){
        	if(data.status == 1){
        		THIS.setDatos(data.json_bares);
        		THIS.resetModel();
        	}
        	callback_interno(data.status, data.msg);
        })
	};
	this.setPrincipal = function(){
		var datos = THIS.getJson(),
			nIndex = 0;
		for(var id in datos){
			if(datos[id].es_principal == 1);
				break;
			nIndex ++;
		}
		THIS.setIndex(nIndex);
	};
	this.getDetalles = function(id_grupo){};
}
GRUPOS.prototype = Object.create(MODEL.prototype);
GRUPOS.prototype.constructor = GRUPOS;

function ITEMS(lst_model, main_qml){
	MODEL.call(this, lst_model);
	var THIS = this;
	var callback_interno = function(status, msg){};
	this.main_qml = main_qml;
	this.callback = function(status, msg){};
	this.nuevoDet = function (id_item,id_ref,id_grupo,nombre,cant,orden, callbackR){
	};
	this.modCant = function(id_item, id_det, cant, callbackR){};
}
ITEMS.prototype = Object.create(MODEL.prototype);
ITEMS.prototype.constructor = ITEMS;


function EasyInv(inst_qml){
	var EASYINV = this;

	LOG.ins_pantalla = inst_qml;
	this.root = inst_qml;
	this.id_und = 0;
	//this.UNIDADES = new UNIDADES();
	this.CUENTA = new CUENTA();
	this.SOPORTE = new SOPORTE(inst_qml);
	this.INVENTARIOS = new INVENTARIOS(model_inv, inst_qml);
	this.MODELO_N1 = new MODELO_N1(model_vistaN1, inst_qml);
	this.GRUPOS = new GRUPOS(model_grupos, inst_qml);
	this.ITEMS = new ITEMS(model_det, inst_qml);

	this.REQUEST = REQUEST;
	this.LOG = LOG;
	this.items_registrados = {};

	
	this.inventariar = function(callbackR){
		var parametros = {
            "parm_idcuenta": DRINKVENTARIO.CUENTA.id,
            "parm_idsuc": DRINKVENTARIO.SUCURSAL.getId()
        };
		REQUEST.enviar("nuevo_inv", parametros, function(data){
			callbackR(data.status, data.msg);
		});
	};
	this.modificarNombreItem = function(id_item, nombre, callbackR){
		var parametros = {
            "parm_id_item": id_item,
            "parm_nombre": nombre
        };
		REQUEST.enviar("modificar_nomItem", parametros, function(data){
			if(data.status == 1){
				EASYINV.items_registrados[id_item].nombre = nombre;
				for(var id in EASYINV.MODELO_N1.getJson()){
					if(EASYINV.MODELO_N1.getJson()[id].id_item == id_item)
						EASYINV.MODELO_N1.getJson()[id].nombre = nombre;
				}
				for(var id in EASYINV.ITEMS.getJson()){
					if(EASYINV.ITEMS.getJson()[id].id_item == id_item)
						EASYINV.ITEMS.getJson()[id].nombre = nombre;
				}
				EASYINV.MODELO_N1.resetModel();
				EASYINV.ITEMS.resetModel();
			}
			callbackR(data.status, data.msg);
		});
	}

	//@SOBREESCRIBIR RUTINAS CUENTA
	this.CUENTA.reciboDatos = function(data){
		if(data.status == 1){
			EASYINV.CUENTA.id = data.id_cuenta;
			EASYINV.CUENTA.guardarDatos();
			EASYINV.INVENTARIOS.setDatos(data.json_inv);
			EASYINV.INVENTARIOS.resetModel();
			EASYINV.items_registrados = data.json_items_regs;
			EASYINV.CUENTA.enviar = data.enviar_json;
			EASYINV.CUENTA.servidor = data.url_serv;
			EASYINV.CUENTA.tipo_envio = data.tipo_envio;
		}
		EASYINV.CUENTA.callback(data.status, data.msg);
	}
	//@SOBREESCRIBIR RUTINAS INVENTARIOS
	this.INVENTARIOS.cargarResumen = function(callbackR){
		EASYINV.INVENTARIOS.callback = callbackR;
		var parametros = {
            "parm_inv": EASYINV.INVENTARIOS.getId()
        }
        REQUEST.enviar("get_resumen", parametros, function(data){
            if(data.status == 1){
                EASYINV.MODELO_N1.setDatos(data.json_resumen);
                EASYINV.MODELO_N1.resetModel();
                EASYINV.GRUPOS.setDatos(data.json_grupos);
                EASYINV.GRUPOS.resetModel();
                EASYINV.ITEMS.setDatos(data.json_detalle);
                EASYINV.ITEMS.resetModel();
            }
            EASYINV.INVENTARIOS.callback(data.status, data.msg);
        }); 
	}
	//@SOBREESCRIBIR RUTINAS MODELO_N1
	this.MODELO_N1.eliminar = function(id_resumen, callbackR){
		EASYINV.MODELO_N1.callback = callbackR;
		var parametros = {
            "parm_inv": EASYINV.INVENTARIOS.getId(),
            "parm_resumen": id_resumen,
            "parm_item": EASYINV.MODELO_N1.getJson()[id_resumen].id_item
        }
        REQUEST.enviar("eliminar_resumen", parametros, function(data){
            if(data.status == 1){
                for(var id in EASYINV.MODELO_N1.getJson()){
					if(EASYINV.MODELO_N1.getJson()[id].id_item == parametros.parm_item)
						delete EASYINV.MODELO_N1.getJson()[id];
				}
				for(var id in EASYINV.ITEMS.getJson()){
					if(EASYINV.ITEMS.getJson()[id].id_item == parametros.parm_item)
						delete EASYINV.ITEMS.getJson()[id];
				}
				EASYINV.MODELO_N1.resetModelFOrden();
				EASYINV.ITEMS.resetModelFOrden()
            }
            EASYINV.MODELO_N1.callback(data.status, data.msg);
        });
	};
	//@SOBREESCRIBIR RUTINAS GRUPOS
	this.GRUPOS.getDetalles = function(id_grupo){
		var json_det_grupo = {}, 
			json_det = EASYINV.ITEMS.getJson();
		for(var id in json_det){
			if(json_det[id].id_grupo == id_grupo)
				json_det_grupo[id] = json_det[id];
		}
		return JSON.parse(JSON.stringify(json_det_grupo));
	}
	this.GRUPOS.modificarNombre = function(id_grupo, nombre, callbackR){
		EASYINV.GRUPOS.callback = callbackR;
		var parametros = {
			"parm_id_grupo": id_grupo,
            "parm_nombre": nombre
        }
        REQUEST.enviar("modificar_nomGrupo", parametros, function(data){
            if(data.status == 1){
                EASYINV.GRUPOS.getJson()[id_grupo].nombre = nombre;
                EASYINV.GRUPOS.resetModel();
            }
            EASYINV.GRUPOS.callback(data.status, data.msg);
        });
	}
	this.GRUPOS.eliminar = function(id_grupo, callbackR){
		EASYINV.GRUPOS.callback = callbackR;
		var parametros = {
            "parm_inv": EASYINV.INVENTARIOS.getId(),
            "parm_grupo": id_grupo
        }
        REQUEST.enviar("eliminar_grupo", parametros, function(data){
            if(data.status == 1){
                for(var id in EASYINV.GRUPOS.getJson()){
					if(id == id_grupo)
						delete EASYINV.GRUPOS.getJson()[id];
				}
				EASYINV.GRUPOS.resetModelFOrden();
            }
            EASYINV.GRUPOS.callback(data.status, data.msg);
        });
	};
	//@SOBREESCRIBIR RUTINAS ITEMS
	this.ITEMS.nuevoDet = function(id_item,id_ref,id_grupo,nombre,cant,orden, callbackR){
		EASYINV.ITEMS.callback = callbackR;
		var parametros = {
			"parm_cuenta": EASYINV.CUENTA.id,
            "parm_inv": EASYINV.INVENTARIOS.getId(),
            "parm_item": id_item,
            "parm_ref": id_ref,
            "parm_grupo": id_grupo,
            "parm_nombre": nombre,
            "parm_cant": cant,
            "parm_orden": orden
        }
        REQUEST.enviar("nuevo_detInv", parametros, function(data){
            if(data.status == 1){
            	EASYINV.items_registrados[parametros.parm_item] = {
            		"id_ref": parametros.parm_ref,
            		"nombre": parametros.parm_nombre
            	}
                EASYINV.MODELO_N1.setDatos(data.json_resumen);
                EASYINV.MODELO_N1.resetModel();
                EASYINV.GRUPOS.setDatos(data.json_grupos);
                EASYINV.GRUPOS.resetModel();
                EASYINV.ITEMS.setDatos(data.json_detalle);
                EASYINV.ITEMS.resetModel();
            }
            EASYINV.ITEMS.callback(data.status, data.msg);
        });
	};
	this.ITEMS.modCant = function(id_en_json, id_item, id_det, cant, callbackR){
		EASYINV.ITEMS.callback = callbackR;
		var parametros = {
            "parm_inv": EASYINV.INVENTARIOS.getId(),
            "parm_item": id_item,
            "parm_det": id_det,
            "parm_cant": cant
        }
        REQUEST.enviar("mod_cantDet", parametros, function(data){
            if(data.status == 1){
                for(var id in EASYINV.MODELO_N1.getJson()){
                	if(EASYINV.MODELO_N1.getJson()[id].id_item == data.id_item){
                		EASYINV.MODELO_N1.getJson()[id].cant = EASYINV.round(data.cant_resumen, 3);
                		break;
                	}
                }
                EASYINV.MODELO_N1.resetModel();
                EASYINV.ITEMS.getJson()[id_en_json].cant = (EASYINV.round(data.cant_det, 3))+"";
                EASYINV.ITEMS.getJson()[id_en_json].cant_memoria = "1";
                EASYINV.ITEMS.resetModel();
            }
            EASYINV.ITEMS.callback(data.status, data.msg);
        });
	};
	this.ITEMS.eliminar = function(id_item, callbackR){
		EASYINV.ITEMS.callback = callbackR;
		var parametros = {
            "parm_id_det": id_item,
            "parm_inv": EASYINV.INVENTARIOS.getId()
        }
        REQUEST.enviar("eliminar_detalle", parametros, function(data){
            if(data.status == 1){
                for(var id in EASYINV.ITEMS.getJson()){
					if(id == id_item)
						delete EASYINV.ITEMS.getJson()[id];
				}
				EASYINV.MODELO_N1.setDatos(data.json_resumen);
				EASYINV.GRUPOS.setDatos(data.json_grupos)
				EASYINV.ITEMS.resetModelFOrden();
				EASYINV.MODELO_N1.resetModel();
				EASYINV.GRUPOS.resetModel();
            }
            EASYINV.ITEMS.callback(data.status, data.msg);
        });
	};
}
EasyInv.prototype.mostrarAyuda = function(ruta_img){
	ruta_img = "../"+ruta_img;
	var component = Qt.createComponent('../qml/Ayuda.qml'), ayuda;
    if(component.status == Component.Ready)
    {
        ayuda = component.createObject(this.root);
        ayuda.height = this.root.height;
        ayuda.width = this.root.width;
        ayuda.source = ruta_img;
    }
}
EasyInv.prototype.round = function(num, decimales){
	var signo = (num >= 0 ? 1 : -1);
    num = num * signo;
    if (decimales === 0) //con 0 decimales
        return signo * Math.round(num);
    // round(x * 10 ^ decimales)
    num = num.toString().split('e');
    num = Math.round(+(num[0] + 'e' + (num[1] ? (+num[1] + decimales) : decimales)));
    // x * 10 ^ (-decimales)
    num = num.toString().split('e');
    return signo * (num[0] + 'e' + (num[1] ? (+num[1] - decimales) : -decimales));
}