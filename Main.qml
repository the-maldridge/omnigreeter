import QtQuick 2.7
import QtQuick.Layouts 1.3
import SddmComponents 2.0

Rectangle {
    color: "#999"

    Rectangle {
        // This rectangle is solely to contain the login box.  This
        // permits it to be shown on only one screen.
        id: login_container
        anchors.fill: parent
        color: "transparent"
        visible: primaryScreen
        
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
                    anchors.centerIn: parent
                    Layout.margins: 10

                    TextBox {
                        id: user_entry
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 200

                        focus: true
                        KeyNavigation.tab: pass_entry
                    }
                    
                    PasswordBox {
                        id: pass_entry
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: user_entry.width
                        KeyNavigation.backtab: user_entry
                        KeyNavigation.tab: login_button
                    }

                    Button {
                        id: login_button
                        text: "Login"
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: user_entry.width
                    }
                }
            }
        }

        Rectangle {
            // This is the background behind the bottom tray.
            id: bottom_tray_bg
            anchors.bottom: parent.bottom
            height: bottom_tray.childrenRect.height
            width: bottom_tray.childrenRect.width
            color: "#000"
            opacity: 0.6
        }

        Rectangle {
            // This is the real tray
            id: bottom_tray
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            GridLayout {
                // This exists solely to process the margins
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                RowLayout {
                    // This contains the contents of the bottom tray.
                    Layout.margins: 5

                    ComboBox {
                        id: session
                        width: 150
                        height: 20
                        
                        model: sessionModel
                        index: sessionModel.lastIndex
                        
                        font.pixelSize: 11
                        font.family: "monospace"
                    }
                }
            }   
        }
    }
}
