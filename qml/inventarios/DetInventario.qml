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
    id: qml_detInv;
    height: 600;
    width: 400;

    property int id_grupo: 0;
    property int id_item: 0;
    property int id_detInv: 0;
    property string nombre_grupo: "";

    signal iniciar;
    signal fin;
    signal cancelar;
    signal back;
    signal menu;

    ListModel{
        id: model_n1;
        /*ListElement{Id:1; cant_item: "6"; cant_memoria: 9; nombre: "Pantalones"}
        ListElement{Id:1; cant_item: "9"; cant_memoria: 9; nombre: "Polos"}
        ListElement{Id:1; cant_item: "3"; cant_memoria: 9; nombre: "Jeans"}*/
    }

    Component{
        id: estiloN1_textField;
        TextFieldStyle {
            placeholderTextColor: root.color_base_n10;
            background: Rectangle {
                implicitWidth: control.width;
                implicitHeight: control.height;
                radius: implicitHeight * .12;
                border.color: root.color_base_n3;
                border.width: 1
            }
        }
    }
    Component{
        id: deletate_det;
        Item{
            height: body.height;
            width: body.width;
            Item{
                id: d_r1;
                height: header.height;
                width: parent.width;
                Text{
                    anchors.fill: parent;
                    text: nombre;
                    verticalAlignment: Text.AlignVCenter;
                    horizontalAlignment: Text.AlignHCenter;
                    font.pixelSize: 18;
                    color: "white";
                }
            }
            Item{
                id: d_r2;
                anchors.top: d_r1.bottom;
                height: parent.height - d_r1.height;
                width: parent.width;
                Rectangle{
                    id: rec_cant_g;
                    anchors.top: parent.top;
                    anchors.left: parent.left;
                    anchors.topMargin: parent.height * .06;
                    anchors.leftMargin: parent.width * .03;
                    height: parent.height * .09;
                    width: parent.width * .33;
                    radius: height * .09;
                    border.width: 2;
                    border.color: root.color_base_n10;
                    z: 3;
                    Item{
                        height: parent.height;
                        width: parent.width;
                        Text{
                            anchors.fill: parent;
                            verticalAlignment: Text.AlignVCenter;
                            horizontalAlignment: Text.AlignHCenter;
                            text: cant_item;
                            font.pixelSize: 24;
                            font.bold: true;
                            color: root.color_base_n3
                        }
                    }
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: getCantidad(1, cant_item);
                    }
                }
                Image{
                    id: img_push;
                    anchors.top: parent.top;
                    anchors.topMargin: parent.height * .06;
                    anchors.right: parent.right;
                    anchors.rightMargin: parent.width * .03;
                    height: parent.height * .15;
                    width: height;
                    //fillMode: Image.PreserveAspectFit;
                    source: "../../src/img/push2.png";
                    MouseArea{
                        anchors.fill: parent;
                        onPressed: {
                            img_push.source = "../../src/img/push1.png";
                        }
                        onReleased: {
                            img_push.source = "../../src/img/push2.png";
                            sumar(index, cant_item, cant_memoria);
                        }
                    }
                }
                Item{
                    id: item_arriba;
                    anchors.bottom: rec_cant.top;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    height: rec_cant.height * 1.5;
                    width: height;
                    Image{
                        id: img_arriba;
                        anchors.verticalCenter: parent.verticalCenter;
                        anchors.horizontalCenter: parent.horizontalCenter;
                        height: parent.height;
                        width: parent.width;
                        fillMode: Image.PreserveAspectFit;
                        source: "../../src/img/tri.GIF";
                        MouseArea{
                            anchors.fill: parent;
                            onPressed: {
                                img_arriba.height = item_arriba.height * .96;
                                img_arriba.width = item_arriba.width * .96;
                            }
                            onReleased: {
                                img_arriba.height = item_arriba.height;
                                img_arriba.width = item_arriba.width;
                                model_n1.setProperty(index, "cant_memoria", cant_memoria + 1);
                            }
                        }
                    }
                }
                Item{
                    id: rec_cant;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    height: parent.height * .21;
                    width: parent.width * .81;
                    clip: true;
                    Text{
                        anchors.fill: parent;
                        verticalAlignment: Text.AlignVCenter;
                        horizontalAlignment: Text.AlignHCenter;
                        text: cant_memoria;
                        font.pixelSize: 96;
                        font.bold: true;
                        color: root.color_base_n7;
                    } 
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: getCantidad(2, cant_memoria);
                    }
                }
                Item{
                    id: item_abajo;
                    anchors.top: rec_cant.bottom;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    height: rec_cant.height * 1.5;
                    width: height;
                    Image{
                        id: img_abajo;
                        anchors.verticalCenter: parent.verticalCenter;
                        anchors.horizontalCenter: parent.horizontalCenter;
                        height: parent.height;
                        width: parent.width;
                        rotation: -180;
                        fillMode: Image.PreserveAspectFit;
                        source: "../../src/img/tri.GIF";
                        MouseArea{
                            anchors.fill: parent;
                            onPressed: {
                                img_abajo.height = item_abajo.height * .96;
                                img_abajo.width = item_abajo.width * .96;
                            }
                            onReleased: {
                                img_abajo.height = item_abajo.height;
                                img_abajo.width = item_abajo.width;
                                if(cant_memoria > 1)
                                    model_n1.setProperty(index, "cant_memoria", cant_memoria - 1);
                            }
                        }
                    }
                }
            }
        }
    }
    


    Rectangle {
        id: header;
        anchors.left: parent.left;
        width: parent.width;
        height: root.alto_header;
        color: color_base_n1;
    }
    Item{
        id: body;
        anchors.top: parent.top;//header.bottom;
        height: parent.height;// - header.height;
        width: parent.width;
        ListView{
            id: lst_det;
            orientation: ListView.Horizontal;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.horizontalCenter: parent.horizontalCenter;
            height: body.height;
            width: body.width;
            model: model_n1;
            delegate: deletate_det;
            onMovementEnded: {
                var nuevo_valor = lst_det.contentX - (lst_det.currentIndex * body.width);
                if(nuevo_valor >= 0){
                   if(nuevo_valor  > (body.width * .5)){ 
                        var nuevo_index = (lst_det.currentIndex +1);
                        lst_det.currentIndex = nuevo_index;
                        lst_det.positionViewAtIndex(nuevo_index, ListView.Center);
                    } else {
                        lst_det.positionViewAtIndex(lst_det.currentIndex, ListView.Center);
                    }
                } else {
                    if(nuevo_valor  < -(body.width * .5)){ 
                        var nuevo_index = (lst_det.currentIndex - 1);
                        lst_det.currentIndex = nuevo_index;
                        lst_det.positionViewAtIndex(nuevo_index, ListView.Center);
                    } else {
                        lst_det.positionViewAtIndex(lst_det.currentIndex, ListView.Center);
                    }
                }
            }
        }
        
    }
    Item {
        id: header2;
        anchors.left: parent.left;
        width: parent.width;
        height: root.alto_header;
        Row
        {
            anchors.fill: parent;
            Item
            {
                height: parent.height;
                width: parent.width * 0.2;
                Rectangle {
                    id: back_secciones;
                    color: Util.Color.rgba(0, 0, 0, 0);
                    width: parent.width * 0.4;
                    height: parent.height;
                    Image {
                        height: parent.height * 0.7;
                        width: parent.width * 0.9;
                        source: "../../src/img/iconbackmen.png";
                        anchors.verticalCenter: parent.verticalCenter;
                        anchors.horizontalCenter: parent.horizontalCenter;
                    }
                }
                MouseArea
                {
                    anchors.fill: parent;
                    onClicked: back();
                }
            }   
            Item
            {
                height: parent.height;
                width: parent.width * 0.6;
            }
            Item
            {
                height: parent.height;
                width: parent.width * 0.2;
            }
        }    
    }

    Rectangle{
    	anchors.bottom: parent.bottom;
    	anchors.bottomMargin: parent.height * .03;
        anchors.right: parent.right;
        anchors.rightMargin: parent.width * .03;
        height: parent.height * .072;
        width: txt_grupo.width * 1.2;
        radius: height * .12;
        color: Qt.rgba(0,0,0,0);
        border.color: root.color_base_n1;
        border.width: 1;
        Text{
        	id: txt_grupo;
            anchors.horizontalCenter: parent.horizontalCenter;
            height: parent.height;

            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignHCenter;
            text: "Nombre Grupo";
            font.pixelSize: 24;
            color: root.color_base_n2;
            font.bold: true;
        }
        MouseArea{
            anchors.fill: parent;
            onClicked: nuevo();
        }
    }

    onIniciar: {
        cargaInicial();
    }
    function cargaInicial(){
        var id_item = 0;
        if(qml_maestro.pages[1] == "vistas/VistaN1.qml"){
            var reg_resumen = app_manager.MODELO_N1.getJson()[app_manager.MODELO_N1.getId()];
            id_item = reg_resumen.id_item;
        } else {
            var reg_resumen = app_manager.ITEMS.getJson()[app_manager.ITEMS.getId()];
            id_item = reg_resumen.id_item;
        }
        txt_grupo.text = app_manager.GRUPOS.getDisplay();
        
        var json_items = app_manager.GRUPOS.getDetalles(app_manager.GRUPOS.getId()), index_sel = 0, cont = 0;
        model_n1.clear();
        for(var id in json_items){
            if(json_items[id].id_item == id_item)
                index_sel = cont;
            var cant_memoria = json_items[id].cant_memoria,
                cant = json_items[id].cant;
            model_n1.append({
                "id": json_items[id].id,
                "id_item": json_items[id].id_item,
                "cant_item": (cant * 1.00) ,
                "cant_memoria": (cant_memoria * 1.000),
                "nombre": json_items[id].nombre,
                "id_json": id
            })
            cont ++;
        }
        lst_det.currentIndex = index_sel;
        lst_det.positionViewAtIndex(index_sel, ListView.Center);
    }
    onFin: {
        if(qml_maestro.pages[qml_maestro.pages.length - 1] == "inventarios/DetInventario.qml")
            qml_maestro.pages.pop();
        qml_detInv.destroy();
    }
    onBack: {
        qml_maestro.back(function(){
            
        });
    }
    Component.onCompleted: iniciar();

    function sumar(nIndex, cant_item, cant_memoria){
        var reg = lst_det.model.get(nIndex);
        Mensaje.esperar(root, null);
        app_manager.ITEMS.modCant(reg.id_json, reg.id_item, reg.id, ((cant_item + cant_memoria)), function(status, msg){
            Mensaje.hide();
            if(status != 1){
                Mensaje.error(root, msg);
            }
        });
        model_n1.setProperty(nIndex, "cant_item", (cant_item + cant_memoria));
        model_n1.setProperty(nIndex, "cant_memoria", 1);
    }

    function getCantidad(modificar_a, cantidad){
        var component = Qt.createComponent('../Items/GetCant.qml'), qml_n;
        if(component.status == Component.Ready)
        {
            qml_n = component.createObject(root);
            qml_n.height = root.height;
            qml_n.width = root.width;
            qml_n.cant = cantidad;
            if(modificar_a == 1)
                qml_n.aceptar.connect(qml_detInv.modCant);
            else if(modificar_a == 2)
                qml_n.aceptar.connect(qml_detInv.modCatMemoria);
        }
    }
    function modCant(cant){
        model_n1.setProperty(lst_det.currentIndex, "cant_item", cant);
    }
    function modCatMemoria(cant){
        model_n1.setProperty(lst_det.currentIndex, "cant_memoria", cant);
    }
}