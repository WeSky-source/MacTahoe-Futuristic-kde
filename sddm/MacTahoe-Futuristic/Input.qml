import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: control
    placeholderTextColor: "#b3a08d"
    palette.text: "#f5f1ec"
    color: "#b3a08d"
    selectionColor: "#00d1da"
    font.pointSize: config.fontSize
    font.family: config.font
    width: parent.width

    background: Item {
        id: bg
        implicitHeight: 30

        Rectangle {
            anchors.bottom: parent.bottom
            width: bg.width
            height: 1
            color: Qt.rgba(0.961, 0.945, 0.925, 0.18)
        }
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: bg.width * 0.34
            height: 1
            color: "#00d1da"
        }
    }
}
