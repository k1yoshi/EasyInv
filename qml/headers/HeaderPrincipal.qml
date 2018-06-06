import QtQuick 2.2
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

import "../MyComponents"
import "../MyComponents/js/mensajes.js" as Mensaje
import "../../js/db.js" as Db
import "../../js/util.js" as Util

Rectangle
{
    id: qml_header;
    property string id_app: "otro";
    height: 50;
    width: 315;
    color: root.color_base_n1;

    property string titulo: "EasyInv"; 

    signal menu;
    signal add;

    Row
    {
    	anchors.fill: parent;
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
    		MouseArea { anchors.fill: parent; onClicked: menu(); }
    	}	
        Item
        {
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
    	Item
    	{
    		height: parent.height;
    		width: parent.width * 0.2;
            Image {
                height: parent.height * 0.7;
                width: parent.width * 0.4;
                source: "../../src/img/addbut.png";
                anchors.verticalCenter: parent.verticalCenter;
                anchors.horizontalCenter: parent.horizontalCenter;
            }
    		MouseArea { anchors.fill: parent; onClicked: add(); }
    	}
    }
}