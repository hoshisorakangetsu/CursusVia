<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="CreateCourseContent.aspx.cs" Inherits="CursusVia.Tutor.CreateCourseContent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/Tutor/CreateUpdateCourseContent.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/FileUploadGeneric.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="createUpdateCourseContentMain">
        <div class="backControl">
            <span class="material-symbols-outlined">
            arrow_back
            </span>
            Course Menu
        </div>
        <!-- seems like cannot extract out to be a common file, cannot apply dry d -->
        <div class="uploadFileContainer" id="dropZoneVid">
            <input id="contentVid" type="file" value="" hidden />
            <div class="uploadFile" id="uploadFileHint">
                <span class="uploadIcon material-symbols-outlined">
                smart_display
                </span>
                <h3>Drop Files or Click to Browse</h3>
            </div>
            <!-- will be populated by js once got file -->
            <video src="#" alt="File Preview" id="filePreview" class="filePreview" style="display: none;" controls onclick="event.stopPropagation()" />
        </div>
        <div class="fields">
            <div class="genericInputField">
                <label for="CourseTitle">Content Title</label>
                <asp:TextBox ID="CourseTitle" runat="server"></asp:TextBox>
            </div>
            <div class="genericInputField">
                <label for="Description">Content Description</label>
                <!-- 
                    quick one liner for auto resizing textbox based on number of rows 
                    drawbacks: won't work for copy paste, will resize for the first time the user hits enter
                -->
                <asp:TextBox ID="Description" runat="server" TextMode="MultiLine" Rows="10" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'"></asp:TextBox>
            </div>
        </div>

        <label for="courseContentRes">Content Resources</label>
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
        <asp:Button ID="submitForm" CssClass="btn btnPrimary" Text="Create Course" runat="server" />
    </div>
    <!-- since cannot extract out to a common file d, might as well just embed the logic here -->
    <script defer>
        const dropZone = document.querySelector("#dropZoneVid");
        const dropZone2 = document.querySelector("#dropZoneCourseContentRes");
        const fileInput = dropZone.querySelector("#contentVid");
        const fileInput2 = dropZone2.querySelector("#courseContentRes");
        dropZone.addEventListener("click", () => fileInput.click()); 
        dropZone2.addEventListener("click", () => fileInput2.click()); // I hate js ASI, gonna insert semi from now on :))))

        // prevent default and stop propagation for all drag and drop related events
        ["drag", "dragstart", "dragend", "dragover", "dragenter", "dragleave", "drop"].forEach(evt => {
            dropZone.addEventListener(evt, e => {
                e.preventDefault();
                e.stopPropagation();
            });
            dropZone2.addEventListener(evt, e => {
                e.preventDefault();
                e.stopPropagation();
            });
        });

        // change hint when user drags a file to the dropzone
        ["dragenter", "dragover"].forEach(evt => {
            dropZone.addEventListener(evt, _e => {
                dropZone.classList.add("uploadFileEnter");
            });
            dropZone2.addEventListener(evt, _e => {
                dropZone2.classList.add("uploadFileEnter");
            });
        });

        ["dragleave", "drop"].forEach(evt => {
            dropZone.addEventListener(evt, _e => {
                dropZone.classList.remove("uploadFileEnter");
            });
            dropZone2.addEventListener(evt, _e => {
                dropZone2.classList.remove("uploadFileEnter");
            });
        });

        dropZone.addEventListener("drop", e => {
            let files = e.dataTransfer.files;
            if (files.length) {
                fileInput.files = files;
                uploadVidFile(files)
            }
        });

        fileInput.addEventListener("change", _e => {
            uploadVidFile(fileInput.files)
        });

        fileInput2.addEventListener("change", e => {
            // upload the files to the server here (take note file list wont be appended when the user reopens the dialog and selects another file, it is overriden)
            console.log(fileInput2.files)
        });

        function uploadVidFile(f) {
            // handle file upload and preview here
            if (f.length && f[0].type.includes("video")) {
                const vidPreview = dropZone.querySelector("#filePreview")
                vidPreview.src = URL.createObjectURL(f[0])
                vidPreview.style.display = "block";

                dropZone.querySelector("#uploadFileHint").style.display = "none";
            }
        }

        // TODO
        function uploadContentFiles(f) {
            /**
             Create this structure and add it to fileListPreview
             <div class="fileItem">
                <span class="fileName">file1.js</span>
                <span class="deleteIcon material-symbols-outlined">
                delete
                </span>
             </div>
            */
        }
    </script>
</asp:Content>

