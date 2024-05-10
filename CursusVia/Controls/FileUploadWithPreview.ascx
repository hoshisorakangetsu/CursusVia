﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileUploadWithPreview.ascx.cs" Inherits="CursusVia.Controls.FileUploadWithPreview" %>

<link href='<%= ResolveUrl("~/FileUploadGeneric.css") %>' rel="stylesheet" />

<div class="inputWithValidator">
    <div class="uploadFileContainer" id="dropZone">
        <asp:FileUpload ID="_MediaFileUpload" runat="server" Style="display: none;" />
        <div class="uploadFile" id="uploadFileHint">
            <span class="uploadIcon material-symbols-outlined">add_photo_alternate
            </span>
            <h3>Drop Files or Click to Browse</h3>
        </div>
        <!-- will be populated by js once got file -->
        <img src="#" alt="File Preview" id="filePreview" class="filePreview" style="display: none;" />
    </div>
    <% if (IsRequired)
        {  %>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select an Image" ControlToValidate="_MediaFileUpload" CssClass="requiredValidator validationMessage"></asp:RequiredFieldValidator>
    <% } %>
</div>

<script defer>
    const dropZone = document.querySelector("#dropZone");
    const fileInput = dropZone.querySelector("input[type = file]");
    dropZone.addEventListener("click", () => fileInput.click()); // I hate js ASI, gonna insert semi from now on :))))

    // prevent default and stop propagation for all drag and drop related events
    ["drag", "dragstart", "dragend", "dragover", "dragenter", "dragleave", "drop"].forEach(evt => {
        dropZone.addEventListener(evt, e => {
            e.preventDefault();
            e.stopPropagation();
        })
    });

    // change hint when user drags a file to the dropzone
    ["dragenter", "dragover"].forEach(evt => dropZone.addEventListener(evt, _e => {
        dropZone.classList.add("uploadFileEnter");
    }));

    ["dragleave", "drop"].forEach(evt => dropZone.addEventListener(evt, _e => {
        dropZone.classList.remove("uploadFileEnter");
    }));

    dropZone.addEventListener("drop", e => {
        let files = e.dataTransfer.files;
        if (files.length) {
            fileInput.files = files;
            uploadFile(files)
        }
    });

    fileInput.addEventListener("change", e => {
        uploadFile(fileInput.files)
    });

    function uploadFile(f) {
        // handle file upload and preview here
        if (f.length && f[0].type.includes("image")) {
            const imgPreview = dropZone.querySelector("#filePreview")
            imgPreview.src = URL.createObjectURL(f[0])
            imgPreview.style.display = "block";

            dropZone.querySelector("#uploadFileHint").style.display = "none";
        }
    }
</script>
