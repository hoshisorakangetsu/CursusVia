function openModal(modal) {
    modal.classList.add("appear");
}

function closeModal(modal) {
    modal.classList.add("closing");
    setTimeout(() => {
        modal.classList.remove("closing");
        modal.classList.remove("appear");
    }, 500); // the animation time
}
