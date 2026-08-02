import QtQuick 2.15
import Qt5Compat.GraphicalEffects

Rectangle {
    id: root
    color: voidDeep

    property int stage

    readonly property color voidColor: "#19120d"
    readonly property color voidDeep: "#100b07"
    readonly property color tealColor: "#00d1da"
    readonly property color amberColor: "#f0a646"
    readonly property color inkColor: "#f5f1ec"
    readonly property color mutedColor: "#b3a08d"

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
        }
    }

    // dark radial backdrop, brighter near top-center like the approved mockup
    RadialGradient {
        anchors.fill: parent
        verticalOffset: -root.height * 0.34
        horizontalRadius: root.width * 0.75
        verticalRadius: root.height * 0.75
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#241a13" }
            GradientStop { position: 0.45; color: root.voidColor }
            GradientStop { position: 1.0; color: root.voidDeep }
        }
    }

    // two soft glow blobs that drift slowly, teal + amber tinted
    Item {
        id: glowLayer
        anchors.fill: parent
        opacity: 0.8

        Rectangle {
            id: tealGlow
            width: parent.width * 0.4
            height: width
            radius: width / 2
            color: root.tealColor
            opacity: 0.3
            x: parent.width * 0.30
            y: parent.height * 0.18
        }
        GaussianBlur {
            anchors.fill: tealGlow
            source: tealGlow
            radius: 48
            samples: 33
        }

        Rectangle {
            id: amberGlow
            width: parent.width * 0.32
            height: width
            radius: width / 2
            color: root.amberColor
            opacity: 0.26
            x: parent.width * 0.56
            y: parent.height * 0.56
        }
        GaussianBlur {
            anchors.fill: amberGlow
            source: amberGlow
            radius: 48
            samples: 33
        }

        SequentialAnimation {
            running: true
            loops: Animation.Infinite
            ParallelAnimation {
                NumberAnimation { target: tealGlow; property: "x"; to: tealGlow.x - glowLayer.width * 0.02; duration: 11000; easing.type: Easing.InOutQuad }
                NumberAnimation { target: tealGlow; property: "y"; to: tealGlow.y + glowLayer.height * 0.02; duration: 11000; easing.type: Easing.InOutQuad }
                NumberAnimation { target: amberGlow; property: "x"; to: amberGlow.x - glowLayer.width * 0.02; duration: 11000; easing.type: Easing.InOutQuad }
                NumberAnimation { target: amberGlow; property: "y"; to: amberGlow.y + glowLayer.height * 0.02; duration: 11000; easing.type: Easing.InOutQuad }
            }
            ParallelAnimation {
                NumberAnimation { target: tealGlow; property: "x"; to: glowLayer.width * 0.30; duration: 11000; easing.type: Easing.InOutQuad }
                NumberAnimation { target: tealGlow; property: "y"; to: glowLayer.height * 0.18; duration: 11000; easing.type: Easing.InOutQuad }
                NumberAnimation { target: amberGlow; property: "x"; to: glowLayer.width * 0.56; duration: 11000; easing.type: Easing.InOutQuad }
                NumberAnimation { target: amberGlow; property: "y"; to: glowLayer.height * 0.56; duration: 11000; easing.type: Easing.InOutQuad }
            }
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        Column {
            anchors.centerIn: parent
            spacing: 14

            Image {
                id: mark
                anchors.horizontalCenter: parent.horizontalCenter
                source: "images/mark.svg"
                sourceSize.width: 40
                sourceSize.height: 40
                width: 40
                height: 40
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "TAHOE"
                color: root.inkColor
                font.family: "monospace"
                font.pixelSize: 17
                font.letterSpacing: font.pixelSize * 0.3
            }

            Item {
                id: bootBarTrack
                anchors.horizontalCenter: parent.horizontalCenter
                width: 180
                height: 2
                clip: true

                Rectangle {
                    anchors.fill: parent
                    radius: 2
                    color: Qt.rgba(root.inkColor.r, root.inkColor.g, root.inkColor.b, 0.12)
                }

                Rectangle {
                    id: bootBarSweep
                    width: bootBarTrack.width * 0.4
                    height: parent.height
                    radius: 2
                    x: -width
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: root.tealColor }
                        GradientStop { position: 1.0; color: root.amberColor }
                    }

                    SequentialAnimation on x {
                        loops: Animation.Infinite
                        running: true
                        NumberAnimation {
                            from: -bootBarSweep.width
                            to: bootBarTrack.width + bootBarSweep.width
                            duration: 1600
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Preparing your desktop"
                color: root.mutedColor
                font.pixelSize: 11
                font.letterSpacing: 1
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
