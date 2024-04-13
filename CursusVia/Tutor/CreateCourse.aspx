<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorMaster.master" AutoEventWireup="true" CodeBehind="CreateCourse.aspx.cs" Inherits="CursusVia.Tutor.CreateCourse" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TutorMasterHead" runat="server">
    <link href='<%= ResolveUrl("~/Tutor/CreateUpdateCourse.css") %>' rel="stylesheet" />
    <link href='<%= ResolveUrl("~/FileUploadGeneric.css") %>' rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TutorMasterBody" runat="server">
    <div class="createUpdateCourseMain">
        <div class="backControl">
            <span class="material-symbols-outlined">
            arrow_back
            </span>
            All Courses
        </div>
        <!-- seems like cannot extract out to be a common file, cannot apply dry d -->
        <div class="uploadFileContainer" id="dropZone">
            <input id="coverImg" type="file" value="" hidden />
            <div class="uploadFile" id="uploadFileHint">
                <span class="uploadIcon material-symbols-outlined">
                add_photo_alternate
                </span>
                <h3>Drop Files or Click to Browse</h3>
            </div>
            <!-- will be populated by js once got file -->
            <img src="#" alt="File Preview" id="filePreview" class="filePreview" style="display: none;" />
        </div>
        <div class="fields">
            <div class="genericInputField">
                <label for="CourseTitle">Course Title</label>
                <asp:TextBox ID="CourseTitle" runat="server"></asp:TextBox>
            </div>
            <div class="genericInputField">
                <label for="Price">Price</label>
                <asp:TextBox ID="Price" runat="server" TextMode="Number"></asp:TextBox>
            </div>
            <div class="genericInputField">
                <label for="Category">Category</label>
                <asp:DropDownList ID="CourseCategory" runat="server">
                    <asp:ListItem Selected="True">All Category</asp:ListItem>
                    <asp:ListItem Value="web_development">Web Development</asp:ListItem>
                    <asp:ListItem Value="digital_marketing">Digital Marketing</asp:ListItem>
                    <asp:ListItem Value="graphic_design">Graphic Design</asp:ListItem>
                    <asp:ListItem Value="mobile_apps">Mobile Apps</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="genericInputField">
                <label for="Description">Course Description</label>
                <!-- 
                    quick one liner for auto resizing textbox based on number of rows 
                    drawbacks: won't work for copy paste, will resize for the first time the user hits enter
                -->
                <asp:TextBox ID="Description" runat="server" TextMode="MultiLine" Rows="10" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'"></asp:TextBox>
            </div>
        </div>
        <asp:Button ID="submitForm" CssClass="btn btnPrimary" Text="Create Course" runat="server" />
    </div>
    <script src='<%= ResolveUrl("~/BackControlInit.js") %>' defer></script>
    <!-- since cannot extract out to a common file d, might as well just embed the logic here -->
    <script defer>
        const dropZone = document.querySelector("#dropZone");
        const fileInput = dropZone.querySelector("#coverImg");
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
</asp:Content>
