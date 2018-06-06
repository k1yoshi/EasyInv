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

    ListModel{
        id: model_n1;
        /*ListElement{Id:1; cant_item: "6"; cant_memoria: 9; nombre: "Pantalones"}
        ListElement{Id:1; cant_item: "9"; cant_memoria: 9; nombre: "Polos"}
        ListElement{Id:1; cant_item: "3"; cant_memoria: 9; nombre: "Jeans"}*/
    }

    HeaderInv {
        id: header;
        anchors.left: parent.left;
        width: parent.width;
        height: parent.height * 0.07;
        onBack: qml_maestro.back(null);
        onNuevo: nuevoItem();
        titulo: "Grupo";
    }
    Item {
    	id: body;
    	anchors.top: header.bottom;
    	height: parent.height - header.height - footer.height;
    	width: parent.width;
  		Item{
  			id: row_1;
  			anchors.bottom: parent.bottom;
  			height: parent.height * .96;
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
                        anchors.rightMargin: parent.width * .03;
		            	anchors.right: parent.right;
		            	height: parent.height * .72;
		            	width: height;
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
        anchors.left: parent.left;
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
        cargaInicial();
    }
    function cargaInicial(){
        header.titulo = app_manager.GRUPOS.getDisplay();
        var json_items = app_manager.GRUPOS.getDetalles(app_manager.GRUPOS.getId());
        model_n1.clear();
        for(var id in json_items){
            model_n1.append({
                "id": json_items[id].id,
                "id_item": json_items[id].id_item,
                "cant": (json_items[id].cant * 1.000),
                "nombre": json_items[id].nombre,
                "id_json": id
            })
        }
    }
    onFin: {
        qml_vista.destroy();
    }
    Component.onCompleted: iniciar();

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
    }
    
    function selItem(nIndex){
        if(app_manager.INVENTARIOS.getJson()[app_manager.INVENTARIOS.getId()].estado != "NUEVO")
            return;
        var reg = model_n1.get(nIndex);
        barrera.visible = true;
        app_manager.ITEMS.setIndexId(reg.id);
        qml_maestro.pages.push("inventarios/DetInventario.qml");
        qml_maestro.next(function(){});
    }


}