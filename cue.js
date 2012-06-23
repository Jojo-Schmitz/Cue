//=============================================================================
//  MuseScore
//  Linux Music Score Editor
//  $Id:$
//
//  Cue Notes plugin
//
//  Copyright (C)2008-2011 Werner Schweer and others
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

//---------------------------------------------------------
//    init
//    this function will be called on startup of
//    mscore
//---------------------------------------------------------

function init () {
}

// loop through music making all notes and rests small and silent

function cue () {

  var cursor       = new Cursor(curScore);
  var selectionEnd = new Cursor(curScore);

  cursor.goToSelectionStart();
  selectionEnd.goToSelectionEnd();
  var startStaff = cursor.staff;
  var endStaff   = selectionEnd.staff;

  // must select something
  if (cursor.eos()) {
    QMessageBox.warning(0,"Invalid Selection","Please select something and retry operation");
    return;
  }

  curScore.startUndo();

  for (var staff = startStaff; staff < endStaff; ++staff) {

    for (var voice = 0; voice < 4; ++voice) {

      cursor.goToSelectionStart();
      cursor.staff = staff;
      cursor.voice = voice;

      while (cursor.tick() < selectionEnd.tick()) {

        if (cursor.isChord()) {
          var chord = cursor.chord();
          var notes = chord.notes;
          for (var i = 0; i < notes; ++i) {
            var note = chord.note(i);
            note.velocity = 0;
          }
          chord.small = true;
        }
        else if (cursor.isRest()) {
          var rest = cursor.rest();
          rest.small = true;
        }

        cursor.next();

      }

    }

  }

  curScore.endUndo();

}

function run () {
  cue();
}

//---------------------------------------------------------
//    menu:  defines where the function will be placed
//           in the menu structure
//---------------------------------------------------------

var mscorePlugin = {
      menu: 'Plugins.Cue Notes',
      init: init,
      run:  run
}

mscorePlugin;
