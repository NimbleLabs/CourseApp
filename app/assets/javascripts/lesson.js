var videoElements = document.getElementsByTagName("video");

if(videoElements && videoElements[0]) {
    console.log('Setting up video events')
    var v = videoElements[0]
    v.addEventListener("seeked", (event) => {
        ahoy.track("$seeked", {lesson_id: NIMBLE_HQ_LESSON_ID, page: window.location.pathname});
    }, true);

    v.addEventListener("ended", (event) => {
        ahoy.track("$ended", {lesson_id: NIMBLE_HQ_LESSON_ID, page: window.location.pathname});
    }, true);

    v.addEventListener("play", (event) => {
        ahoy.track("$play", {lesson_id: NIMBLE_HQ_LESSON_ID, page: window.location.pathname});
    }, true);

    v.addEventListener("pause", (event) => {
        ahoy.track("$pause", {lesson_id: NIMBLE_HQ_LESSON_ID, page: window.location.pathname});
    }, true);
}