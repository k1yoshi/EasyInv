import QtQuick 2.2;

Rectangle{
	id: qml_getCant;
	signal aceptar(double cantidad);

	property double cant: 0.000;

	color: Qt.rgba(0,0,0,.5);
	height: 600;
	width: 400;
	//visible: false;

	MouseArea{
		anchors.fill: parent;
		onClicked: {qml_getCant.destroy();}
	}

	Rectangle{
		anchors.verticalCenter: parent.verticalCenter;
		anchors.horizontalCenter: parent.horizontalCenter;
		height: parent.height * .42;
		width: parent.width * .81;
		radius: height * .06;
		Item{
			anchors.top: parent.top;
			height: parent.height - r2.height;
			width: parent.width;
			Rectangle{
				anchors.verticalCenter: parent.verticalCenter;
				anchors.horizontalCenter: parent.horizontalCenter;
				height: parent.height * .81;
				width: parent.width * .9;
				border.width: 1;
				border.color: root.color_base_n10;
				radius: height * .12;
				clip: true;
				TextInput{
					id: txt_cant;
					anchors.verticalCenter: parent.verticalCenter;
					anchors.horizontalCenter: parent.horizontalCenter;
					height: parent.height * .96;
					width: parent.width * .96;
					text: cant;
					verticalAlignment: TextInput.AlignVCenter;
					horizontalAlignment: TextInput.AlignHCenter;
					font.pixelSize: 72;
					color: root.color_base_n7;
					inputMethodHints: Qt.ImhPreferNumbers;
				}
			}
			
		}
		Item{
			id: r2;
			anchors.bottom: parent.bottom;
			height: parent.height * .36;
			width: parent.width;

			Rectangle{height: 1; width: parent.width; color: root.color_base_n10;}
	        Rectangle{
				anchors.verticalCenter: parent.verticalCenter;
				anchors.right: parent.right;
				anchors.rightMargin: parent.width * .03;
				height: parent.height * .72;
				width: parent.width * .36;
				radius: height * .12;
				color: Qt.rgba(0,0,0,0);
				border.color: root.color_base_n1;
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
					onClicked: guardar();
				}
			}
		}
	}
	function guardar(){
		cant = txt_cant.text;
		aceptar(cant);
		qml_getCant.destroy();
	}
}