import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Window 2.14
import Qt.labs.qmlmodels 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Properties table")

    TableView {
        anchors.fill: parent

        model: TableModel {
            TableModelColumn {
                display: "name"
                decoration: function() { return "";}
            }
            TableModelColumn {
                display: "value"
                decoration: "type"
            }
            rows: [
                {
                    name: "Name",
                    type: "string",
                    value: "Alfred"
                },
                {
                    name: "Enabled",
                    type: "bool",
                    value: true
                },
                {
                    name: "Count",
                    type: "int",
                    value: 2
                }
            ]
        }

        delegate: DelegateChooser {
            role: "decoration"
            DelegateChoice {
                roleValue: "string"
                delegate: TextField {
                    text: model.display
                    selectByMouse: true
                }
            }
            DelegateChoice {
                roleValue: "int"
                delegate: SpinBox {
                    value: model.display
                }
            }
            DelegateChoice {
                roleValue: "bool"
                delegate: CheckBox {
                    checked: model.display
                }
            }
            DelegateChoice {
                delegate: Rectangle {
                    color: "beige"
                    implicitWidth: textLabel.width + 10
                    implicitHeight: textLabel.height
                    Text {
                        id: textLabel
                        anchors.centerIn: parent
                        text: model.display
                    }
                }
            }
        }
    }
}
