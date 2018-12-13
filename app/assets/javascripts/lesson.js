var videoElements = document.getElementsByTagName("video");

function getEventObject() {
    if (NIMBLE_HQ_USER_ID === null) {
        return {lesson_id: NIMBLE_HQ_LESSON_ID, page: window.location.pathname}
    }

    return {
        lesson_id: NIMBLE_HQ_LESSON_ID,
        user_id: NIMBLE_HQ_USER_ID,
        page: window.location.pathname
    }
}

if (videoElements && videoElements[0]) {
    var eventObject = getEventObject()

    var v = videoElements[0]
    v.addEventListener("seeked", function (event) {
        ahoy.track("$seeked", eventObject);
    }, true);

    v.addEventListener("ended", function (event) {
        ahoy.track("$ended", eventObject);
    }, true);

    v.addEventListener("play", function (event) {
        ahoy.track("$play", eventObject);
    }, true);

    v.addEventListener("pause", function (event) {
        ahoy.track("$pause", eventObject);
    }, true);
}