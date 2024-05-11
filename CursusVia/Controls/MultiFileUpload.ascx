<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MultiFileUpload.ascx.cs" Inherits="CursusVia.Controls.MultiFileUpload" %>

<link href='<%= ResolveUrl("~/FileUploadGeneric.css") %>' rel="stylesheet" />
<div class="uploadFileContainer margin-0" id="dropZoneCourseContentRes">
    <input id="courseContentRes" type="file" value="" hidden multiple />
    <div class="uploadFile">
        <span class="uploadIcon material-symbols-outlined">
        upload_file
        </span>
        <h3>Drop Files or Click to Browse</h3>
    </div>
</div>
<div class="fileListPreview" id="contentResPreview"></div>

<script defer>
    const onGoingRequests = [];
    const dropZoneMultiFile = document.querySelector("#dropZoneCourseContentRes");
    const fileInputMultiFile = dropZoneMultiFile.querySelector("#courseContentRes");
    dropZoneMultiFile.addEventListener("click", () => fileInputMultiFile.click()); // I hate js ASI, gonna insert semi from now on :))))

    // prevent default and stop propagation for all drag and drop related events
    ["drag", "dragstart", "dragend", "dragover", "dragenter", "dragleave", "drop"].forEach(evt => {
        dropZoneMultiFile.addEventListener(evt, e => {
            e.preventDefault();
            e.stopPropagation();
        });
    });

    // change hint when user drags a file to the dropzone
    ["dragenter", "dragover"].forEach(evt => {
        dropZoneMultiFile.addEventListener(evt, _e => {
            dropZoneMultiFile.classList.add("uploadFileEnter");
        });
    });

    ["dragleave", "drop"].forEach(evt => {
        dropZoneMultiFile.addEventListener(evt, _e => {
            dropZoneMultiFile.classList.remove("uploadFileEnter");
        });
    });

    dropZoneMultiFile.addEventListener("drop", e => {
        addEventListener("drop", e => {
            let files = e.dataTransfer.files;
            if (files.length) {
                files.forEach(f => fileInput.files.append(f))
            }
        });
    });

    fileInputMultiFile.addEventListener("change", e => {
        // upload the files to the server here (take note file list wont be appended when the user reopens the dialog and selects another file, it is overriden)
        console.log(fileInputMultiFile.files)
        uploadContentFile("dummy")
    });

    // TODO
    function uploadContentFile(f) {
        // TODO
        /*Create this structure and add it to fileListPreview (div id contentResPreview)
                <div class="fileItem" >
        <span class="fileName">file1.js</span>
        <span class="deleteIcon material-symbols-outlined">
        delete
        </span>
     </div >
     */
        const xhr = new XMLHttpRequest();
        xhr.addEventListener("readystatechange", () => {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                const status = xhr.status;
                if (status === 0 || (status >= 200 && status < 400)) {
                    // The request has been completed successfully
                    console.log(xhr.responseText, xhr.responseXML);
                } else {
                    // Oh no! There has been an error with the request!
                }
            }
        });

        xhr.open("POST", "/Tutor/AddContentResource.ashx");
        xhr.send();
    }
</script>

