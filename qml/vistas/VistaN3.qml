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

    Component{
    	id: delegate_grupo;
    	Item{
    		height: grid_grupos.cellHeight;
    		width: grid_grupos.cellWidth;
    		Rectangle{
    			anchors.verticalCenter: parent.verticalCenter;
    			anchors.horizontalCenter: parent.horizontalCenter;
    			height: parent.height * .9;
    			width: parent.width * .9;
    			radius: height * .12;
    			border.color: root.color_base_n3;
    			border.width: 1;
                MouseArea{
                    anchors.fill: parent;
                    onClicked: selItem(index);
                }
    			Item{
    				id: item_nombre;
    				anchors.top: parent.top;
    				anchors.left: parent.left;
                    anchors.leftMargin: parent.width * .03;
    				anchors.topMargin: parent.height * .12
    				height: parent.height *.4;
    				width: parent.width * .6;
    				Text{
    					anchors.fill: parent;
    					verticalAlignment: Text.AlignVCenter;
    					horizontalAlignment: Text.AlignHCenter;
    					text: nombre;
    					font.pixelSize: 18;
                        color: root.color_base_n8;
                        wrapMode: Text.Wrap;
    				}
    			}
    			Rectangle{
    				id: item_cant;
    				anchors.bottom: parent.bottom;
    				anchors.left: parent.left;
    				anchors.leftMargin: parent.height * .12;
    				anchors.bottomMargin: parent.height * .12;
    				height: parent.height *.3;
    				width: height;
    				radius: height / 2;
    				border.color: root.color_base_n1;
    				border.width: 1;
    				Text{
    					anchors.fill: parent;
    					verticalAlignment: Text.AlignVCenter;
    					horizontalAlignment: Text.AlignHCenter;
    					text: cant_items;
    					font.pixelSize: 24;
                        color: root.color_base_n3;
    				}
    			}
    			BtnMenu{
	    			anchors.right: parent.right;
                    anchors.rightMargin: parent.width * .03;
	    			anchors.verticalCenter: parent.verticalCenter;
	    			height: parent.height * .33;
	    			width: height;
		            MouseArea{
		            	anchors.fill: parent;
		            	onClicked: {mostrarMenuItem(index);}
		            }
	    		}
    		}
    	}
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
  			GridView 
			{
				id: grid_grupos;				
				cellHeight: parent.width / 2.5; 
				cellWidth: parent.width / 2;
				anchors.fill: parent
				focus: true
				clip: true;
				model: model_grupos
				delegate: delegate_grupo;
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
                        text: "Modificar nombre de Grupo";
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
                        text: "Eliminar Grupo";
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
        for(var i = (qml_maestro.pages.length - 1); i > 1; i --){
            qml_maestro.pages.pop();
        }
    }
    onFin: {
        qml_vista.destroy();
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
            qml_item_nuevo.desaparecer.connect(qml_vista.terminaNuevo);
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
                    }
                });
            }
        });
    }
    function mostrarMenuItem(nIndex){
        if(app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()].estado != "NUEVO")
            return;
        app_manager.GRUPOS.setIndex(nIndex);
        txt_nom_item.text = app_manager.GRUPOS.getDisplay()+"   ";
        rec_menu_item.visible = true;
    }
    function eliminarRegistro(){
        if(app_manager.GRUPOS.getJson()[app_manager.GRUPOS.getId()].es_principal == 1){
            Mensaje.error(root, "Este grupo no debe ser eliminado");
            rec_menu_item.visible = false;
            return;
        }
        var nombre_reg = app_manager.GRUPOS.getDisplay();
        rec_menu_item.visible = false;
        Mensaje.confirmar(root, "Confirma eliminar " + nombre_reg, function(status, value){
            if(!status){
                //qml_menuItem.eliminar(0, "Se cancelo la operacion");
            } else {
                Mensaje.esperar(root, "")
                app_manager.GRUPOS.eliminar(app_manager.GRUPOS.getId(), function(status, msg){
                    Mensaje.hide();
                });
            }
        });
    }
    function modificarRegistro(){
        var nombre_reg = app_manager.GRUPOS.getDisplay();
        rec_menu_item.visible = false;
        Mensaje.prompt2(root, "Modificar nombre de Item ", nombre_reg, function(status, value){
            if(!status){
                //qml_menuItem.modificar(0, "Se cancelo la operacion")
            } else {
                Mensaje.esperar(root, "")
                app_manager.GRUPOS.modificarNombre(app_manager.GRUPOS.getId(), value, function(status, msg){
                    Mensaje.hide();
                    if(status != 1)
                        Mensaje.error(root, msg);
                });
            }
        });
    }
    function selItem(nIndex){
        barrera.visible = true;
        app_manager.GRUPOS.setIndex(nIndex);
        qml_maestro.pages.push("vistas/VistaItems.qml");
        qml_maestro.next(null);
    }
    function selVista(vista){
        var nom_component, menu_vistas;
        if(vista == 1){
            nom_component = "VistaN1.qml";
        } else if(vista == 2){
            nom_component = "VistaN2.qml";
        } else if(vista == 3){
            return;
            //nom_component = "VistaN3.qml";
        }
        qml_maestro.pages[1] = "vistas/"+nom_component;
        qml_maestro.setIndex(1, null);
    }
    function terminaNuevo(){
        barrera.visible = false;
    }
}