class NimbleAnalytics {
    constructor(site, path) {
        this.site = site
        this.path = path
    }

    logUserPageView( userId ) {
        var eventObject = {
            event: {
                site: this.site,
                page: this.path,
                user_id: userId,
                date: new Date()
            }
        }

        const settings = {
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(eventObject)   ,
            dataType: "json",
        }

        $.ajax('/events.json', settings)
    }

    logVisitorPageView() {
        const visitorId = this.getCookie('nhq_vid')

        var eventObject = {
            event: {
                site: this.site,
                page: this.path,
                visitor_id: visitorId,
                date: new Date()
            }
        }

        const settings = {
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(eventObject),
            dataType: "json",
        }

        $.ajax('/events.json', settings)
    }

    getCookie(cname) {
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

const AnalyticsManager = new NimbleAnalytics(window.location.hostname, window.location.pathname)
window.AnalyticsManager = AnalyticsManager