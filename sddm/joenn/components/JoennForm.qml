import QtQuick 2.0
import SddmComponents 2.0

Column {
  id: form

  property int sessionIndex: sessionModel.lastIndex
  property alias errorText: error.text

  spacing: 16
  width: 500

  Rectangle {
    id: nameWrapper

    border.color: "#0dffffff"
    border.width: 1
    color: "#0dffffff"
    height: 50
    radius: 8
    width: parent.width

    Row {
      id: nameRow

      anchors.left: parent.left
      anchors.leftMargin: 16
      anchors.verticalCenter: parent.verticalCenter
      height: parent.height
      spacing: 8
      width: parent.width

      Image {
        id: nameIcon

        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        height: 20
        source: Qt.resolvedUrl("../assets/user.png")
        width: 20
      }

      TextBox {
        id: name

        borderColor: "transparent"
        color: "transparent"
        focusColor: "transparent"
        font.pointSize: 16
        height: parent.height
        hoverColor: "transparent"
        radius: 0
        text: userModel.lastUser
        textColor: "#cbcbcb"
        width: parent.width - nameIcon.width - nameRow.spacing

        KeyNavigation.backtab: password
        KeyNavigation.tab: password

        Keys.onPressed: {
          if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            sddm.login(name.text, password.text, sessionIndex)
            event.accepted = true
          }
        }
      }
    }
  }

  Rectangle {
    id: passwordWrapper

    border.color: "#0dffffff"
    border.width: 1
    color: "#0dffffff"
    height: 50
    radius: 8
    width: parent.width

    Row {
      id: passwordRow

      anchors.left: parent.left
      anchors.leftMargin: 16
      anchors.verticalCenter: parent.verticalCenter
      height: parent.height
      spacing: 8
      width: parent.width

      Image {
        id: passwordIcon

        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        height: 20
        source: Qt.resolvedUrl("../assets/eye-off.png")
        width: 20
      }

      PasswordBox {
        id: password

        borderColor: "transparent"
        color: "transparent"
        focusColor: "transparent"
        font.pointSize: 16
        height: parent.height
        hoverColor: "transparent"
        radius: 0
        textColor: "#cbcbcb"
        width: parent.width - passwordIcon.width - passwordRow.spacing

        KeyNavigation.backtab: name
        KeyNavigation.tab: name

        Keys.onPressed: {
          if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            sddm.login(name.text, password.text, sessionIndex)
            event.accepted = true
          }
        }
      }
    }
  }

  Column {
    width: parent.width

    Text {
      id: error

      anchors.horizontalCenter: parent.horizontalCenter
      color: "#f14c4c"
      font.pixelSize: 10
    }
  }

  Component.onCompleted: {
    if (name.text == "")
      name.focus = true
    else
     password.focus = true
  }
}
