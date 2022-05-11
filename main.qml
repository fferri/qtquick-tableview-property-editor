import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Window 2.14
import Qt.labs.qmlmodels 1.0

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Properties table")

    property string name: "Bob"
    property bool enabled: true
    property int count: 42

    TableView {
        anchors.fill: parent

        model: TableModel {
            id: theModel
            TableModelColumn {
                display: "name"
                decoration: function() { return "";}
            }
            TableModelColumn {
                display: "value"
                decoration: "type"
            }
            rows: _rows
            property var _rows: [
                {
                    name: "Name",
                    type: "string",
                    value: root.name,
                    onValueChanged: function(v) {console.log('"name" changed to ',v)},
                },
                {
                    name: "Enabled",
                    type: "bool",
                    value: root.enabled,
                    onValueChanged: function(v) {console.log('"enabled" changed to ',v)},
                },
                {
                    name: "Count",
                    type: "int",
                    value: root.count,
                    onValueChanged: function(v) {console.log('"count" changed to ',v)},
                },
                {
                    name: "Count2",
                    type: "int",
                    value: root.count,
                    onValueChanged: function(v) {console.log('"count2" changed to ',v)},
                },
            ]
            function dispatchValueChange(row, decoration, value) {
                row = _rows[row]
                if(row && row.onValueChanged)
                    row.onValueChanged(value)
            }
        }

        delegate: DelegateChooser {
            role: "decoration"
            DelegateChoice {
                roleValue: "string"
                delegate: TextField {
                    text: model.display
                    selectByMouse: true
                    onEditingFinished: theModel.dispatchValueChange(model.row, model.decoration, text)
                }
            }
            DelegateChoice {
                roleValue: "int"
                delegate: SpinBox {
                    value: model.display
                    onValueChanged: theModel.dispatchValueChange(model.row, model.decoration, value)
                }
            }
            DelegateChoice {
                roleValue: "bool"
                delegate: CheckBox {
                    checked: model.display
                    onCheckedChanged: theModel.dispatchValueChange(model.row, model.decoration, checked)
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
