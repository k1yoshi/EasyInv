import QtQuick 2.6
Rectangle 
{
    id: btn;

	property color background;
	property color background_hover;
	property color background_pressed;
	property alias background_image: img.source;
	property int background_width;
	property int background_height;
	property alias text: txt.text;
	property alias font_color: txt.color;
	property alias font_size: txt.font.pointSize;
	property alias font_pixel: txt.font.pixelSize;
	property alias font_bold: txt.font.bold;
	property alias imageString: img.source
	property alias av: txt.verticalAlignment;
	property alias ah: txt.horizontalAlignment;

    color: background;
	property string icon_img  : ""
	signal clicked
    Image 
	{
		id: img
		source: "";
		smooth: true
		width: background_width;
		height: background_height;
		fillMode: Image.PreserveAspectFit;
		anchors.verticalCenter: parent.verticalCenter
		anchors.horizontalCenter: parent.horizontalCenter
		asynchronous: true		
	}
	Text 
	{
		id: txt;
		anchors.horizontalCenter: parent.horizontalCenter;
		anchors.verticalCenter: parent.verticalCenter;
		verticalAlignment: Text.AlignVCenter
	    horizontalAlignment: Text.AlignHCenter
	    //horizontalAlignment: Text.AlignRight
		width: parent.width;
		color: "#fff";
		text: "";
		font.bold: false;
		font.pointSize: 16;
		wrapMode: TextEdit.WordWrap;
	}

	MouseArea 
	{
        anchors.fill: parent;
        onClicked: btn.clicked();
        onEntered: 
        {
        	if(background_hover != "#000000")
        		btn.color = background_hover;
        }
	    onExited:
	    {
	    	if(background != "#000000")
	    		btn.color = background;
	    }
	    onPressed: 
	    {
	    	if(background_pressed != "#000000")
	    		btn.color = background_pressed;
	    }
	    onReleased: 
	    {
	    	if(background_hover != "#000000")
	    		btn.color = background_hover;
	    	else if(background_pressed != "#000000")
	    		btn.color = background;
	    }
	}			
}
