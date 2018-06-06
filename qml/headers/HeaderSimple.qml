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
    color: root.color_base_n1;

    property string titulo: "EasyInv"; 
    property string titulo_atras: "Atras";
    property bool ver_menu: false;

    signal back;
    signal nuevo;
    signal menu;

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
    		BtnMenu{
                anchors.verticalCenter: parent.verticalCenter;
                anchors.rightMargin: parent.width * .03;
    			anchors.right: parent.right;
    			height: parent.height * .72;
    			width: height;
                visible: ver_menu;
	            MouseArea{
	            	anchors.fill: parent;
	            	onClicked: menu();
	            }
    		}
       	}
    }
}