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

Rectangle 
{
    id: qml_nuevoItem;
    height: 600;
    width: 400;

    property int tipo_peticion: 1;

    signal iniciar;
    signal fin;
    signal cancelar;

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
    Menu {
        id: menu;
        height: parent.height;
        width: parent.width * 0.85;
        z: 2;
        x: -width;
        Behavior on x { NumberAnimation{duration: 500}}
    }
    Rectangle {
        id: header;
        anchors.top: parent.top;
        anchors.left: menu.right;
        width: parent.width;
        height: root.alto_header;
        color: root.color_base_n1;
        Item
        {
            height: parent.height;
            width: parent.width * 0.2;
            Image {
                height: parent.height * 0.7;
                width: parent.width * 0.5;
                source: "../../src/img/menuicon.png";
                anchors.verticalCenter: parent.verticalCenter;
                anchors.left: parent.left;
                anchors.leftMargin: 5;
                //anchors.horizontalCenter: parent.horizontalCenter;
            }
            MouseArea { anchors.fill: parent; onClicked: mostrarMenu(); }
        }
    }

    Item{
        id: body;
        anchors.top: header.bottom;
        anchors.left: menu.right;
        height: parent.height - header.height - footer.height;
        width: parent.width;
        Item{
            id: rg_n1;
            anchors.top: parent.top;
            anchors.topMargin: parent.height * .03;
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height * .1;
            width: parent.width * .9;
            Rectangle{
                id: rect_check;
                anchors.left: parent.left;
                anchors.verticalCenter: parent.verticalCenter;
                height: parent.height * .72;
                width: height;
                radius: height * .27;
                property bool seleccionado: false;
                color: Qt.rgba(0,0,0,0);
                border.color: root.color_base_n8;
                border.width: 2;
                Rectangle{
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    height: parent.height * .72;
                    width: height;
                    radius: height * .27;
                    color: rect_check.seleccionado ? root.color_base_n1 : Qt.rgba(0,0,0,0);
                }
            }
            Item{
                anchors.top: parent.top;
                anchors.left: rect_check.right;
                anchors.leftMargin: parent.width * .03;
                height: parent.height;
                width: parent.width - rect_check.width;
                clip: true;
                Text{
                    verticalAlignment: Text.AlignVCenter;
                    height: parent.height;
                    wrapMode: Text.WordWrap;
                    text: "Activar envio al finalizar Inventario";
                    font.pixelSize: 18;
                    font.family: root.fuente;
                    color: root.color_base_n8;
                }
            }
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    rect_check.seleccionado = !rect_check.seleccionado;
                }
            }
        }
        Item{
            id: rg_n2;
            anchors.top: rg_n1.bottom;
            anchors.topMargin: parent.height * .03;
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height * .15;
            width: parent.width * .9;
            Item{
                anchors.top: parent.top;
                height: parent.height * .3;
                width: parent.width;
                clip: true;
                Text{
                    horizontalAlignment: Text.AlignLeft;
                    verticalAlignment: Text.AlignVCenter;
                    height: parent.height;
                    width: parent.width;
                    wrapMode: Text.WordWrap;
                    text: "URL Servidor";
                    font.pixelSize: 21;
                    font.family: root.fuente;
                    color: root.color_base_n8;
                }
            }
            TextField {
                id: txt_servidor;
                anchors.bottom: parent.bottom;
                anchors.left: parent.left;
                width: parent.width;
                height: parent.height * .54;
                font.pixelSize: 21;
                font.family: root.fuente;
                textColor: root.color_base_n3;
                style: estiloN1_textField;
                placeholderText: "http://dominio.com";
            }
        }
        Item{
            id: row_n3;
            anchors.top: rg_n2.bottom;
            anchors.topMargin: parent.height * .042;
            anchors.horizontalCenter: parent.horizontalCenter;
            height: parent.height * .1;
            width: parent.width * .9;

            Item{
                id: item_c1;
                anchors.left: parent.left;
                height: parent.height;
                width: parent.width * .5;
                Image{
                    id: img_c1;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: parent.left;
                    anchors.leftMargin: parent.width * .03;
                    height: parent.height * .72;
                    width: height;
                    source: tipo_peticion == 1 ? "../../src/img/check.png" : "../../src/img/uncheck.png";
                }
                Text{
                    anchors.left: img_c1.right;
                    text: " POST";
                    height: parent.height;
                    verticalAlignment: Text.AlignVCenter;
                    color: root.color_base_n8;
                    font.pixelSize: 21;
                }
                MouseArea{anchors.fill: parent; onClicked: tipo_peticion = 1;}
            }
            Item{
                id: item_c2;
                anchors.right: parent.right;
                height: parent.height;
                width: parent.width * .5;
                Image{
                    id: img_c2;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: parent.left;
                    anchors.leftMargin: parent.width * .03;
                    height: parent.height * .72;
                    width: height;
                    source: tipo_peticion == 2 ? "../../src/img/check.png" : "../../src/img/uncheck.png";
                }
                Text{
                    anchors.left: img_c2.right;
                    text: " GET";
                    height: parent.height;
                    verticalAlignment: Text.AlignVCenter;
                    color: root.color_base_n8;
                    font.pixelSize: 21;
                }
                MouseArea{anchors.fill: parent; onClicked: tipo_peticion = 2;}
            }
        }
    }

    Item {
        id: footer;
        anchors.left: menu.right;
        anchors.bottom: parent.bottom;
        width: parent.width;
        height: parent.height * .12;
        Rectangle{height: 1; width: parent.width; color: root.color_base_n10;}
        Rectangle{
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right;
            anchors.rightMargin: parent.width * .03;
            height: parent.height * .72;
            width: parent.width * .36;
            radius: height * .12;
            color: Qt.rgba(0,0,0,0);
            border.color: root,color_base_n1;
            border.width: 1;
            Text{
                anchors.fill: parent;
                verticalAlignment: Text.AlignVCenter;
                horizontalAlignment: Text.AlignHCenter;
                text: "Guardar";
                font.pixelSize: 24;
                color: root.color_base_n2;
                font.bold: true;
            }
            MouseArea{
                anchors.fill: parent;
                onClicked: guardarConfig();
            }
        }
    }
    Item{
        id: barrera;
        visible: false;
        anchors.fill: parent;
        MouseArea{
            anchors.fill: parent;
            onClicked: {}
        }
    }
    onIniciar: {
        cargarDatos();
    }
    onFin: {
        qml_nuevoItem.destroy();
    }
    Component.onCompleted: iniciar();
    function mostrarMenu(){
        var pos_x = menu.x < 0 ? 0.85 : 0;
        menu.x = menu.x < 0 ? 0 : -(parent.width * 0.85);
    }
    function guardarConfig(){
        barrera.visible = true;
        Mensaje.esperar(root, "");
        app_manager.CUENTA.guardarConfig((rect_check.seleccionado ? 1 : 0), txt_servidor.text, qml_nuevoItem.tipo_peticion, function(status, msg){
            Mensaje.hide();
            barrera.visible = false;
            if(status != 1)
                Mensaje.error(root, msg);
            else {
                Mensaje.aviso(root, "Guardado ok")
                qml_nuevoItem.cargarDatos();
            }
        });
    }

    function cargarDatos(){
        qml_nuevoItem.tipo_peticion = app_manager.CUENTA.tipo_envio;
        rect_check.seleccionado = app_manager.CUENTA.enviar == 1 ? true : false;
        txt_servidor.text = app_manager.CUENTA.servidor;
    }
}