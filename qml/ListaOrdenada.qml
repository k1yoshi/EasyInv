import QtQuick 2.2
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4

import "MyComponents"
import "MyComponents/js/mensajes.js" as Mensaje
import "../js/db.js" as Db
import "../js/util.js" as Util

import "delegates"

Rectangle
{
	id: qml_lstOrdenada;
    height: 532;
    width: 315;
	color: "#fff";

    property bool modo_ordenar: false
    property alias model: starwarsList.model;
    property alias item_delegate: starwarsList.delegate;
    property alias lst: starwarsList;
    property int spacing: 0;

    signal setOrdenar(bool ordenar);
    signal mover(int nIndex, int nIndex2);

    onModo_ordenarChanged: {
        setOrdenar(modo_ordenar);
    }
    onMover: {
        starwarsList.model.move(nIndex, nIndex2, 1);
    }

	ScrollView 
    {
        width: parent.width;
        height: parent.height;
        flickableItem.interactive: true;
        
        ListView 
        {
            id: starwarsList;
            boundsBehavior: Flickable.StopAtBounds;
            anchors.fill: parent
            model: qml_lstOrdenada.model;
            spacing: qml_lstOrdenada.spacing;
        }
        style: ScrollViewStyle {
            transientScrollBars: true
            handle: Item {
                implicitWidth: 14
                implicitHeight: 26
                Rectangle {
                    color: "#000";//"#424246"
                    anchors.fill: parent
                    anchors.topMargin: 6
                    anchors.leftMargin: 4
                    anchors.rightMargin: 4
                    anchors.bottomMargin: 6
                }
            }
            scrollBarBackground: Item {
                implicitWidth: 14
                implicitHeight: 26
            }
        }
    }
    
}