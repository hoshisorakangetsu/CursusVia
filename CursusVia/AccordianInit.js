// include this file for those have accoridian functionality
document.querySelectorAll(".accordianActivator").forEach(el => {
    el.addEventListener("click", _e => {
        el.nextElementSibling.classList.toggle("accordianContentExpand")
    })
})