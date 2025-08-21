import QtQuick 2.0
import SddmComponents 2.0
import "components"

Rectangle {
  id: container

  property int sessionIndex: sessionModel.lastIndex

  TextConstants { id: textConstants }

  Connections {
    target: sddm

    onLoginFailed: {
      password.text = ""
      form.errorText = textConstants.loginFailed
    }

    onInformationMessage: {
      form.errorText = message
    }
  }

  Background {
    anchors.fill: parent
    fillMode: Image.PreserveAspectCrop
    source: config.background
  }

  Rectangle {
    anchors.fill: parent
    color: "transparent"

    JoennClock {
      id: clock

      anchors.right: parent.right
      anchors.rightMargin: 30
      anchors.top: parent.top
    }

    JoennForm {
      id: form

      anchors.centerIn: parent
      sessionIndex: container.sessionIndex
    }

    Text {
      id: session

      anchors.bottom: parent.bottom
      anchors.bottomMargin: 30
      anchors.horizontalCenter: parent.horizontalCenter
      color: "#cbcbcb"
      font.pointSize: 12
      text: "session(" + sessionModel.data(sessionModel.index(sessionIndex, 0), 260) + ")"

      MouseArea {
        anchors.fill: parent

        onClicked: {
          sessionIndex = (sessionIndex + 1) % sessionModel.count
        }
      }
    }
  }
}
