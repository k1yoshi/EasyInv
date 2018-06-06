import QtQuick 2.6
Rectangle{
	id: item_delegate;

	height: 90;
	width: 400;	

	property bool modo_ordenar;
	property ListView lst;

	signal setOrdenar(bool ordenar);
	signal mover(int nIndex, int nIndex2);

	Item{
		id: item_orden;
		anchors.fill: parent;
		visible: modo_ordenar;
		z: modo_ordenar ? 9 : 0;
		Text
	    {
	        height: parent.height;
	        width: 40;
	        font.pointSize: 20;
	        text: "-";
	        color: "red";
	        verticalAlignment: Text.AlignVCenter
	        horizontalAlignment: Text.AlignHCenter;
	    }
	    Item
	    {
	    	anchors.verticalCenter: parent.verticalCenter;
	    	anchors.horizontalCenter: parent.horizontalCenter;
	        width: parent.width * .8;
	        height: parent.height;
	        MouseArea 
	        {
	            id: dragArea
	            anchors.fill: parent
	            property int positionStarted: 0
	            property int positionEnded: 0
	            property int positionsMoved: Math.floor((positionEnded - positionStarted)/item_delegate.height)
	            property int newPosition: index + positionsMoved
	            property bool held: false
	            drag.axis: Drag.YAxis
	            //onPressAndHold: 
	            onPressed:
	            {
	                item_delegate.z = 2;
                    positionStarted = item_delegate.y;
                    dragArea.drag.target = item_delegate;
                    item_delegate.opacity = 0.5;
                    lst.interactive = false;
                    held = true;
                    drag.maximumY = (lst.height - item_delegate.height - 1 + lst.contentY);
                    drag.minimumY = 0;
	            }
	            onPositionChanged: 
	            {
	                positionEnded = item_delegate.y;
	            }
	            onReleased: 
	            {
	            	item_delegate.opacity = 1;
	                if (Math.abs(positionsMoved) < 1 && held == true) 
	                {
	                    item_delegate.y = positionStarted;
	                    lst.interactive = true;
	                    dragArea.drag.target = null;
	                    held = false;
	                } else {
	                    if (held == true) {
	                        if (newPosition < 1) {
	                            item_delegate.z = 1;
	                            mover(index,0);
	                            lst.interactive = true;
	                            dragArea.drag.target = null;
	                            held = false;
	                        } else if (newPosition > lst.count - 1) {
	                            item_delegate.z = 1;
	                            mover(index,lst.count - 1);
	                            lst.interactive = true;
	                            dragArea.drag.target = null;
	                            held = false;
	                        }
	                        else {
	                            item_delegate.z = 1;
	                            mover(index,newPosition);
	                            lst.interactive = true;
	                            dragArea.drag.target = null;
	                            held = false;
	                        }
	                        //cambioOrden();
	                    }
	                }
	            }
	        }
	    }
	    Text
	    {
	        height: parent.height;
	        width: 40;
	        font.pointSize: 20;
	        text: ":::  ";
	        color: "red";
	        verticalAlignment: Text.AlignVCenter
	        horizontalAlignment: Text.AlignHCenter;
	    }
	}
	onSetOrdenar: {
		modo_ordenar = ordenar;
	}
	Rectangle{
		anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottom: parent.bottom;
        height: 1;
        width: parent.width * .96;
        color: root.color_base_n10;
    }

}