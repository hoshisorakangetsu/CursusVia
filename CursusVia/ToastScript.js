let toastCounter = 1; // give unique class name

function makeToast(msg, type) {
    const toastClassName = `toast${++toastCounter}`;
    const newNode = document.querySelector(".toastWrapper").cloneNode(true);
    const toastContainer = document.querySelector(".toasts");
    toastContainer.appendChild(newNode);
    newNode.classList.add(toastClassName);
    newNode.querySelector(".toastMsg").innerText = msg;
    newNode.querySelector(".toastIcon").classList.add(type, "wiggleMe");
    newNode.querySelector(".toastIcon > span").innerHTML = type === "success" ? "check" : "exclamation";
    newNode.classList.remove("hidden");
    newNode.classList.add("slideInNOut");
    setTimeout(() => toastContainer.removeChild(newNode), 3800);
}
