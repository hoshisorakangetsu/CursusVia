const courseCategoryScroller = document.querySelector("#courseCategoryScroller")
const courseCategoryCard = document.querySelector(".courseCategoryCard") // use to get size to know how much to scroll

document.querySelector("#scrollLeft").addEventListener("click", (_ev) => {
    courseCategoryScroller.scrollTo({
        left: courseCategoryScroller.scrollLeft - courseCategoryCard.clientWidth, // specific values are scary (only tested on my laptop)
        behavior: "smooth"
    })
})

document.querySelector("#scrollRight").addEventListener("click", (_ev) => {
    courseCategoryScroller.scrollTo({
        left: courseCategoryScroller.scrollLeft + courseCategoryCard.clientWidth, // specific values are scary (only tested on my laptop)
        behavior: "smooth"
    })
})