import QtQuick 2.2
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

import "../MyComponents"
import "../MyComponents/js/mensajes.js" as Mensaje
import "../../js/db.js" as Db
import "../../js/util.js" as Util

Item
{
    id: qml_footer;

    property string text_orden: Db.ORDEN;

    height: 50;
    width: 315;

    signal orden;
    signal info;
    signal inventariar;
    
    Image {
        anchors.fill: parent;
        source: "../../src/img/barrabot.png";
    }
    Row
    {
        anchors.fill: parent;
        Item
        {
            height: parent.height;
            width: parent.width * 0.4;
            Item {
                id: img_guardar;
                height: parent.height;
                width: parent.width * 0.4;
                Image {
                    height: parent.height * 0.7;
                    width: parent.width * 0.5;
                    source: "../../src/img/iconorder.png";
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.horizontalCenter: parent.horizontalCenter;
                }
            }
            Text{
                anchors.left: img_guardar.right;
                height: parent.height;
                width: parent.width * 0.7;
                color: "#fff";
                font.pointSize: 16;
                font.family: root.fuente;
                verticalAlignment: Text.AlignVCenter
                text: text_orden;
            }
            MouseArea
            {
                anchors.fill: parent;
                onClicked: orden();
            }
        }   
        Item
        {
            //color: "red";
            height: parent.height;
            width: parent.width * 0.2;
            Image {
                height: parent.height * 0.8;
                width: parent.width * 0.5;
                source: "../../src/img/info-icon.png";
                anchors.verticalCenter: parent.verticalCenter;
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            MouseArea
            {
                anchors.fill: parent;
                onClicked: info();
            }
        }
        Item
        {
            height: parent.height;
            width: parent.width * 0.4;
            Text{
                id: txt_inv;
                height: parent.height;
                width: parent.width * 0.7;
                color: "#fff";
                font.pointSize: 16;
                font.family: root.fuente;
                verticalAlignment: Text.AlignVCenter;
                horizontalAlignment: Text.AlignRight;
                text: Db.INVENTARIAR;
            }
            Item {
                id: img_guardar2;
                anchors.left: txt_inv.right;
                height: parent.height;
                width: parent.width * 0.3;
                Image {
                    height: parent.height * 0.7;
                    width: parent.width * 0.5;
                    source: "../../src/img/iconinvent.png";
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.right: parent.right;
                }
            }
            MouseArea
            {
                anchors.fill: parent;
                onClicked: inventariar();
            }
        }
    }
}