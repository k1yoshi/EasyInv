import QtQuick 2.7
import QtQuick.Controls 1.4

Rectangle
{
	id: qml_hora;
	height: 600;
	width: 400;
	z: 7000;
	property double t_base: height > width ? width : height;
	color: Qt.rgba(0.7, 0.7, 0.7, .7);

	signal cancelar;
	signal aceptar;
	signal selHora(string h, string m, string ampm);
	MouseArea
	{
		anchors.fill: parent;
		onClicked: {}
	}
	ListModel
	{
		id: model_horas;
		ListElement{display: "1"}
	}
	Rectangle
	{
		id: rec_hora;
		anchors.verticalCenter: parent.verticalCenter;
		anchors.horizontalCenter: parent.horizontalCenter;
		color: "white";
		height: t_base * .97;
		width: t_base * .97;
		Item 
		{
			anchors.top: parent.top;
			anchors.horizontalCenter: parent.horizontalCenter;
			height: parent.height * .8;
			width: parent.width;
			Component {
		        id: appHighlight
		        Rectangle { width: 80; height: 80; color: root.color_base_n5}//lightsteelblue
		    }
			Item
			{
				id: item_hora;
				height: parent.height;
				width: parent.width / 4;
				anchors.left: parent.left;
				anchors.leftMargin: parent.width * .1;
				clip: true;
				PathView
				{
					id: view_hora;
					highlight: appHighlight;
					preferredHighlightBegin: 0.5;
	        		preferredHighlightEnd: 0.5;
					width: parent.width;
	                height: parent.height;
					model: 12;
					pathItemCount: 3;
					delegate: Item {
						height: (rec_hora.height / 3);
						width: parent.width;
						Text
						{
							height: parent.height;
							width: parent.width;
							anchors.verticalCenter: parent.verticalCenter;
							anchors.horizontalCenter: parent.horizontalCenter;
							text: getHora(modelData+"");
							verticalAlignment: Text.AlignVCenter;
							horizontalAlignment: Text.AlignHCenter;
							font.pointSize: 16;
							color: root.color_base_n8;
						}
					}
					path: Path {
						startX: (view_hora.width / 2);
						startY: 0
						PathLine 
						{ 
							x: (view_hora.width / 2); 
							y: view_hora.height 
						}
					}
				}
				Rectangle
				{
					height: 1;
					width: parent.width * .9;
					anchors.horizontalCenter: parent.horizontalCenter;
					anchors.top: parent.top;
					anchors.topMargin: (rec_hora.height / 4);
					color: "#045FB4";
				}
				Rectangle
				{
					height: 1;
					width: parent.width * .9;
					anchors.horizontalCenter: parent.horizontalCenter;
					anchors.top: parent.top;
					anchors.topMargin: (rec_hora.height / 4) * 2.2;
					color: "#045FB4";
				}
			}
			Item
			{
				id: item_n1;
				height: parent.height;
				width: parent.width * .05;
				anchors.left: item_hora.right;
				anchors.verticalCenter: parent.verticalCenter;
				Text
				{
					height: t_base / 3;
					width: parent.width;
					text: ":";
					font.pointSize: 20;
					font.bold: true;
					anchors.horizontalCenter: parent.horizontalCenter;
					anchors.verticalCenter: parent.verticalCenter;
					horizontalAlignment: Text.AlignHCenter;
					verticalAlignment: Text.AlignVCenter;
					color: root.color_base_n8;
				}
			}
			Item
			{
				id: item_minutos;
				height: parent.height;
				width: parent.width / 4;
				anchors.left: item_n1.right;
				anchors.rightMargin: parent.width * .1;
				clip: true;
				PathView
				{
					id: view_minutos;
					highlight: appHighlight;
					preferredHighlightBegin: 0.5;
	        		preferredHighlightEnd: 0.5;
					width: parent.width;
	                height: parent.height;
					model: 60;
					pathItemCount: 3;
					delegate: Rectangle {
						height: t_base / 3;
						width: parent.width;
						color: Qt.rgba(0, 0, 0, 0);
						Text
						{
							anchors.fill: parent;
							anchors.verticalCenter: parent.verticalCenter;
							anchors.horizontalCenter: parent.horizontalCenter;
							text: getMinutos(modelData+"");
							verticalAlignment: Text.AlignVCenter;
							horizontalAlignment: Text.AlignHCenter;
							font.pointSize: 16;
							color: root.color_base_n8;

						}
					}
					path: Path {
						startX: (view_minutos.width / 2);
						startY: 0
						PathLine 
						{ 
							x: (view_minutos.width / 2); 
							y: view_minutos.height 
						}
					}
				}
				Rectangle
				{
					height: 1;
					width: parent.width * .9;
					anchors.horizontalCenter: parent.horizontalCenter;
					anchors.top: parent.top;
					anchors.topMargin: rec_hora.height / 4;
					color: "#045FB4";
				}
				Rectangle
				{
					height: 1;
					width: parent.width * .9;
					anchors.horizontalCenter: parent.horizontalCenter;
					anchors.top: parent.top;
					anchors.topMargin: (rec_hora.height / 4) * 2.2;
					color: "#045FB4";
				}
			}
			Item
			{
				id: item_n2;
				height: parent.height;
				width: parent.width * .05;
				anchors.left: item_minutos.right;
				anchors.verticalCenter: parent.verticalCenter;
				Text
				{
					height: t_base / 3;
					width: parent.width;
					text: ":";
					font.pointSize: 20;
					font.bold: true;
					anchors.horizontalCenter: parent.horizontalCenter;
					anchors.verticalCenter: parent.verticalCenter;
					horizontalAlignment: Text.AlignHCenter;
					verticalAlignment: Text.AlignVCenter;
					color: root.color_base_n8;
				}
			}
			Item
			{
				id: item_ampm;
				height: parent.height;
				width: parent.width / 5;
				anchors.right: parent.right;
				anchors.rightMargin: parent.width * .1;
				clip: true;
				PathView
				{
					id: view_ampm;
					highlight: appHighlight;
					preferredHighlightBegin: 0.5;
	        		preferredHighlightEnd: 0.5;
					width: parent.width;
	                height: parent.height;
					model: 3;
					pathItemCount: 3;
					delegate: Rectangle {
						height: t_base / 3;
						width: parent.width;
						color: Qt.rgba(0, 0, 0, 0);
						Text
						{
							anchors.fill: parent;
							anchors.verticalCenter: parent.verticalCenter;
							anchors.horizontalCenter: parent.horizontalCenter;
							text: getAmPm(modelData+"");
							verticalAlignment: Text.AlignVCenter;
							horizontalAlignment: Text.AlignHCenter;
							font.pointSize: 16;
							color: root.color_base_n8;

						}
					}
					path: Path {
						startX: (view_ampm.width / 2);
						startY: 0
						PathLine 
						{ 
							x: (view_ampm.width / 2); 
							y: view_ampm.height 
						}
					}
				}
				Rectangle
				{
					height: 1;
					width: parent.width * .9;
					anchors.horizontalCenter: parent.horizontalCenter;
					anchors.top: parent.top;
					anchors.topMargin: rec_hora.height / 4;
					color: "#045FB4";
				}
				Rectangle
				{
					height: 1;
					width: parent.width * .9;
					anchors.horizontalCenter: parent.horizontalCenter;
					anchors.top: parent.top;
					anchors.topMargin: (rec_hora.height / 4) * 2.2;
					color: "#045FB4";
					//color: root.color_base_n5;
				}
			}
		}
		Rectangle
		{
			anchors.bottom: item_abajo.top;
			color: root.color_base_n6;
			height: 1;
			width: parent.width;
		}
		Item
		{
			id: item_abajo;
			anchors.bottom: parent.bottom;
			height: parent.height * .2;
			width: parent.width;
			Text
			{
				anchors.left: parent.left;
				height: parent.height;
				width: parent.width / 2;
				text: "Cancelar";
				verticalAlignment: Text.AlignVCenter;
				horizontalAlignment: Text.AlignHCenter;
				font.pointSize: 16;
				color: root.color_base_n8;
				MouseArea
				{
					anchors.fill: parent;
					onClicked: qml_hora.cancelar();
				}
			}
			Rectangle
			{
				anchors.horizontalCenter: parent.horizontalCenter;
				color: root.color_base_n6;
				height: parent.height;
				width: 1;
			}
			Text
			{
				anchors.right: parent.right;
				height: parent.height;
				width: parent.width / 2;
				text: "Aceptar";
				verticalAlignment: Text.AlignVCenter;
				horizontalAlignment: Text.AlignHCenter;
				font.pointSize: 16;
				color: root.color_base_n8;
				MouseArea
				{
					anchors.fill: parent;
					onClicked: qml_hora.aceptar();
				}
			}
		}
	}
	
	onCancelar:
	{
		qml_hora.destroy();
	}
	onAceptar:
	{
		var hora_24 = getHora(view_hora.currentIndex);
		selHora(hora_24, getMinutos(view_minutos.currentIndex), getAmPm(view_ampm.currentIndex));
		cancelar();
	}

	function getHora(modelData)
	{
		modelData = modelData * 1;
		modelData += 1;
		modelData = ""+modelData;
		if(modelData.length== 1)
			return "0"+(modelData );
		return modelData;
	}
	function getMinutos(modelData)
	{
		modelData = ""+modelData;
		if(modelData.length== 1)
			return "0"+(modelData );
		return modelData;
	}
	function getAmPm(modelData)
	{
		var ampm = ["am", "pm", "am"];
		return ampm[modelData];
	}
}