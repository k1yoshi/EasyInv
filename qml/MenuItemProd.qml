import QtQuick 2.6
import "MyComponents/js/mensajes.js" as Mensaje

Rectangle{
	id: qml_menuItemProd;
	height: 600;
	width: 400;
	color: Qt.rgba(0,0,0, .5);
	visible: false;

	property string text_op_eliminar: "Eliminar Registro";
	property string text_op_nuevo: "Agregar debajo";
	property int nIndex: -1;
	property string titulo_ventanas: "";
	property string clase: "";

	signal eliminar(int status, string msg);
	signal agregarDebajo(int status, string msg);
	signal nuevoProducto(int id_prod);

	MouseArea{
		anchors.fill: parent;
		onClicked: qml_menuItemProd.destroy();
	}
	Rectangle{
		id: rect_cont;
		anchors.verticalCenter: parent.verticalCenter;
		anchors.horizontalCenter: parent.horizontalCenter;
		height: parent.height * .42;
		width: parent.width * .9;
		color: "#fff";
		radius: height * .03;

		property double alto_btn: .6;
		property string color_border: "#c9c9c9";
		property string color_texto: "#515151";
		property int pixelSize: 24;
		Item{
			id: item_n1;
			anchors.top: parent.top;
			height: parent.height / 2;
			width: parent.width;
			Rectangle{
				anchors.verticalCenter: parent.verticalCenter;
				anchors.horizontalCenter: parent.horizontalCenter;
				height: parent.height * rect_cont.alto_btn;
				width: parent.width * .9;
				color: Qt.rgba(0,0,0,0);
				border.color: rect_cont.color_border;
				border.width: 1;
				radius: height * .09;
				Text{
					anchors.fill: parent;
					text: qml_menuItemProd.text_op_eliminar
					font.pixelSize: rect_cont.pixelSize;
					verticalAlignment: Text.AlignVCenter;
					horizontalAlignment: Text.AlignHCenter;
					color: rect_cont.color_texto;
				}
				MouseArea{anchors.fill: parent; onClicked: eliminarRegistro();}
			}
		}
		Item{
			anchors.top: item_n1.bottom;
			height: parent.height / 2;
			width: parent.width;
			Rectangle{
				anchors.verticalCenter: parent.verticalCenter;
				anchors.horizontalCenter: parent.horizontalCenter;
				height: parent.height * rect_cont.alto_btn;
				width: parent.width * .9;
				color: Qt.rgba(0,0,0,0);
				border.color: rect_cont.color_border;
				border.width: 1;
				radius: height * .09;
				Text{
					anchors.fill: parent;
					text: qml_menuItemProd.text_op_nuevo
					font.pixelSize: rect_cont.pixelSize;
					verticalAlignment: Text.AlignVCenter;
					horizontalAlignment: Text.AlignHCenter;
					color: rect_cont.color_texto;
				}
				MouseArea{anchors.fill: parent; onClicked: agregarRegistro();}
			}
		}
	}
	onNuevoProducto: {
        drinkventario.PRODUCTOS.agregarEnPosicion(id_prod, (nIndex+1), qml_menuItemProd.agregarDebajo);
    }
	function eliminarRegistro(){
		var nombre_reg = drinkventario[clase].getModel().get(nIndex).nombre;
		Mensaje.confirmar(root, "Confirma eliminar el "+titulo_ventanas+" " + nombre_reg, function(status, value){
			if(!status){
				qml_menuItemProd.eliminar(0, "Se cancelo la operacion");
			} else {
				drinkventario[clase].eliminarRegistro(qml_menuItemProd.nIndex, qml_menuItemProd.eliminar);
			}
		});
	}
	function agregarRegistro(){
        var component = Qt.createComponent('productos/NuevaBotella.qml'), nueva_bot;
        if(component.status == Component.Ready)
        {
            nueva_bot = component.createObject(root);
            nueva_bot.height = root.height;
            nueva_bot.width = root.width;
            nueva_bot.mostrarDirecto();
            nueva_bot.visible = true;
            nueva_bot.nuevoProducto.connect(qml_menuItemProd.nuevoProducto);
        }
        return nueva_bot;
    }

	onEliminar: {
		if(status == 1){
			qml_menuItemProd.destroy();
		} else {
			//qml_menuItemProd.destroy();
			Mensaje.error(root, msg)
		}
	}
	onAgregarDebajo: {
		if(status == 1){
			qml_menuItemProd.destroy();
		} else {
			//qml_menuItemProd.destroy();
			Mensaje.error(root, msg)
		}
	}
}