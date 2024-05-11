<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MultiFileUpload.ascx.cs" Inherits="CursusVia.Controls.MultiFileUpload" %>

<link href='<%= ResolveUrl("~/FileUploadGeneric.css") %>' rel="stylesheet" />
<div class="uploadFileContainer margin-0" id="dropZoneCourseContentRes">
    <input id="courseContentRes" type="file" value="" hidden multiple />
    <asp:HiddenField ID="FileIDS" runat="server" />
    <asp:HiddenField ID="DeletedFileIDS" runat="server" />
    <div class="uploadFile">
        <span class="uploadIcon material-symbols-outlined">
        upload_file
        </span>
        <h3>Drop Files or Click to Browse</h3>
    </div>
</div>
<div class="fileListPreview" id="contentResPreview"></div>

<script defer>
    const requests = [];
    let uploadedIds = [];
    const deletedIds = [];
    const dropZoneMultiFile = document.querySelector("#dropZoneCourseContentRes");
    const fileInputMultiFile = dropZoneMultiFile.querySelector("#courseContentRes");
    const filePrev = document.querySelector("#contentResPreview");
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
        let files = e.dataTransfer.files;
        if (files.length) {
            Array.from(files).forEach(f => uploadContentFile(f))
        }
    });

    fileInputMultiFile.addEventListener("change", e => {
        // upload the files to the server here (take note file list wont be appended when the user reopens the dialog and selects another file, it is overriden)
        console.log(fileInputMultiFile.files)
        Array.from(fileInputMultiFile.files).forEach(f => uploadContentFile(f));
    });

    function createFileBlock(name) {
        const fileItem = document.createElement("div");
        fileItem.classList.add("fileItem");

        const fileName = document.createElement("span");
        fileName.classList.add("fileName");
        fileName.innerHTML = name;

        const deleteIcon = document.createElement("span");
        deleteIcon.classList.add("icon");
        deleteIcon.classList.add("iconLoading");
        deleteIcon.classList.add("material-symbols-outlined");
        deleteIcon.innerHTML = "progress_activity";

        fileItem.appendChild(fileName);
        fileItem.appendChild(deleteIcon);
        return fileItem;
    }

    function attachDeleteListener(fileItem, deleteId) {
        const fileItemIcon = fileItem.querySelector(".icon");
        // actual deletes should be handled by backend without the use of AJAX
        fileItemIcon.addEventListener("click", () => {
            filePrev.removeChild(fileItem);
            deletedIds.push(deleteId);
            uploadedIds = uploadedIds.filter(id => id !== deleteId);
        })
    }

    function uploadContentFile(f) {
        const xhr = new XMLHttpRequest();
        const formData = new FormData();
        formData.append("file", f);

        console.log(f);
        const fileItem = createFileBlock(f.name);

        xhr.addEventListener("readystatechange", () => {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                const status = xhr.status;
                if (status === 0 || (status >= 200 && status < 400)) {
                    // The request has been completed successfully
                    console.log(xhr.responseText);
                    const fileItemIcon = fileItem.querySelector(".icon");
                    fileItemIcon.classList.add("deleteIcon");
                    fileItemIcon.classList.remove("iconLoading");
                    fileItemIcon.innerHTML = "delete";
                    attachDeleteListener(fileItem, xhr.responseText);
                    uploadedIds.push(xhr.responseText);
                } else {
                    // Oh no! There has been an error with the request! ZHIJIE REMOVE THE FILE ITEM PREVIEW MUAHAHAHA
                    filePrev.removeChild(fileItem);
                }
            }
        });

        xhr.upload.addEventListener("loadstart", e => {
            filePrev.appendChild(fileItem);
        });

        xhr.open("POST", "/Tutor/AddContentResource.ashx");
        xhr.send(formData);
        requests.push(xhr);
    }

    function populateFileIDs() {
        const fileHidden = dropZoneMultiFile.querySelector("#<%= FileIDS.ClientID %>");
        const deletedFileHidden = dropZoneMultiFile.querySelector("#<%= DeletedFileIDS.ClientID %>");
        if (requests.every(r => r.readyState === XMLHttpRequest.DONE)) {
            // make sure all done and all the ids have been added to the uploaded ids
            if (requests.length === uploadedIds.length) {
                fileHidden.value = uploadedIds.join(",");
                deletedFileHidden.value = deletedIds.join(",");
                console.log(fileHidden.value, deletedFileHidden.value);
                return true;
            }
        }
        return false;
    }
</script>

<% if(!String.IsNullOrEmpty(Files))
    { %>
<% // attach the js that binds the file items if there are files alrd (mean high possibility the user is in update page) %>
<script defer>
    const existingFiles = "<%= Files %>";
    existingFiles.split(";").forEach(f => {
        if (!f) return;
        const fileDetail = f.split(",");
        const fileItem = createFileBlock(fileDetail[1]);
        const fileItemIcon = fileItem.querySelector(".icon");
        fileItemIcon.classList.add("deleteIcon");
        fileItemIcon.classList.remove("iconLoading");
        fileItemIcon.innerHTML = "delete";
        attachDeleteListener(fileItem, fileDetail[0]);
        filePrev.appendChild(fileItem);
    });
</script>
<%
    } %>

