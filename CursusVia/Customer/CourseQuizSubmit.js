function submitQuiz(e) {
    e.preventDefault();
    const requests = [];
    // get all the questions
    const questions = document.querySelectorAll(".question");
    questions.forEach(questionDiv => {
        // question id is accessible through data-qid
        console.log(questionDiv.dataset.qid);
        const qid = questionDiv.dataset.qid;

        // the divs containing the answers
        const answers = questionDiv.querySelectorAll(".questionAnswer");

        // create xhr
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/Customer/GetCustomerQuizDetail.ashx');

        //Send the proper header information along with the request
        xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                const status = xhr.status;
                if (status === 0 || (status >= 200 && status < 400)) {
                    const correctAnswers = JSON.parse(xhr.responseText);
                    console.log(correctAnswers);
                    answers.forEach(ans => {
                        const chkBox = ans.querySelector("input[type=checkbox]");
                        console.log(correctAnswers, chkBox.value);
                        // disable all answers first
                        chkBox.disabled = true;
                        // check if is correct answer id add a correctAnswer class to it
                        if (correctAnswers.includes(parseInt(chkBox.value))) {
                            ans.classList.add("correctAnswer");
                        } else if (chkBox.checked) {
                            // if correct answer list dont have this but user still selected, make it wrongAnswer
                            ans.classList.add("wrongAnswer");
                        }

                        // remove loading overlay after all request complete
                    });
                }
                if (requests.every(req => req.readyState === XMLHttpRequest.DONE))
                    document.querySelector(".loading").classList.remove("appearOverlay");
            }
        }
        xhr.send(`questionId=${qid}`);
        document.querySelector(".loading").classList.add("appearOverlay");
        requests.push(xhr);
    });
}