// use mutation observer to listen for style changes cuz dotnet with partial postback wont reexecute js, so cannot just loop through the list of elements and check style, this js file is only executed once when the page loads for the first time, so instead, listen for changes in style to detect the appearance of the validation message
const observer = new MutationObserver(mutations => {
    mutations.forEach(mutationRecord => {
        console.log(mutationRecord, mutationRecord.target.style.visibility);
        if (mutationRecord.target.style.visibility === 'visible')
            mutationRecord.target.parentElement.classList.add('validationError')
    });    
});

const targets = document.querySelectorAll('.validationMessage');
targets.forEach(target => {
    observer.observe(target, { attributes : true, attributeFilter : ['style'] });
})