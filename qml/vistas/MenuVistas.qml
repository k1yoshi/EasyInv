import QtQuick 2.2;

Rectangle{
	id: qml_menuVistas;
	signal selVista(int vista);

	property double cant: 0.000;

	color: Qt.rgba(0,0,0,.5);
	height: 600;
	width: 400;
	//visible: false;

	MouseArea{
		anchors.fill: parent;
		onClicked: {qml_menuVistas.destroy();}
	}

	Rectangle{
		anchors.verticalCenter: parent.verticalCenter;
		anchors.horizontalCenter: parent.horizontalCenter;
		height: parent.height * .42;
		width: parent.width * .81;
		radius: height * .06;
		
		Item{
			id: r1;
			anchors.top: parent.top;
			height: parent.height / 3;
			width: parent.width;
	        Rectangle{
				anchors.verticalCenter: parent.verticalCenter;
				anchors.horizontalCenter: parent.horizontalCenter;
				height: parent.height * .72;
				width: parent.width * .96;
				radius: height * .12;
				color: Qt.rgba(0,0,0,0);
				border.color: root.color_base_n3;
				border.width: 1;
				Text{
					anchors.fill: parent;
					verticalAlignment: Text.AlignVCenter;
					horizontalAlignment: Text.AlignHCenter;
					text: "Vista Lista Resumen";
					font.pixelSize: 24;
					color: root.color_base_n3;
					font.bold: true;
				}
				MouseArea{
					anchors.fill: parent;
					onClicked: {bloquear.visible = true; selVista(1); qml_menuVistas.destroy();}
				}
			}
		}
		Item{
			id: r2;
			anchors.top: r1.bottom;
			height: parent.height / 3;
			width: parent.width;
	        Rectangle{
				anchors.verticalCenter: parent.verticalCenter;
				anchors.horizontalCenter: parent.horizontalCenter;
				height: parent.height * .72;
				width: parent.width * .96;
				radius: height * .12;
				color: Qt.rgba(0,0,0,0);
				border.color: root.color_base_n3;
				border.width: 1;
				Text{
					anchors.fill: parent;
					verticalAlignment: Text.AlignVCenter;
					horizontalAlignment: Text.AlignHCenter;
					text: "Vista Lista Grupo";
					font.pixelSize: 24;
					color: root.color_base_n3;
					font.bold: true;
				}
				MouseArea{
					anchors.fill: parent;
					onClicked: {bloquear.visible = true; selVista(2); qml_menuVistas.destroy();}
				}
			}
		}
		Item{
			id: r3;
			anchors.top: r2.bottom;
			height: parent.height / 3;
			width: parent.width;

	        Rectangle{
				anchors.verticalCenter: parent.verticalCenter;
				anchors.horizontalCenter: parent.horizontalCenter;
				height: parent.height * .72;
				width: parent.width * .96;
				radius: height * .12;
				color: Qt.rgba(0,0,0,0);
				border.color: root.color_base_n3;
				border.width: 1;
				Text{
					anchors.fill: parent;
					verticalAlignment: Text.AlignVCenter;
					horizontalAlignment: Text.AlignHCenter;
					text: "Vista Grupo Grid";
					font.pixelSize: 24;
					color: root.color_base_n3;
					font.bold: true;
				}
				MouseArea{
					anchors.fill: parent;
					onClicked: {bloquear.visible = true; selVista(3); qml_menuVistas.destroy();}
				}
			}
		}

		Item{
			id: bloquear;
			visible: false;
			anchors.fill: parent;
			MouseArea{anchors.fill: parent; onClicked: {}}
		}
	}
	
}