/*
    SPDX-FileCopyrightText: 2016 Boudhayan Gupta <bgupta@kde.org>

    SPDX-License-Identifier: LGPL-2.0-or-later
*/

import QtQuick 2.15
import Qt5Compat.GraphicalEffects

FocusScope {
    id: sceneBackground

    // Kept for API compatibility with Main.qml's bindings; the generated
    // gradient+glow look below no longer depends on these.
    property var sceneBackgroundType
    property color sceneBackgroundColor
    property url sceneBackgroundImage

    readonly property color voidColor: "#19120d"
    readonly property color voidDeep: "#100b07"
    readonly property color tealColor: "#00d1da"
    readonly property color amberColor: "#f0a646"

    RadialGradient {
        anchors.fill: parent
        verticalOffset: -sceneBackground.height * 0.34
        horizontalRadius: sceneBackground.width * 0.75
        verticalRadius: sceneBackground.height * 0.75
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#241a13" }
            GradientStop { position: 0.45; color: sceneBackground.voidColor }
            GradientStop { position: 1.0; color: sceneBackground.voidDeep }
        }
    }

    Item {
        id: glowLayer
        anchors.fill: parent
        opacity: 0.8

        Rectangle {
            id: tealGlow
            width: glowLayer.width * 0.34
            height: width
            radius: width / 2
            color: sceneBackground.tealColor
            opacity: 0.26
            x: glowLayer.width * 0.30
            y: glowLayer.height * 0.14
        }
        GaussianBlur {
            anchors.fill: tealGlow
            source: tealGlow
            radius: 56
            samples: 37
        }

        Rectangle {
            id: amberGlow
            width: glowLayer.width * 0.26
            height: width
            radius: width / 2
            color: sceneBackground.amberColor
            opacity: 0.22
            x: glowLayer.width * 0.60
            y: glowLayer.height * 0.60
        }
        GaussianBlur {
            anchors.fill: amberGlow
            source: amberGlow
            radius: 56
            samples: 37
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
                NumberAnimation { target: tealGlow; property: "y"; to: glowLayer.height * 0.14; duration: 11000; easing.type: Easing.InOutQuad }
                NumberAnimation { target: amberGlow; property: "x"; to: glowLayer.width * 0.60; duration: 11000; easing.type: Easing.InOutQuad }
                NumberAnimation { target: amberGlow; property: "y"; to: glowLayer.height * 0.60; duration: 11000; easing.type: Easing.InOutQuad }
            }
        }
    }
}
