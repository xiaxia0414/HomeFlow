import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 800
    height: 480
    visible: true
    title: qsTr("Hello World")

    // DynamicBackround
    // {
    //     anchors.fill: parent
    // }

    HomeFlow
    {
        anchors.fill: parent

    }


}
