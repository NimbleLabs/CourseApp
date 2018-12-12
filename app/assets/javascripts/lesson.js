var videoElements = document.getElementsByTagName("video");

if(videoElements && videoElements[0]) {
    
    var v = videoElements[0]
    v.addEventListener("seeked", function(event) {
        ahoy.track("$seeked", {lesson_id: NIMBLE_HQ_LESSON_ID, page: window.location.pathname});
    }, true);

    v.addEventListener("ended", function(event) {
        ahoy.track("$ended", {lesson_id: NIMBLE_HQ_LESSON_ID, page: window.location.pathname});
    }, true);

    v.addEventListener("play", function(event) {
        ahoy.track("$play", {lesson_id: NIMBLE_HQ_LESSON_ID, page: window.location.pathname});
    }, true);

    v.addEventListener("pause", function(event) {
        ahoy.track("$pause", {lesson_id: NIMBLE_HQ_LESSON_ID, page: window.location.pathname});
    }, true);
}