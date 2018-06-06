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

    signal iniciar;
    signal fin;
    signal mostrarMenuVistas;

    property variant qml_item_nuevo;
    property int index_sel: 0;

    HeaderInv {
        id: header;
        anchors.left: parent.left;
        width: parent.width;
        height: root.alto_header;
        onBack: qml_maestro.back(null);
        onNuevo: nuevoItem();
    }
    Item {
    	id: body;
    	anchors.top: header.bottom;
    	height: parent.height - header.height - footer.height;
    	width: parent.width;
    	Image{
			anchors.right: parent.right;
			anchors.rightMargin: parent.width * .06;
			anchors.top: parent.top;
			anchors.topMargin: parent.height * .01;
			height: parent.height * .07;
			width: height;
			z: 9;
			source: "../../src/img/menu_grid2.png";
			MouseArea{
				anchors.fill: parent;
				onClicked: {
					mostrarMenuVistas();
				}
			}
		}
  		Item{
  			id: row_1;
  			anchors.bottom: parent.bottom;
  			height: parent.height * .93;
  			width: parent.width;
  			ListaOrdenada {
		        id: lst_v1;
		        anchors.top: parent.top;
		        anchors.left: parent.left;
		        width: parent.width;
		        height: parent.height * .9;
		        model: model_vistaN1;
		        spacing: 1;
		        item_delegate: ItemOrden{
		            id: item_d;
		            width: lst_v1.width;
		            height: lst_v1.height * .096;
		            color: "#FFF";
		            lst: lst_v1.lst;
		            MouseArea{
		                anchors.fill: parent;
		                onClicked: selItem(index);
		            }
		            
		            Rectangle{
		            	id: rec_cant;
		                anchors.verticalCenter: parent.verticalCenter;
		                anchors.left: parent.left;
		                anchors.leftMargin: parent.width * .015;
		                color: Qt.rgba(0,0,0,0);
		                height: parent.height * .72;
		                width: parent.width * .18;
		                radius: height * .18;
		                border.width: 1;
		                border.color: root.color_base_n1;
		                Text{
		                	anchors.fill: parent;
		                	verticalAlignment: Text.AlignVCenter;
		                	horizontalAlignment: Text.AlignHCenter;
		                	text: cant;
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
		                color: root.color_base_n8;
		            }
		            BtnMenu{
                        anchors.verticalCenter: parent.verticalCenter;
		            	anchors.right: parent.right;
                        anchors.rightMargin: parent.width * .03;
		            	height: parent.height * .72;
                        width: height;
		            	//width: parent.width * .09;
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
        height: parent.height * .12;
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
        id: rec_sub;
        anchors.fill: parent;
        visible: false;
        color: Qt.rgba(0,0,0,.5);

        property double max: height * .9;
        property double alto_item: qml_vista.height * .09;
        MouseArea{
            anchors.fill: parent;
            onClicked: rec_sub.visible = false;
        }

        Rectangle{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.horizontalCenter: parent.horizontalCenter;
            height: parent.height * .63;
            width: parent.width * .72;
            radius: height * .006;
            ListView{
                anchors.verticalCenter: parent.verticalCenter;
                anchors.horizontalCenter: parent.horizontalCenter;
                model: model_sub;
                width: parent.width;
                height: (rec_sub.alto_item * model_sub.count) > rec_sub.max ? rec_sub.max : (rec_sub.alto_item * model_sub.count);
                delegate: Item{
                    height: rec_sub.alto_item;
                    width: parent.width;
                    Rectangle{
                        anchors.top: parent.top;
                        width: parent.width;
                        color: "#727272";
                        height: 1;
                        visible: index == 0;
                    }
                    Rectangle{
                        id: sub_cant;
                        anchors.verticalCenter: parent.verticalCenter;
                        anchors.left: parent.left;
                        anchors.leftMargin: parent.width * .015;
                        color: Qt.rgba(0,0,0,0);
                        height: parent.height * .72;
                        width: parent.width * .18;
                        radius: height * .18;
                        border.width: 1;
                        border.color: "#c9c9c9";
                        Text{
                            anchors.fill: parent;
                            verticalAlignment: Text.AlignVCenter;
                            horizontalAlignment: Text.AlignHCenter;
                            text: cant;
                            font.pixelSize: 18;
                            font.bold: true;
                            color: "#b8b8b8";
                        }
                        MouseArea{
                            anchors.fill: parent;
                            onClicked: mostrarMenuItem(index);
                        }
                    }
                    Text{
                        anchors.left: sub_cant.right;
                        height: parent.height;
                        width: parent.width * .6;
                        text: " "+nombre;
                        verticalAlignment: Text.AlignVCenter;
                        font.pixelSize: 24;
                        color: "#515151";
                    }
                    Rectangle{
                        anchors.bottom: parent.bottom;
                        width: parent.width;
                        color: "#727272";
                        height: 1;
                    }
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: selSubItem(index);
                    }
                }
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
            btn_finalizar.visible = (app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()].estado == "NUEVO");
    	}
    }
    onFin: {
        qml_vista.destroy();
    }
    ListModel{
        id: model_sub;
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
    function mostrarMenuItem(nIndex){
        if(app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()].estado != "NUEVO")
            return;
        app_manager.MODELO_N1.setIndex(nIndex);
        txt_nom_item.text = app_manager.MODELO_N1.getDisplay()+"   ";
        rec_menu_item.visible = true;
    }
    function nuevoItem(){
        if(app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()].estado != "NUEVO")
            return;
        barrera.visible = true;
        app_manager.GRUPOS.setPrincipal();
        var component = Qt.createComponent('../Items/NuevoItem.qml');
        if(component.status == Component.Ready)
        {
            qml_item_nuevo = component.createObject(root);
            qml_item_nuevo.id_grupo = app_manager.GRUPOS.getId();
            qml_item_nuevo.height = root.height;
            qml_item_nuevo.width = root.width;
            qml_item_nuevo.visible = true;
            qml_item_nuevo.z = 96;
            qml_item_nuevo.aparecer();
        }
        barrera.visible = false;
    }
    function eliminarRegistro(){
        var nombre_reg = app_manager.MODELO_N1.getDisplay();
        rec_menu_item.visible = false;
        Mensaje.confirmar(root, "Confirma eliminar " + nombre_reg, function(status, value){
            if(!status){
                //qml_menuItem.eliminar(0, "Se cancelo la operacion");
            } else {
                Mensaje.esperar();
                app_manager.MODELO_N1.eliminar(app_manager.MODELO_N1.getId(), function(status, msg){
                    Mensaje.hide();
                });
            }
        });
    }
    function modificarRegistro(){
        var nombre_reg = app_manager.MODELO_N1.getDisplay();
        rec_menu_item.visible = false;
        Mensaje.prompt2(root, "Modificar nombre de Item ", nombre_reg, function(status, value){
            if(!status){
                //qml_menuItem.modificar(0, "Se cancelo la operacion")
            } else {
                Mensaje.esperar(root, "");
                app_manager.modificarNombreItem(app_manager.MODELO_N1.getJson()[app_manager.MODELO_N1.getId()].id_item , value, function(status, msg){
                    Mensaje.hide();
                    if(status != 1)
                        Mensaje.error(root, msg);
                });
            }
        });
    }
    function selSubItem(nIndex){
        var reg = model_sub.get(nIndex);
        app_manager.GRUPOS.setIndexId(reg.id_grupo);
        app_manager.MODELO_N1.setIndex(qml_vista.index_sel);
        qml_maestro.pages.push("inventarios/DetInventario.qml");
        qml_maestro.next(null);
    }
    function selItem(nIndex){
        barrera.visible = true;
        if(app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()].estado != "NUEVO")
            return;
        qml_vista.index_sel = nIndex;
        var reg = model_vistaN1.get(nIndex);
        if(reg.cant_grupos < 2){
            barrera.visible = true;
            var json_items = app_manager.ITEMS.getJson();
            for(var id in json_items){
                if(json_items[id].id_item == reg.id_item){
                    app_manager.GRUPOS.setIndexId(json_items[id].id_grupo);
                    break;
                }
            }
            app_manager.MODELO_N1.setIndex(nIndex);
            qml_maestro.pages.push("inventarios/DetInventario.qml");
            qml_maestro.next(null);
        } else {
            model_sub.clear();
            var json_grupos = app_manager.GRUPOS.getJson();
            var json_items = app_manager.ITEMS.getJson();
            for(var id in json_items){
                if(json_items[id].id_item == reg.id_item){
                    model_sub.append({
                        "id_grupo": json_items[id].id_grupo,
                        "cant": (json_items[id].cant * 1.000),
                        "nombre": json_grupos[json_items[id].id_grupo].nombre,
                        "id_item": json_items[id].id_item
                    });
                }
            }
            rec_sub.visible = true;
            //Mensaje.error(root, "mostrar en grupos");
        }
        barrera.visible = false;
    }
    function selVista(vista){
        var nom_component, menu_vistas;
        if(vista == 1){
            //component = Qt.createComponent('VistaN1.qml');
            return;
        } else if(vista == 2){
            nom_component = "VistaN2.qml";
        } else if(vista == 3){
            nom_component = "VistaN3.qml";
        }
        qml_maestro.pages[1] = "vistas/"+nom_component;
        qml_maestro.setIndex(1, null);
    }
}