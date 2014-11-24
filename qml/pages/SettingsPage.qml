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
import "db.js" as DB

Dialog {
    id: settingsPage
    allowedOrientations: mainWindow.allowedOrientations

    acceptDestinationAction: PageStackAction.Pop

// TODO
    //    function loadDefaults() {
//        loadSubtitlesSwitch.checked = true ;
//        subtitleSizeCombo.currentIndex = 34 - 25;
//        boldSubtitlesSwitch.checked = false ;
//        colorIndicator.color = Theme.highlightColor
//        directYoutubeSwitch.checked = false;
//        openDialogCombo.currentIndex = 0;
//        liveViewSwitch.checked = true;
//    }

    function saveSettings() {
        // Only save if something changes
        if (60000/wordsPerMinuteSlider.value != firstpage.words_per_minute) DB.addSetting("wordsPerMinute", wordsPerMinuteSlider.value.toString());
        if (longwordIsSlider.value != firstpage.long_word_chars) DB.addSetting("longwordIs", longwordIsSlider.value.toString());
        if (60000/longWordsPerMinuteSlider.value != firstpage.long_words_timeout) DB.addSetting("longWordsPerMinute", longWordsPerMinuteSlider.value.toString());
        if (fontSizeSlider.value != firstpage.fontSize) DB.addSetting("fontSize", fontSizeSlider.value.toString());
        DB.getSettings();
    }

    onAccepted: saveSettings();

    SilicaFlickable {
        id: listView
        anchors.fill: parent
        anchors.leftMargin: Theme.paddingMedium

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height + head.height

        DialogHeader {
            id: head
            acceptText: qsTr("Save Settings")
        }

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge
            anchors.top: head.bottom

            Label {
                text: qsTr("Words per minute:")
            }

            Slider {
                id: wordsPerMinuteSlider
                width: parent.width - (Theme.paddingLarge * 2)
                anchors.horizontalCenter: parent.horizontalCenter
                minimumValue: 100
                maximumValue: 1000
                value: Math.floor((60000/firstpage.words_per_minute))
                stepSize: 50
                valueText: value
            }
            Label {
                text: qsTr("Long Word is <b>%1</b> characters long").arg(longwordIsSlider.value)
            }

            Slider {
                id: longwordIsSlider
                width: parent.width - (Theme.paddingLarge * 2)
                anchors.horizontalCenter: parent.horizontalCenter
                minimumValue: 2
                maximumValue: 40
                value: firstpage.long_word_chars
                stepSize: 1
                valueText: value
            }

            Label {
                text: qsTr("Long Words per minute:")
            }

            Slider {
                id: longWordsPerMinuteSlider
                width: parent.width - (Theme.paddingLarge * 2)
                anchors.horizontalCenter: parent.horizontalCenter
                minimumValue: 100
                maximumValue: 1000
                value: Math.floor((60000/firstpage.long_words_timeout))
                stepSize: 50
                valueText: value
            }

            Label {
                text: qsTr("Font size:")
            }

            Slider {
                id: fontSizeSlider
                width: parent.width - (Theme.paddingLarge * 2)
                anchors.horizontalCenter: parent.horizontalCenter
                minimumValue: 24
                maximumValue: 100
                value: firstpage.fontSize
                stepSize: 2
                valueText: value
            }
        }
        VerticalScrollDecorator {}
    }
}





