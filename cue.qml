//=============================================================================
//  MuseScore
//  Linux Music Score Editor
//  $Id:$
//
//  Cue Notes plugin
//
//  Copyright (C)2008-2011 Werner Schweer and others
//  Copyright (C)2013-2014 Joachim Schmitz
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 2.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
//=============================================================================

//
//    This is ECMAScript code (ECMA-262 aka "Java Script")
//

// loop through selection making all notes (and rests?) small and silent

import QtQuick 2.1
import MuseScore 1.0

MuseScore {
   version: "1.0"
   description: "This plugin makes all notes and rests in selection small and silent"
   menuPath: 'Plugins.Cue Notes'
   onRun: {
      if (typeof curScore === 'undefined')
         Qt.quit();

      var cursor       = curScore.newCursor();
      var selectionEnd = curScore.newCursor();

      cursor.rewind(1); // start of selection
      selectionEnd.rewind(2); // end of selection

      var startTrack = cursor.track;
      var endTrack   = selectionEnd.track;

      for (var track = startTrack; track < endTrack; ++track) {
         cursor.rewind(1); // start of selection
         cursor.track = track;

         while (cursor.segment && cursor.tick < selectionEnd.tick) {
            if (cursor.element && cursor.element.type == Element.CHORD) {
               //var chord = cursor.element;
               // not (yet) available in the plugin framework, unlike 1.x
               //chord.small = !(chord.small) // toggle
               var notes = cursor.element.notes;

               for (var i = 0; i < notes.length; ++i) {
                  var note = notes[i];
                  // make silent
                  note.play = !(note.play); // toggle
                  // won't be needed if chord.small were available
                  note.small = !(note.small); // toggle
               }
            }
            else if (cursor.element && cursor.element.type == Element.REST) {
               //var rest = cursor.element;
               // not (yet) available in the plugin framework, unlike 1.x
               //rest.small = !(rest.small); // toggle
            }

            cursor.next();
         }
      }
      Qt.quit();
   }
}
