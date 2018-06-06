import QtQuick 2.2
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

import "../MyComponents"
import "../"
import "../MyComponents/js/mensajes.js" as Mensaje
import "../../js/db.js" as Db
import "../../js/util.js" as Util
import "../delegates"
import "../headers"
import "../footers"

Item 
{
	id: qml_vista;
	height: 600;
    width: 400;

    property bool modo_seleccion: false;

    signal iniciar;
    signal fin;
    signal mostrarMenuVistas;
    signal cancelar;

    ListModel{
        id: model_n1;
        /*ListElement{
            Id: 5; nombre: "Grupo 1"; cant: 9; id_grupo: 0;
        }*/
    }
    HeaderInv {
        id: header;
        anchors.left: parent.left;
        width: parent.width;
        height: root.alto_header;
        onBack: modo_seleccion ? cancelar() : qml_maestro.back(null);
        onNuevo: nuevoItem();
    }
  	Item{
  		id: body;
  		anchors.top: header.bottom;
  		height: parent.height - header.height - footer.height;
  		width: parent.width;
  		Item{
  			id: row_1;
  			anchors.top: parent.top;
  			height: parent.height * .12;
  			width: parent.width;
  			Rectangle{
				anchors.verticalCenter: parent.verticalCenter;
				anchors.left: parent.left;
				anchors.leftMargin: parent.width * .03;
				height: parent.height * .63;
				width: parent.width * .42;
				radius: height * .12;
				color: Qt.rgba(0,0,0,0);
				border.color: root.color_base_n9;
				border.width: 1;
				Text{
					anchors.fill: parent;
					verticalAlignment: Text.AlignVCenter;
					horizontalAlignment: Text.AlignHCenter;
					text: "Nuevo Grupo";
					font.pixelSize: 18;
					color: root.color_base_n8;
					font.bold: true;
				}
				MouseArea{
					anchors.fill: parent;
					onClicked: nuevoGrupo();
				}
			}
			Image{
				anchors.right: parent.right;
				anchors.rightMargin: parent.width * .03;
				anchors.verticalCenter: parent.verticalCenter;
				height: parent.height * .63;
				width: height;
				source: "../../src/img/menu_grid2.png";
				visible: !modo_seleccion;
				MouseArea{
					anchors.fill: parent;
					onClicked: {
						if(!modo_seleccion)
							mostrarMenuVistas();
					}
				}
			}
  		}
  		Item{
  			id: row_2;
  			anchors.bottom: parent.bottom;
  			height: parent.height - row_1.height;
  			width: parent.width;
  			ListaOrdenada {
                id: lst_v1;
                anchors.top: parent.top;
                anchors.left: parent.left;
                width: parent.width;
                height: parent.height * .9;
                model: model_n1;
                spacing: 1;
                item_delegate: ItemOrden{
                    id: item_d;
                    width: lst_v1.width;
                    height: lst_v1.height * .096;
                    color: "#FFF";
                    lst: lst_v1.lst;
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                            if(id_grupo != 0){
                                selItem(index);
                            }
                        }
                    }
                    
                    Rectangle{
                        id: rec_cant;
                        anchors.verticalCenter: parent.verticalCenter;
                        anchors.left: parent.left;
                        anchors.leftMargin: parent.width * .015;
                        
                        height: id_grupo == 0 ? (parent.height * .36) : parent.height * .72;
                        width: id_grupo == 0 ? height : (parent.width * .18);
                        radius: (id_grupo == 0) ? (height * .5) : (height * .18);
                        border.width: id_grupo == 0 ? 0 : 1;
                        border.color: root.color_base_n1;
                        color: id_grupo == 0 ? root.color_base_n7 : Qt.rgba(0,0,0,0);
                        Text{
                            anchors.fill: parent;
                            verticalAlignment: Text.AlignVCenter;
                            horizontalAlignment: Text.AlignHCenter;
                            text: id_grupo == 0 ? "" : cant;
                            font.pixelSize: 18;
                            font.bold: true;
                            color: root.color_base_n3;
                        }
                    }
                    Text{
                        anchors.left: rec_cant.right;
                        height: parent.height;
                        width: parent.width * .6;
                        text: " "+nombre;
                        verticalAlignment: Text.AlignVCenter;
                        font.pixelSize: 24;
                        color: id_grupo ==0 ? root.color_base_n7 : root.color_base_n8;
                    }
                    BtnMenu{
                        anchors.right: parent.right;
                        anchors.rightMargin: parent.width * .03;
                        anchors.verticalCenter: parent.verticalCenter;
                        height: parent.height * .72;
                        width: height;
                        visible: id_grupo != 0;
                        MouseArea{
                            anchors.fill: parent;
                            onClicked: mostrarMenuItem(index);
                        }
                    }
                }
            }
  		}
  	}
    Item {
        id: footer;
        anchors.bottom: parent.bottom;
        width: parent.width;
        height: modo_seleccion ? 0 : parent.height * .12;
        visible: !modo_seleccion;
     	Rectangle{height: 1; width: parent.width; color: root.color_base_n10;}
        Rectangle{
            id: btn_finalizar;
			anchors.verticalCenter: parent.verticalCenter;
			anchors.right: parent.right;
			anchors.rightMargin: parent.width * .03;
			height: parent.height * .72;
			width: parent.width * .42;
			radius: height * .12;
			color: Qt.rgba(0,0,0,0);
			border.color: root.color_base_n1;
			border.width: 1;
			Text{
				anchors.fill: parent;
				verticalAlignment: Text.AlignVCenter;
				horizontalAlignment: Text.AlignHCenter;
				text: "Finalizar";
				font.pixelSize: 24;
				color: root.color_base_n2;
				font.bold: true;
			}
			MouseArea{
				anchors.fill: parent;
				onClicked: finalizar();
			}
		}
    }
    Rectangle{
        id: rec_menu_item;
        anchors.fill: parent;
        visible: false;
        color: Qt.rgba(0,0,0,.5);

        MouseArea{
            anchors.fill: parent;
            onClicked: rec_menu_item.visible = false;
        }

        Rectangle{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.horizontalCenter: parent.horizontalCenter;
            height: parent.height * .42;
            width: parent.width * .72;
            radius: height * .06;
            Column{
                anchors.verticalCenter: parent.verticalCenter;
                anchors.horizontalCenter: parent.horizontalCenter;
                width: parent.width;
                spacing: 9;
                Rectangle{
                    anchors.horizontalCenter: parent.horizontalCenter;
                    height: qml_vista.height * .093;
                    width: parent.width * .93;
                    radius: height * .12;
                    color: Qt.rgba(0,0,0,0);
                    border.color: root.color_base_n3;
                    border.width: 1;
                    Text{
                        anchors.fill: parent;
                        verticalAlignment: Text.AlignVCenter;
                        horizontalAlignment: Text.AlignHCenter;
                        text: "Modificar nombre de Item";
                        font.pixelSize: 18;
                        color: root.color_base_n3;
                        font.bold: true;
                    }
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: modificarRegistro();
                    }
                }
                Rectangle{
                    anchors.horizontalCenter: parent.horizontalCenter;
                    height: qml_vista.height * .093;
                    width: parent.width * .93;
                    radius: height * .12;
                    color: Qt.rgba(0,0,0,0);
                    border.color: root.color_base_n3;
                    border.width: 1;
                    Text{
                        anchors.fill: parent;
                        verticalAlignment: Text.AlignVCenter;
                        horizontalAlignment: Text.AlignHCenter;
                        text: "Eliminar Item";
                        font.pixelSize: 18;
                        color: root.color_base_n3;
                        font.bold: true;
                    }
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: eliminarRegistro();
                    }
                }
            }
            Item{
                anchors.top: parent.top;
                height: qml_vista.height * .09;
                width: parent.width;
                Text{
                    id: txt_nom_item;
                    anchors.right: parent.right;
                    verticalAlignment: Text.AlignVCenter;
                    height: parent.height;
                    text: "";
                    font.pixelSize: 21;
                    color: root.color_base_n8;
                }
            }
        }
    }
    Item{
        id: barrera;
        anchors.fill: parent;
        visible: false;
        MouseArea{
            anchors.fill: {

            }
        }
    }

    onIniciar: {
    	if(app_manager.INVENTARIOS.getId()){
    		var reg = app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()];
        	header.titulo = reg.fecha+" "+reg.nombre;
    	}
        cargaInicial();
    }
    onFin: {
        qml_vista.destroy();
    }
    function finalizar(){
        Mensaje.esperar(root, "")
        app_manager.INVENTARIOS.finalizar(app_manager.INVENTARIOS.getId(), function(status, msg){
            Mensaje.hide();
            if(status != 1)
                Mensaje.error(root, msg);
            else{
                if(app_manager.CUENTA.enviar == 1)
                    root.enviarJson();
                contenedor_qml.setSource("../Maestro.qml");
            }
        });
    }
    function cargaInicial(){
        btn_finalizar.visible = (app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()].estado == "NUEVO");
        var id_item = 0;
        var json_grupo_items = {},
            json_grupos = app_manager.GRUPOS.getJson(),
            json_items = app_manager.ITEMS.getJson();
        

        for(var id in json_items){
            var id_grupo = json_items[id].id_grupo;
            if(json_grupo_items[id_grupo] == undefined){
                json_grupo_items[id_grupo] = {
                    es_principal: json_grupos[id_grupo].es_principal,
                    nombre: json_grupos[id_grupo].nombre,
                    items: {}
                }
            }
            json_grupo_items[id_grupo].items[id] = {
                cant: json_items[id].cant,
                nombre: json_items[id].nombre,
                id_item: json_items[id].id_item
            }
        }
        for(var id in json_grupos){
            if(json_grupo_items[id] == undefined){
                json_grupo_items[id] = {
                    es_principal: json_grupos[id].es_principal,
                    nombre: json_grupos[id].nombre,
                    items: {}
                }
            }
        }
        model_n1.clear();
        for(var id in json_grupo_items){
            model_n1.append({
                "id": ("GR-"+id),
                "nombre": json_grupo_items[id].nombre,
                "cant": 0,
                "id_grupo": "0",
                "id_item": "0",
                "es_principal": json_grupo_items[id].es_principal
            });
            var json_det_items = json_grupo_items[id].items;
            for(var id_det in json_det_items){
                model_n1.append({
                    "id": id_det,
                    "nombre": json_det_items[id_det].nombre,
                    "cant": (json_det_items[id_det].cant * 1.000),
                    "id_grupo": id,
                    "id_item": json_det_items.id_item,
                    "es_principal": json_grupo_items[id].es_principal
                });
            }
        }
    }
    Component.onCompleted: iniciar();
    onMostrarMenuVistas: {
        var component = Qt.createComponent('MenuVistas.qml'), menu_vistas;
        if(component.status == Component.Ready)
        {
            menu_vistas = component.createObject(qml_vista);
            menu_vistas.height = qml_vista.height;
            menu_vistas.width = qml_vista.width;
            menu_vistas.selVista.connect(qml_vista.selVista)
        }
    }
    function mostrarMenuItem(nIndex){
        if(app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()].estado != "NUEVO")
            return;
        app_manager.ITEMS.setIndexId(model_n1.get(nIndex).id_item);
        txt_nom_item.text = app_manager.ITEMS.getDisplay()+"   ";
        rec_menu_item.visible = true;
    }
    function eliminarRegistro(){
        var nombre_reg = app_manager.ITEMS.getDisplay();
        rec_menu_item.visible = false;
        Mensaje.confirmar(root, "Confirma eliminar " + nombre_reg, function(status, value){
            if(!status){
                //qml_menuItem.eliminar(0, "Se cancelo la operacion");
            } else {
                Mensaje.esperar(root, "");
                app_manager.ITEMS.eliminar(app_manager.ITEMS.getId(), function(status, msg){
                    Mensaje.hide();
                    if(status == 1)
                        qml_vista.cargaInicial();
                });
            }
        });
    }
    function modificarRegistro(){
        var nombre_reg = app_manager.ITEMS.getDisplay();
        rec_menu_item.visible = false;
        Mensaje.prompt2(root, "Modificar nombre de Item ", nombre_reg, function(status, value){
            if(!status){
                //qml_menuItem.modificar(0, "Se cancelo la operacion")
            } else {
                Mensaje.esperar(root, "");
                app_manager.modificarNombreItem(app_manager.ITEMS.getJson()[app_manager.ITEMS.getId()].id_item , value, function(status, msg){
                    Mensaje.hide();
                    if(status != 1)
                        Mensaje.error(root, msg);
                    else
                        qml_vista.cargaInicial();
                });
            }
        });
    }

    function nuevoItem(){
        if(app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()].estado != "NUEVO")
            return;
        barrera.visible = true;
        app_manager.GRUPOS.setPrincipal();
        var component = Qt.createComponent('../Items/NuevoItem.qml');
        if(component.status == Component.Ready)
        {
            var qml_item_nuevo = component.createObject(root);
            qml_item_nuevo.id_grupo = app_manager.GRUPOS.getId();
            qml_item_nuevo.height = root.height;
            qml_item_nuevo.width = root.width;
            qml_item_nuevo.visible = true;
            qml_item_nuevo.z = 96;
            qml_item_nuevo.aparecer();
            qml_item_nuevo.desaparecer.connect(qml_vista.cargaInicial);
        }
        barrera.visible = false;
    }
    function nuevoGrupo(){
        if(app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()].estado != "NUEVO")
            return;
        Mensaje.prompt(root, "Ingrese nombre del Grupo", function(status, value){
            if(status){
                Mensaje.esperar(root, "");
                app_manager.GRUPOS.nuevo(app_manager.CUENTA.id, app_manager.INVENTARIOS.getId(), value, function(status, msg){
                    Mensaje.hide();
                    if(status != 1){
                        Mensaje.error(root, msg);
                    } else {
                        qml_vista.cargaInicial();
                    }
                });
            }
        });
    }

    function selItem(nIndex){
        if(app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()].estado != "NUEVO")
            return;
        var reg = model_n1.get(nIndex);
        barrera.visible = true;
        app_manager.GRUPOS.setIndexId(reg.id_grupo);
        app_manager.ITEMS.setIndexId(reg.id);
        qml_maestro.pages.push("inventarios/DetInventario.qml");
        qml_maestro.next(function(){});
    }
    function selVista(vista){
        var nom_component, menu_vistas;
        if(vista == 1){
            nom_component = "VistaN1.qml";
        } else if(vista == 2){
            return;
            //nom_component = "VistaN2.qml";
        } else if(vista == 3){
            nom_component = "VistaN3.qml";
        }
        qml_maestro.pages[1] = "vistas/"+nom_component;
        qml_maestro.setIndex(1, null);
    }
}