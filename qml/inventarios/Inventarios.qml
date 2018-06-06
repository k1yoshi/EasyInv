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

Item 
{
	id: qml_inventarios;
	height: 600;
    width: 400;

    signal iniciar;
    signal fin;
    signal inventariarTodo;
    signal termino(int status, string msg);

    Menu {
        id: menu;
        height: parent.height;
        width: parent.width * 0.85;
        z: 2;
        x: -width;
        Behavior on x { NumberAnimation{duration: 500}}
    }

    HeaderPrincipal {
        id: header;
        anchors.left: menu.right;
        width: parent.width;
        height: root.alto_header;
        titulo: "Mis Inventarios";
        onMenu: mostrarMenu();
        onAdd: agregarRegistro();
    }

    ListaOrdenada {
        id: lst_bares;
        anchors.top: header.bottom;
        anchors.left: menu.right;
        width: parent.width;
        height: parent.height - header.height - footer.height;
        Behavior on x { NumberAnimation{duration: 500}}
        model: model_inv;
        spacing: 1;
        item_delegate: ItemOrden{
            id: item_d;
            width: lst_bares.width;
            height: lst_bares.height * .12;
            color: "#FFF";
            lst: lst_bares.lst;
            MouseArea{
                anchors.fill: parent;
                onClicked: selItem(index);
            }
            Item{
            	height: parent.height;
            	width: parent.width * .75;
            	Item{
            		anchors.top: parent.top;
            		height: parent.height *.6;
            		width: parent.width;
            		Text{
		                anchors.fill: parent;
		                text: " "+fecha+" "+nombre;
		                verticalAlignment: Text.AlignVCenter;
		                font.pixelSize: 21;
		                color: root.color_base_n8;
		            }
            	}
            	Item{
            		anchors.bottom: parent.bottom;
            		height: parent.height *.4;
            		width: parent.width;
            		Text{
		                anchors.fill: parent;
		                text: " "+hora;
		                verticalAlignment: Text.AlignVCenter;
		                font.pixelSize: 18;
		                color: root.color_base_n3;
		            }
            	}
            }

            Item{
            	anchors.right: btn_subMenu.left;
            	anchors.rightMargin: 3;
            	height: parent.height;
            	width: txt_estado.width * 1.2;
            	Rectangle{
            		anchors.verticalCenter: parent.verticalCenter;
            		anchors.horizontalCenter: parent.horizontalCenter;
            		height: parent.height * .6;
            		width: txt_estado.width * 1.2;
            		color: estado == "NUEVO" ? root.color_base_n7 : (estado == "EDITANDO" ? "orange" : "#6c789b");
            		radius: height * .12;
            		Text{
                        id: txt_estado;
		                height: parent.height;
                        anchors.horizontalCenter: parent.horizontalCenter;
		                text: estado;
		                verticalAlignment: Text.AlignVCenter;
		                horizontalAlignment: Text.AlignHCenter;
		                font.pixelSize: 15;
		                color: "#FFF";
		            }
            	}
            }
            
            BtnMenu{
            	id: btn_subMenu;
                anchors.verticalCenter: parent.verticalCenter;
                anchors.right: parent.right;
                anchors.rightMargin: parent.width * .03;
                height: parent.height * .7;
                width: height;
                
                MouseArea{
                    anchors.fill: parent;
                    onClicked: mostrarMenuItem(index);
                }
            }
        }
    }

    Item {
        id: footer;
        anchors.bottom: parent.bottom;
        anchors.left: menu.right;
        width: parent.width;
        height: parent.height * 0.07;  
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
            height: parent.height * .39;
            width: parent.width * .72;
            radius: height * .09;
            Column{
                anchors.verticalCenter: parent.verticalCenter;
                anchors.horizontalCenter: parent.horizontalCenter;
                width: parent.width;
                spacing: 9;
                Rectangle{
                    anchors.horizontalCenter: parent.horizontalCenter;
                    height: qml_inventarios.height * .093;
                    width: parent.width * .81;
                    radius: height * .12;
                    color: Qt.rgba(0,0,0,0);
                    border.color: root.color_base_n3;
                    border.width: 1;
                    Text{
                        anchors.fill: parent;
                        verticalAlignment: Text.AlignVCenter;
                        horizontalAlignment: Text.AlignHCenter;
                        text: "Modificar Inventario";
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
                    height: qml_inventarios.height * .093;
                    width: parent.width * .81;
                    radius: height * .12;
                    color: Qt.rgba(0,0,0,0);
                    border.color: root.color_base_n3;
                    border.width: 1;
                    Text{
                        anchors.fill: parent;
                        verticalAlignment: Text.AlignVCenter;
                        horizontalAlignment: Text.AlignHCenter;
                        text: "Eliminar Inventario";
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
                height: qml_inventarios.height * .09;
                width: parent.width;
                Text{
                    id: txt_nom_item;
                    anchors.right: parent.right;
                    verticalAlignment: Text.AlignVCenter;
                    height: parent.height;
                    text: "";
                    font.pixelSize: 21;
                    color: root.color_base_n8;
                    font.family: root.fuente;
                }
            }
        }
    }

    Component.onCompleted: {
        iniciar();
    }
    onIniciar: {
        //header.titulo = drinkventario.SUCURSAL.getDisplay();
    }
    onFin: {
        qml_inventarios.destroy();
    }
    onTermino: {
        if(status != 1){
            Mensaje.error(root, msg);
        }
    }
    onInventariarTodo: {
        //drinkventario.inventariar(qml_inventarios.termino);
    }

    function mostrarMenu(){
        var pos_x = menu.x < 0 ? 0.85 : 0;
        menu.x = menu.x < 0 ? 0 : -(parent.width * 0.85);
    }
    function mostrarMenuItem(nIndex){
        app_manager.INVENTARIOS.setIndex(nIndex);
        txt_nom_item.text = app_manager.INVENTARIOS.getDisplay()+"   ";
        rec_menu_item.visible = true;
    }
    function agregarRegistro(){
        Mensaje.prompt(root, "Ingrese un alias para el inventario", function(status, value){
            if(status){
                app_manager.INVENTARIOS.nuevo(app_manager.CUENTA.id, value, "", "", "", function(status, msg){
                    if(status != 1){
                        Mensaje.error(root, msg);
                    }
                });
            }
        });
    }
    function eliminarRegistro(){
        var nombre_reg = app_manager.INVENTARIOS.getDisplay();
        rec_menu_item.visible = false;
        Mensaje.confirmar(root, "Confirma eliminar " + nombre_reg, function(status, value){
            if(!status){
                
            } else {
                Mensaje.esperar();
                app_manager.INVENTARIOS.eliminar(app_manager.CUENTA.id, app_manager.INVENTARIOS.getId(), function(status, msg){
                    Mensaje.hide();
                });
            }
        });
    }
    function modificarRegistro(){
        rec_menu_item.visible = false;
        var component = Qt.createComponent("ModInv.qml");
        if(component.status == Component.Ready){
            var qml_temp = component.createObject(qml_inventarios);
            qml_temp.height = parent.height;
            qml_temp.width = parent.width;
            qml_temp.cargar();
        }
    }
    function selItem(nIndex){
        qml_maestro.next(function(){
        	app_manager.INVENTARIOS.setIndex(nIndex);
            app_manager.INVENTARIOS.cargarResumen(function(status, msg){
                if(status != 1)
                    Mensaje.error(root, msg);
                else
                    this.main_qml.iniciar();
            });
       });
    }
}