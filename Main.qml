import QtQuick 2.7
import QtQuick.Layouts 1.3
import SddmComponents 2.0

Rectangle {
    color: "#999"

    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        // This rectangle is solely to contain the login box.  This
        // permits it to be shown on only one screen.
        id: login_container
        anchors.fill: parent
        color: "transparent"
        visible: primaryScreen

        Rectangle {
            // This is the background behind the tray.
            id: tray_bg
            height: tray.childrenRect.height
            width: tray.childrenRect.width
            color: "#000"
            opacity: 0.6
        }

        Rectangle {
            // This is the real tray
            id: tray

            GridLayout {
                // This exists solely to process the margins
                Layout.fillWidth: true
                width: login_container.width

                RowLayout {
                    // This contains the contents of the bottom tray.
                    Layout.margins: 5
                    Layout.fillWidth: true

                    ComboBox {
                        id: session
                        width: 150
                        height: 20
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft

                        model: sessionModel
                        index: sessionModel.lastIndex

                        font.pixelSize: 11
                        font.family: "monospace"
                    }

                    Item { Layout.fillWidth: true }

                    Text {
                        id: clock
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

                        color: "#fff"
                        font.weight: Font.ExtraBold
                    }
                }
            }
        }

        Rectangle {
            // This is the background behind the login form.
            width: login_form.childrenRect.width
            height: login_form.childrenRect.height
            anchors.centerIn: login_container
            color: "#000"
            opacity: .6
        }

        Rectangle {
            id: login_form
            anchors.centerIn: login_container

            GridLayout {
                // This GridLayout exists solely to calculate the
                // margins of the ColumnLayout within it.
                anchors.centerIn: parent
                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.margins: 10

                    TextBox {
                        id: user_entry
                        Layout.alignment: Qt.AlignHCenter
                        width: 200

                        focus: true
                        KeyNavigation.tab: pass_entry
                    }

                    PasswordBox {
                        id: pass_entry
                        Layout.alignment: Qt.AlignHCenter
                        width: user_entry.width
                        KeyNavigation.backtab: user_entry
                        KeyNavigation.tab: login_button

                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(user_entry.text, pass_entry.text, session.index)
                                event.accepted = true
                            }
                        }
                    }

                    Button {
                        id: login_button
                        text: "Login"
                        Layout.alignment: Qt.AlignHCenter
                        width: user_entry.width

                        onClicked: sddm.login(user_entry.text, pass_entry.text, session.index)
                    }
                }
            }
        }
    }

    Timer {
        interval: 500
        repeat: true
        running: true
        onTriggered: clock.text = new Date().toLocaleString(Qt.locale("en_US"), "hh:mm:ss")
    }
}
