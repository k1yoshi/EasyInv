import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle
{
	id: sel_fecha;
	height: 600;
	width: 400;
	z: 7000;
	property alias selectedDate: calendario.selectedDate;
	signal selFecha(string anio, string mes, string dia);

	property double t_base: height > width ? width : height;
	color: Qt.rgba(0.7, 0.7, 0.7, .7);
	MouseArea
	{
		anchors.fill: parent;
		onClicked: sel_fecha.destroy();
	}
	Calendar 
	{
		id: calendario;
		anchors.verticalCenter: parent.verticalCenter;
		anchors.horizontalCenter: parent.horizontalCenter;
		height: t_base * .97;
		width: t_base * .97;
	    weekNumbersVisible: false
	    navigationBarVisible: true;
	    frameVisible: true;
	    onClicked: 
	    {
	    	var dia = date.getDate()+"", mes = (date.getMonth() + 1)+"", anio = date.getFullYear()+"";
			if(mes.length == 1)
				mes = "0"+mes+"";
			if(dia.length == 1)
				dia = "0"+dia+"";
			selFecha(anio, mes, dia);
			sel_fecha.destroy();
	    }
	}
}