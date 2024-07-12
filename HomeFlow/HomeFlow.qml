import QtQuick 2.15
import QtQuick 2.0
import QtQuick.Controls 2.15
 import QtGraphicalEffects 1.15

Rectangle {

    id: root;
    property ListModel model
    property int itemCount: 5
    property  color backgroundColor: "#F9F9FB"
    property color accnetColor: "#5781F3"

    DynamicClock
    {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 50
        z:99
    }


    color:backgroundColor
    Component {
        id: rectDelegate;

        Item {
            width: 150;
            height: 150;
            id: wrapper;
            property int shadowR: 6
           //property color shadowC:
            z: PathView.z;
            opacity: PathView.itemAlpha;
            scale: PathView.itemScale
            state: wrapper.PathView.isCurrentItem ?"current" : "nocurrent";
            property  string s : info
            Rectangle {
                id:rect1
                width: 120
                height: 120
                anchors.centerIn: parent
                color: "white"
                border.width: 2;
                radius: 10
                clip: true
                //border.color: wrapper.PathView.isCurrentItem ?"black" : "lightgray";
                Image {
                    anchors.centerIn: parent
                    width: 100
                    height: 100
                    id: image
                    source: url
                }
                layer.enabled: true
                layer.effect:DropShadow
                {
                    id:shadow
                    transparentBorder: true
                    horizontalOffset: 0
                    verticalOffset: 0
                    radius: wrapper.shadowR
                    color: "#c4c4c4"		//argb
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        console.log(index)
                        console.log(pathView.currentIndex)
                        var step = Math.abs(pathView.currentIndex-index);
                        var d = pathView.currentIndex-index;
                        if(step == 0)
                        {

                        }
                        while(step--)
                        {
                            if(d<0)
                            {
                                pathView.incrementCurrentIndex()
                            }
                            else
                            {
                                pathView.decrementCurrentIndex()
                            }
                        }

                    }
                }

            }

            states: [
                        State {
                            name: "current"
                            PropertyChanges {
                                target:rect1;
                                border.color:accnetColor
                            }
                            PropertyChanges {
                                target:wrapper;
                                shadowR: 12
                            }

                        },
                        State {
                            name: "nocurrent"
                            PropertyChanges {
                                target:rect1;
                                border.color:"gray"
                            }
                            PropertyChanges {
                                target:wrapper;
                                shadowR: 6
                            }
                        }
                    ]
            transitions: [
                        Transition {
                        from: "*"; to: "*"
                            PropertyAnimation { target: rect1; properties: "border.color"; duration: 200 }
                            PropertyAnimation { target:wrapper ; properties: "shadowR"; duration: 300 }
                    }
                    ]

        }
    }
    PathView {
        id: pathView;
        anchors.fill: parent;
        //interactive: true;
        pathItemCount: itemCount;
        preferredHighlightBegin: 0.5;
        preferredHighlightEnd: 0.5;
        //highlightRangeMode: PathView.StrictlyEnforceRange;
        delegate: rectDelegate;
        model: ListModel{
            id:model
            ListElement{url:"qrc:/image/1.svg"
            info:"11111"
            }
            ListElement{url:"qrc:/image/2.svg"
            info:"22222"
            }
            ListElement{url:"qrc:/image/3.svg"
            info:"33333"
            }
            ListElement{url:"qrc:/image/4.svg"
            info:"44444"}
            ListElement{url:"qrc:/image/5.svg"
            info:"55555"
            }
        }
        path:Path {
            startX: 0;
            startY:pathView.height/2 ;
            PathAttribute { name: "z"; value: 0 }
            PathAttribute { name: "itemAlpha"; value: 1.0 }
            PathAttribute { name: "itemScale"; value: 0.6 }
            PathLine { x: pathView.width/2; y:pathView.height/2; }
            PathAttribute { name: "z"; value: 10 }
            PathAttribute { name: "itemAlpha"; value: 1.0 }
            PathAttribute { name: "itemScale"; value: 1.2 }
            PathLine { x: pathView.width; y: pathView.height/2; }
            PathAttribute { name: "z"; value: 0 }
            PathAttribute { name: "itemAlpha"; value: 1.0 }
            PathAttribute { name: "itemScale"; value: 0.6 }
            PathPercent{value:1.0}
        }
        focus: true;
        Keys.onLeftPressed: decrementCurrentIndex();
        Keys.onRightPressed: incrementCurrentIndex();
        Label {
            id: lable
            y: pathView.height/2+80;
            anchors.left: pathView.currentItem.left;
            anchors.right:  pathView.currentItem.right;
            height: 20
            font.pointSize: 15
            horizontalAlignment: Text.AlignHCenter//(1)
            verticalAlignment: Text.AlignVCenter//(2)
            text: pathView.currentItem.s
            color: accnetColor

        }
    }
    Rectangle
    {
        id:leftRect
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width/3
        color: "transparent"
        LinearGradient {//线性梯度渐变
                anchors.fill: parent//填充父类
                start: Qt.point(0, 0)//起始点
                end: Qt.point(leftRect.width,0)//结束点
                gradient: Gradient {//线性渐变
                    GradientStop { position: 0.0; color: backgroundColor }
                    GradientStop { position: 1.0; color: "transparent" }
                }
            }
        RoundButton
        {
            anchors.left: parent.left;
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 50
            width: 50;
            height: 50;
            onClicked:
            {
                pathView.decrementCurrentIndex();
            }
        }
    }
    Rectangle
    {
        id:rightRect
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width/3
        color: "transparent"
        LinearGradient {//线性梯度渐变
                anchors.fill: parent//填充父类
                start: Qt.point(rightRect.width,0 )//起始点
                end: Qt.point(0,0)//结束点
                gradient: Gradient {//线性渐变
                    GradientStop { position: 0.0; color: backgroundColor }
                    GradientStop { position: 1.0; color: "transparent" }
                }
            }
        RoundButton
        {
            anchors.right: parent.right;
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 50
            width: 50;
            height: 50;
            onClicked:
            {
                pathView.incrementCurrentIndex();
            }
        }
    }
}
