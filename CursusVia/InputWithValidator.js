// use mutation observer to listen for style changes cuz dotnet with partial postback wont reexecute js, so cannot just loop through the list of elements and check style, this js file is only executed once when the page loads for the first time, so instead, listen for changes in style to detect the appearance of the validation message
const observer = new MutationObserver(mutations => {
    mutations.forEach(mutationRecord => {
        console.log(mutationRecord, mutationRecord.target.style.display);
        const target = mutationRecord.target;
        const targetParent = target.parentElement;
        if (target.style.display !== 'none')
            targetParent.classList.add('validationError')
        else if (
            target.style.display !== 'none' &&
            targetParent.classList.contains('validationError') &&
            targetParent
                .querySelectorAll('.validationMessage')?.every(vm => vm.style.display === 'none')
        )
            targetParent.classList.remove('validationError')
    });
});

const targets = document.querySelectorAll('.validationMessage');
targets.forEach(target => {
    observer.observe(target, { attributes: true, attributeFilter: ['style'] });
})