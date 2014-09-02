/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    property int words_per_minute: 300 // 200 words per minute
    allowedOrientations: mainWindow.allowedOrientations

    function getWords(string) {

        var words = string.split(/\s+/);
        overlay.visible = true;
        readR.text = words[0];
        read.wordArray = words;
        read.start();

        // DEBUG
//        for(var i=0;i<words.length;i++){
//            console.log(words[i]);
//        }
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About ") + appname
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                id: header
                title: qsTr("TurboReadR")
            }
            TextArea {
               id: txt
               placeholderText: qsTr("Enter the text you want to read fast here")
               anchors.horizontalCenter: parent.horizontalCenter
               //height: page.height - (header.height + play.height + (Theme.paddingLarge * 2))
               width: parent.width
               background: null

            }
        }
    }
    Item {
        id: overlay
        anchors.fill: parent
        visible: false
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!read.running) {
                    overlay.visible = false
                    read.i = 1
                }
            }
        }

        Rectangle {
            id: overlayRect
            color: "black"
            opacity: 0.75
            anchors.centerIn: parent
            anchors.fill: parent
        }
        Rectangle {
            width: overlayRect.width
            height: readR.height + (Theme.paddingLarge * 2)
            anchors.centerIn: parent
            border.color: "yellow"
            border.width: 2
            color: "black"
            opacity: 0.75
        }
        Text {
            id: readR
            font.pointSize: 42
            font.bold: true
            opacity: 1.0
            color: "white"
            anchors.centerIn: overlayRect

            Timer {
                id: read
                interval: words_per_minute; repeat:true
                property int i:1
                property var wordArray
                onTriggered: {
                    if (i<wordArray.length) {
                        readR.text = wordArray[i];
                        i++;
                    }
                    else stop();
                }
            }
        }
    }
    Button {
        id: play
        text: read.running ? qsTr("Pause") : qsTr("Read")
        onClicked: {
            if (read.running) read.stop();
            else if (overlay.visible) read.start();
            else {
                //console.log("Reading...");
                page.getWords(txt.text)
            }
        }
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.paddingLarge
    }
}


