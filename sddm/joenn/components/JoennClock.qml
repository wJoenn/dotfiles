import QtQuick 2.0

Column {
  id: container

  property date dateTime: new Date()

  Timer {
    repeat: true
    running: true

    onTriggered: container.dateTime = new Date()
  }

  Text {
    id: time

    anchors.right: parent.right
    color: "#cbcbcb"
    font.pointSize: 90
    text : Qt.formatTime(container.dateTime, "hh:mm")
  }

  Text {
    id: date

    anchors.right: parent.right
    color: "#cbcbcb"
    font.pointSize: 25
    text : Qt.formatDate(container.dateTime, "dddd, d MMMM yyyy")
  }
}
