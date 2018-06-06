import QtQuick 2.2
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

import "../MyComponents"
import "../MyComponents/js/mensajes.js" as Mensaje
import "../../js/db.js" as Db
import "../../js/util.js" as Util
import "../";

Rectangle
{
    id: qml_header;
    property string id_app: "otro";
    height: 50;
    width: 315;
    color: root.color_base_n1

    property string titulo: "EasyInv"; 
    property string titulo_atras: "Atras";
    property int add_btn: 1;

    signal back;
    signal nuevo;
    signal menu;

    Item
    {
        id: item_n1;
        anchors.top: parent.top;
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
        Text
        {
            id: txt_padre;
            anchors.left: back_secciones.right;
            width: parent.width * 0.6;
            height: parent.height;
            color: "#fff";
            font.bold: false;
            font.pointSize: 14;
            verticalAlignment: Text.AlignVCenter
            text: titulo_atras;
        }
        MouseArea
        {
            anchors.fill: parent;
            onClicked: back();
        }
    }   
    Item
    {
        anchors.horizontalCenter: parent.horizontalCenter;
        height: parent.height;
        width: parent.width * 0.6;
        Text
        {
            id: txt_titulo;
            anchors.fill: parent;
            color: "#fff";
            text: titulo.toUpperCase();
            font.family: root.fuente;
            font.pointSize: 16;
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter;
            //text: "Novena";
        }
    }
    Rectangle{
        anchors.right: btn_menu.left;
        anchors.rightMargin: parent.width * .01;
        anchors.verticalCenter: parent.verticalCenter;
        height: parent.height * .72;
        width: height;
        radius: height * .5;
        color: Qt.rgba(0,0,0,0);
        border.color: "#fff";
        border.width: 1;
        Text{
            anchors.fill: parent;
            verticalAlignment: Text.AlignVCenter;
            horizontalAlignment: Text.AlignHCenter;
            text: "+";
            font.pixelSize: 24;
            color: "white";
            font.bold: true;
        }
        MouseArea{
            anchors.fill: parent;
            onClicked: nuevo();
        }
    }
    BtnMenu{
        id: btn_menu;
        anchors.right: parent.right;
        anchors.rightMargin: parent.width * .01;
        anchors.verticalCenter: parent.verticalCenter;
        height: parent.height * .72;
        width: height;
        color_border: "#fff";
        color_texto: "#fff";
        MouseArea{
            anchors.fill: parent;
            onClicked: menu();
        }
    }
}