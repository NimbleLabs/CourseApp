var NimbleAnalytics = {
    // constructor(site, path) {
    //     this.site = site
    //     this.path = path
    //     this.userId = null
    //     this.logClickEvents()
    // }

    userId: null,

    logUserPageView: function( userId ) {
        this.userId = userId
        var eventObject = {
            event: {
                site: window.location.hostname,
                page: window.location.pathname,
                user_id: userId,
                date: new Date()
            }
        }

        var settings = {
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(eventObject)   ,
            dataType: "json",
        }

        $.ajax('/events.json', settings)
    },

    logVisitorPageView: function() {
        var visitorId = this.getCookie('nhq_vid')

        var eventObject = {
            event: {
                site: window.location.hostname,
                page: window.location.pathname,
                visitor_id: visitorId,
                date: new Date()
            }
        }

        var settings = {
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(eventObject),
            dataType: "json",
        }

        $.ajax('/events.json', settings)
    },

    getCookie: function(cname) {
        var name = cname + "=";
        var decodedCookie = decodeURIComponent(document.cookie);
        var ca = decodedCookie.split(';');
        for(var i = 0; i <ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }
}

//window.AnalyticsManager = new NimbleAnalytics(window.location.hostname, window.location.pathname)
window.NimbleAnalytics = NimbleAnalytics
