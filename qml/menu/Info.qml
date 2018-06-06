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
    id: qml_info;
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
                    text: "Version";
                    font.pixelSize: 21;
                    font.family: root.fuente;
                    color: root.color_base_n8;
                }
            }
            Item{
                anchors.bottom: parent.bottom;
                height: parent.height * .7;
                width: parent.width;
                clip: true;
                Text{
                    horizontalAlignment: Text.AlignLeft;
                    verticalAlignment: Text.AlignVCenter;
                    height: parent.height;
                    width: parent.width;
                    wrapMode: Text.WordWrap;
                    text: "   1.0";
                    font.pixelSize: 21;
                    font.family: root.fuente;
                    color: root.color_base_n3;
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
                    text: "Nombre Desarrolador";
                    font.pixelSize: 21;
                    font.family: root.fuente;
                    color: root.color_base_n8;
                }
            }
            Item{
                anchors.bottom: parent.bottom;
                height: parent.height * .7;
                width: parent.width;
                clip: true;
                Text{
                    horizontalAlignment: Text.AlignLeft;
                    verticalAlignment: Text.AlignVCenter;
                    height: parent.height;
                    width: parent.width;
                    wrapMode: Text.WordWrap;
                    text: "   Juan Gabriel Fernandez More";
                    font.pixelSize: 21;
                    font.family: root.fuente;
                    color: root.color_base_n3;
                }
            }
        }
        Item{
            id: rg_n3;
            anchors.top: rg_n2.bottom;
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
                    text: "E-mail Desarrolador";
                    font.pixelSize: 21;
                    font.family: root.fuente;
                    color: root.color_base_n8;
                }
            }
            Item{
                anchors.bottom: parent.bottom;
                height: parent.height * .7;
                width: parent.width;
                clip: true;
                Text{
                    horizontalAlignment: Text.AlignLeft;
                    verticalAlignment: Text.AlignVCenter;
                    height: parent.height;
                    width: parent.width;
                    wrapMode: Text.WordWrap;
                    text: "   kiyoshi.gf@gmail.com";
                    font.pixelSize: 21;
                    font.family: root.fuente;
                    color: root.color_base_n3;
                }
            }
        }
    }

    Item {
        id: footer;
        anchors.left: menu.right;
        anchors.bottom: parent.bottom;
        width: parent.width;
        height: parent.height * .12;
    }
    onIniciar: {
        
    }
    onFin: {
        qml_info.destroy();
    }
    Component.onCompleted: iniciar();
    function mostrarMenu(){
        var pos_x = menu.x < 0 ? 0.85 : 0;
        menu.x = menu.x < 0 ? 0 : -(parent.width * 0.85);
    }
}