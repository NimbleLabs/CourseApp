(function() {
    var HOST = "/photos.json"

    addEventListener("trix-attachment-add", function(event) {
        if (event.attachment.file) {
            uploadFileAttachment(event.attachment)
        }
    })

    function uploadFileAttachment(attachment) {
        uploadFile(attachment.file, setProgress, setAttributes)

        function setProgress(progress) {
            attachment.setUploadProgress(progress)
        }

        function setAttributes(attributes) {
            attachment.setAttributes(attributes)
        }
    }

    function uploadFile(file, progressCallback, successCallback) {
        var formData = createFormData(file)
        var xhr = new XMLHttpRequest()
        xhr.open("POST", HOST, true)
        xhr.setRequestHeader("X-CSRF-Token", Rails.csrfToken())

        xhr.upload.addEventListener("progress", function(event) {
            var progress = event.loaded / event.total * 100
            progressCallback(progress)
        })

        xhr.addEventListener("load", function(event) {
            if (xhr.status == 201) {
                var photoResponse = JSON.parse(xhr.responseText);
                console.log('Photo created')
                console.log(photoResponse)

                var attributes = {
                    url: photoResponse.image_url,
                    href: photoResponse.url
                }
                successCallback(attributes)
            }
        })

        xhr.send(formData)
    }

    function createFormData(file) {
        var data = new FormData()
        data.append("photo[image]", file)
        data.append("Content-Type", file.type)
        return data
    }
})();