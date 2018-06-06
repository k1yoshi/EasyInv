import QtQuick 2.1
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

import "MyComponents"
import "MyComponents/js/mensajes.js" as Mensaje
import "../js/db.js" as Db
import "../js/util.js" as Util

Rectangle 
{
	id: qml_menu;

    height: 600;
    width: 400;
    color: root.color_base_n9;

    signal empresas;
    signal botellas;
    signal soporte;
    signal cerrar;
    signal callback(int status, string msg);

    Rectangle {
    	id: barra_arriba;
    	width: parent.width;
    	height: root.alto_header;
    	Rectangle {
	        anchors.fill: parent;
	        color: root.color_base_n8;
	    }
	    Text {
	    	anchors.fill: parent;
	    	text: "  EasyInv MENU";
	    	color: "#fff";
	    	font.bold: true;
	    	font.pointSize: 14;
	    	verticalAlignment: Text.AlignVCenter
            //horizontalAlignment: Text.AlignHCenter;
	    }
    }
	ScrollView {
    	anchors.top: barra_arriba.bottom;
        width: parent.width;
        height: parent.height * 0.93;
        flickableItem.interactive: true;
        ListView {
        	
            ListModel {
                id: default_model;
            }
            anchors.fill: parent
            model: default_model;
            delegate: 
            Item {
            	id: rect_n1;
                width: parent.width
                height: qml_menu.height * 0.12;
                signal clicked
                Item {
                    width: parent.width;
                    height: parent.height;
                    Item {
                    	id: img_menu;
                    	width: parent.width * 0.2;
                    	height: parent.height + 2;
                    	Image {
                    		width: parent.width * 0.7;
	                    	height: parent.height * 0.6;
	                    	source: url_image;
	                    	anchors.verticalCenter: parent.verticalCenter;
	                    	anchors.horizontalCenter: parent.horizontalCenter;
                    	}
                    }
                    Text {
                        id: textitem;
                        anchors.left: img_menu.right;
                        anchors.leftMargin: parent.width * 0.03;
                        width: parent.width * 0.8;
                        height: parent.height;
                        color: "#fff";
                        font.pointSize: 16;
                        font.family: root.fuente;
                        text: nombre
                        verticalAlignment: Text.AlignVCenter
                    }
                    MouseArea {
                    	anchors.fill: parent;
                    	onClicked: {
                    		switch(accion) {
                    			case 'emp': empresas(); break;
                    			case 'add_botella': botellas(); break;
                    			case 'msg_soporte': soporte(); break;
                    			case 'cerrar': cerrar(); break;
                    			default : console.log('opcion no valida');
                    		}
                    	}
                    }
                }
                Rectangle {
                	//anchors.bottom: parent.bottom;
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.topMargin: 15;
                    anchors.bottomMargin: 15;
                    height: 1
                    color: Util.Color.rgba(255, 255, 255, 0.3);
                    opacity: index;
                }
            }
        }
        style: ScrollViewStyle {
            transientScrollBars: true
            handle: Item {
                implicitWidth: 14
                implicitHeight: 26
                Rectangle {
                    color: "#000";//"#424246"
                    anchors.fill: parent
                    anchors.topMargin: 6
                    anchors.leftMargin: 4
                    anchors.rightMargin: 4
                    anchors.bottomMargin: 6
                }
            }
            scrollBarBackground: Item {
                implicitWidth: 14
                implicitHeight: 26
            }
        }
    }

    onEmpresas: {
        contenedor_qml.setSource("Maestro.qml", {index: 0});
    }
    onBotellas: {
    	contenedor_qml.setSource("menu/Config.qml");
    }
    onSoporte: {
    	contenedor_qml.setSource("menu/Info.qml");
    }
    onCerrar: {
        app_manager.CUENTA.salir(qml_menu.callback);
    }
    Component.onCompleted: {
        default_model.append({
        	'nombre': "INVENTARIOS", 'accion': 'emp', 'url_image': "../src/img/iconempresas.png"
        });
        default_model.append({
        	'nombre': "CONFIGURAR CONEXION", 'accion': 'add_botella', 'url_image': "../src/img/iconenviar.png"
        });
        default_model.append({
        	'nombre': 'ACERCA DE "EASYINV"', 'accion': 'msg_soporte', 'url_image': "../src/img/iconsoporte.png"
        });
        default_model.append({
        	'nombre': Db.MENU_4, 'accion': 'cerrar', 'url_image': "../src/img/iconout.png"
        });
    }
    onCallback: {
        if(status == 1){
            contenedor_qml.setSource("Login.qml", {index: 0});
        } else {
            Mensaje.error(root, msg);
        }
    }
}