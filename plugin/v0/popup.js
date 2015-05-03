// Copyright (c) 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/**
 * Get the current URL.
 *
 * @param {function(string)} callback - called when the URL of the current tab
 *   is found.
 **/
function getCurrentTabUrl(callback) {
  // Query filter to be passed to chrome.tabs.query - see
  // https://developer.chrome.com/extensions/tabs#method-query
  var queryInfo = {
    active: true,
    currentWindow: true
  };

  chrome.tabs.query(queryInfo, function(tabs) {
    // chrome.tabs.query invokes the callback with a list of tabs that match the
    // query. When the popup is opened, there is certainly a window and at least
    // one tab, so we can safely assume that |tabs| is a non-empty array.
    // A window can only have one active tab at a time, so the array consists of
    // exactly one tab.
    var tab = tabs[0];

    // A tab is a plain object that provides information about the tab.
    // See https://developer.chrome.com/extensions/tabs#type-Tab
    var url = tab.url;

    // tab.url is only available if the "activeTab" permission is declared.
    // If you want to see the URL of other tabs (e.g. after removing active:true
    // from |queryInfo|), then the "tabs" permission is required to see their
    // "url" properties.
    console.assert(typeof url == 'string', 'tab.url should be a string');

    callback(url);
  });

  // Most methods of the Chrome extension APIs are asynchronous. This means that
  // you CANNOT do something like this:
  //
  // var url;
  // chrome.tabs.query(queryInfo, function(tabs) {
  //   url = tabs[0].url;
  // });
  // alert(url); // Shows "undefined", because chrome.tabs.query is async.
}

/**
 * @param {string} searchTerm - Search term for Google Image search.
 * @param {function(string,number,number)} callback - Called when an image has
 *   been found. The callback gets the URL, width and height of the image.
 * @param {function(string)} errorCallback - Called when the image is not found.
 *   The callback gets a string that describes the failure reason.
 */
function getNotesForUrl(searchTerm, callback, errorCallback) {
 callback('My Notes');
}

function renderStatus(statusText) {
  document.getElementById('status').textContent = statusText;
  console.log('start loading data');
}

document.addEventListener('DOMContentLoaded', function() {
  getCurrentTabUrl(function(url) {
    // Put the image URL in Google search.
    renderStatus('Loading Notes for ' + url);

    getNotesForUrl(url, function(urlNote) {
      renderStatus('Notes For: ' + url);
      var noteResult = document.getElementById('notes');
      noteResult.value = urlNote;
	  var urlResult = document.getElementById('url');
	  urlResult.value = url;
    }, function(errorMessage) {
      renderStatus('Cannot display image. ' + errorMessage);
    });
  });
});

function successCreateFS(fs) {
	console.log("More saving");
	fs.root.getFile("info.txt",{create:true}, function(fileEntry){
		fileEntry.createWriter(function(f)
            {
				console.log("Saving continues");
                f.onwriteend = function(event) {};
                f.onerror = function(err) {};
                BlobBuilder = window.BlobBuilder || window.WebKitBlobBuilder || window.MozBlobBuilder;
                var writer = new BlobBuilder();
                writer.append("1:"+newNote);
                f.write(writer.getBlob('text/plain'));
				console.log("Successful write.");
			});
	
	}
	)
}

function failToCreateFS() {
	console.log("Failed to create FS");
}

function writeNoteToStore(note,url) {
	console.log('Continuing to Save');
	window.webkitRequestFileSystem(window.PERSISTENT , 1024*1024, successCreateFS, failToCreateFS);
}

var items = document.querySelectorAll(".save");
console.log("Running");
for (var i = 0; i < items.length; i++) {
	console.log("Running Inside");
	var el = items[i];

	//capturing phase
	el.addEventListener("click", doSomething, true);
}

function doSomething(e) {
	console.log(e.currentTarget.id);
}