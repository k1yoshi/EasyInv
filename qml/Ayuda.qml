import QtQuick 2.1
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

import "MyComponents"
import "MyComponents/js/mensajes.js" as Mensaje
import "../js/db.js" as Db
import "../js/util.js" as Util

Image {
	id: qml_ayuda;
	height: 600;
    width: 400;

    MouseArea{
        anchors.fill: parent;
        onClicked: {
            qml_ayuda.destroy();
        }
    }
}